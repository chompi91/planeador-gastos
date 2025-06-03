import base64

# Crear SVG para los iconos
svg_icon = '''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
  <rect width="512" height="512" fill="#4CAF50"/>
  <circle cx="256" cy="256" r="170" fill="white"/>
  <text x="256" y="256" font-family="Arial, sans-serif" font-size="200" font-weight="bold" 
        text-anchor="middle" dominant-baseline="middle" fill="#4CAF50">$</text>
</svg>'''

# Guardar como archivo SVG temporal para conversión
with open('icon-temp.svg', 'w') as f:
    f.write(svg_icon)

print("Iconos creados - Convierte icon-temp.svg a PNG en tamaños 192x192 y 512x512")