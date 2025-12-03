
#!/bin/bash
# Script para restaurar todos los archivos actuales y subirlos en un solo commit

# Verifica que no haya un .git previo (porque lo borramos antes)
if [ -d ".git" ]; then
  echo "❌ Ya existe un repositorio Git aquí. Si quieres reiniciar, elimina .git primero."
  exit 1
fi

# Obtén la URL del remoto (debes saberla)
read -p "Introduce la URL del remoto (origin): " REMOTE_URL
if [ -z "$REMOTE_URL" ]; then
  echo "❌ No se proporcionó una URL remota."
  exit 1
fi

echo "🔄 Inicializando nuevo repositorio..."
git init
git remote add origin "$REMOTE_URL"

# Añade todos los archivos actuales
echo "📂 Añadiendo todos los archivos del proyecto..."
git add .

# Crea el commit único
git commit -m "Restauración completa del proyecto en un solo commit"

# Configura la rama principal y fuerza el push
git branch -M main
git push --force origin main

echo "✅ Todos los archivos actuales se han restaurado y subido en un solo commit."
