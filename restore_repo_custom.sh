
#!/bin/bash
# Script para restaurar todos los archivos actuales y subirlos en un solo commit con mensaje personalizado

# Verifica que no haya un .git previo
if [ -d ".git" ]; then
  echo "❌ Ya existe un repositorio Git aquí. Si quieres reiniciar, elimina .git primero."
  exit 1
fi

# Solicita la URL del remoto
read -p "Introduce la URL del remoto (origin): " REMOTE_URL
if [ -z "$REMOTE_URL" ]; then
  echo "❌ No se proporcionó una URL remota."
  exit 1
fi

# Solicita el mensaje del commit
read -p "Introduce el mensaje para el commit: " COMMIT_MSG
if [ -z "$COMMIT_MSG" ]; then
  COMMIT_MSG="Restauración completa del proyecto"
fi

echo "🔄 Inicializando nuevo repositorio..."
git init
git remote add origin "$REMOTE_URL"

# Añade todos los archivos actuales
echo "📂 Añadiendo todos los archivos del proyecto..."
git add .

# Crea el commit único con mensaje personalizado
git commit -m "$COMMIT_MSG"

# Configura la rama principal y fuerza el push
git branch -M main
git push --force origin main

echo "✅ Todos los archivos actuales se han restaurado y subido en un solo commit con el mensaje: '$COMMIT_MSG'"
