// Clase para manejar las transacciones
class ExpenseTracker {
    constructor() {
        this.transactions = this.loadTransactions();
        this.init();
    }

    init() {
        // Establecer fecha actual por defecto
        document.getElementById('date').valueAsDate = new Date();
        
        // Event listeners
        document.getElementById('transaction-form').addEventListener('submit', (e) => this.addTransaction(e));
        document.getElementById('filter-category').addEventListener('change', () => this.renderTransactions());
        document.getElementById('export-btn').addEventListener('click', () => this.exportData());
        
        // Renderizar transacciones iniciales
        this.renderTransactions();
        this.updateBalance();
    }

    loadTransactions() {
        const saved = localStorage.getItem('transactions');
        return saved ? JSON.parse(saved) : [];
    }

    saveTransactions() {
        localStorage.setItem('transactions', JSON.stringify(this.transactions));
    }

    addTransaction(e) {
        e.preventDefault();
        
        const description = document.getElementById('description').value;
        const amount = parseFloat(document.getElementById('amount').value);
        const category = document.getElementById('category').value;
        const date = document.getElementById('date').value;
        
        const transaction = {
            id: Date.now(),
            description,
            amount: category === 'ingreso' ? amount : -amount,
            category,
            date,
            timestamp: new Date().toISOString()
        };
        
        this.transactions.unshift(transaction);
        this.saveTransactions();
        this.renderTransactions();
        this.updateBalance();
        
        // Limpiar formulario
        document.getElementById('transaction-form').reset();
        document.getElementById('date').valueAsDate = new Date();
        
        // Mostrar notificación
        this.showNotification('Transacción agregada exitosamente');
    }

    deleteTransaction(id) {
        if (confirm('¿Estás seguro de eliminar esta transacción?')) {
            this.transactions = this.transactions.filter(t => t.id !== id);
            this.saveTransactions();
            this.renderTransactions();
            this.updateBalance();
            this.showNotification('Transacción eliminada');
        }
    }

    renderTransactions() {
        const filter = document.getElementById('filter-category').value;
        const listContainer = document.getElementById('transactions-list');
        
        let filtered = this.transactions;
        if (filter !== 'all') {
            filtered = this.transactions.filter(t => t.category === filter);
        }
        
        if (filtered.length === 0) {
            listContainer.innerHTML = '<div class="empty-state">No hay transacciones para mostrar</div>';
            return;
        }
        
        listContainer.innerHTML = filtered.map(transaction => {
            const categoryEmoji = this.getCategoryEmoji(transaction.category);
            const amountClass = transaction.amount > 0 ? 'income' : 'expense';
            const formattedAmount = this.formatCurrency(Math.abs(transaction.amount));
            const formattedDate = new Date(transaction.date).toLocaleDateString('es-MX');
            
            return `
                <div class="transaction-item">
                    <div class="transaction-info">
                        <div class="transaction-description">${categoryEmoji} ${transaction.description}</div>
                        <div class="transaction-details">${formattedDate}</div>
                    </div>
                    <div>
                        <span class="transaction-amount ${amountClass}">
                            ${transaction.amount > 0 ? '+' : '-'}${formattedAmount}
                        </span>
                        <button class="delete-btn" onclick="tracker.deleteTransaction(${transaction.id})">
                            Eliminar
                        </button>
                    </div>
                </div>
            `;
        }).join('');
    }

    updateBalance() {
        const income = this.transactions
            .filter(t => t.amount > 0)
            .reduce((sum, t) => sum + t.amount, 0);
        
        const expenses = this.transactions
            .filter(t => t.amount < 0)
            .reduce((sum, t) => sum + Math.abs(t.amount), 0);
        
        const balance = income - expenses;
        
        document.getElementById('balance').textContent = this.formatCurrency(balance);
        document.getElementById('total-income').textContent = this.formatCurrency(income);
        document.getElementById('total-expense').textContent = this.formatCurrency(expenses);
        
        // Cambiar color del balance según sea positivo o negativo
        const balanceElement = document.getElementById('balance');
        if (balance >= 0) {
            balanceElement.style.color = 'white';
        } else {
            balanceElement.style.color = '#ffcdd2';
        }
    }

    formatCurrency(amount) {
        return new Intl.NumberFormat('es-MX', {
            style: 'currency',
            currency: 'MXN'
        }).format(amount);
    }

    getCategoryEmoji(category) {
        const emojis = {
            'ingreso': '💵',
            'comida': '🍔',
            'transporte': '🚗',
            'hogar': '🏠',
            'entretenimiento': '🎮',
            'salud': '🏥',
            'educacion': '📚',
            'otros': '📦'
        };
        return emojis[category] || '📦';
    }

    showNotification(message) {
        const notification = document.createElement('div');
        notification.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            background: #4CAF50;
            color: white;
            padding: 15px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
            z-index: 1000;
            animation: slideIn 0.3s ease-out;
        `;
        notification.textContent = message;
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.style.animation = 'slideOut 0.3s ease-in';
            setTimeout(() => notification.remove(), 300);
        }, 3000);
    }

    exportData() {
        const dataStr = JSON.stringify(this.transactions, null, 2);
        const dataBlob = new Blob([dataStr], { type: 'application/json' });
        const url = URL.createObjectURL(dataBlob);
        const link = document.createElement('a');
        link.href = url;
        link.download = `gastos_${new Date().toISOString().split('T')[0]}.json`;
        link.click();
        URL.revokeObjectURL(url);
        this.showNotification('Datos exportados exitosamente');
    }
}

// Agregar animaciones CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Inicializar la aplicación
const tracker = new ExpenseTracker();

// Service Worker para funcionar offline
if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register('sw.js').then(
            registration => console.log('SW registrado'),
            err => console.log('SW error:', err)
        );
    });
}