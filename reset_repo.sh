
#!/bin/bash
# Script para borrar todo el historial y dejar solo un README.md en Codespaces

# Verifica que estás en la raíz del repositorio
if [ ! -d ".git" ]; then
  echo "❌ Este script debe ejecutarse en la raíz de un repositorio Git."
  exit 1
fi

# Pide confirmación antes de borrar todo
read -p "⚠️ Esto eliminará TODO el historial. ¿Seguro? (escribe 'SI' para continuar): " confirm
if [ "$confirm" != "SI" ]; then
  echo "❌ Operación cancelada."
  exit 1
fi

# Obtén la URL del remoto actual
REMOTE_URL=$(git remote get-url origin)
if [ -z "$REMOTE_URL" ]; then
  echo "❌ No se encontró un remoto llamado 'origin'."
  exit 1
fi

echo "🗑 Eliminando historial..."
rm -rf .git

echo "🔄 Reiniciando repositorio..."
git init
git remote add origin "$REMOTE_URL"

# Crea un nuevo README.md
echo "# Nuevo README" > README.md
echo "✅ README.md creado."

# Añade y hace commit inicial
git add README.md
git commit -m "Initial commit con README actualizado"

# Configura la rama principal y fuerza el push
git branch -M main
git push --force origin main

echo "✅ Repositorio reiniciado con un solo commit y README.md actualizado."