
#!/bin/bash
# Script para eliminar README.md, recrearlo y limpiar historial en un solo commit (para Codespaces)

# Verifica que estás en la raíz del repositorio
if [ ! -d ".git" ]; then
  echo "❌ Este script debe ejecutarse en la raíz de un repositorio Git."
  exit 1
fi

# Elimina README.md si existe
if [ -f "README.md" ]; then
  echo "🗑 Eliminando README.md..."
  git rm README.md
  git commit -m "Eliminar README.md"
else
  echo "ℹ️ No se encontró README.md, continuando..."
fi

# Crea un nuevo README.md con contenido básico
echo "# Nuevo README" > README.md
echo "✅ README.md creado con contenido básico."

# Añade y hace commit
git add README.md
git commit -m "Añadir README.md actualizado"

# Fusiona los últimos 2 commits en uno solo (fixup automático)
echo "🔄 Limpiando historial..."
GIT_SEQUENCE_EDITOR=: git rebase -i HEAD~2 <<EOF
pick $(git rev-parse HEAD~2)
fixup $(git rev-parse HEAD~1)
EOF

# Forzar push al remoto
git push --force

echo "✅ Proceso completado: README.md actualizado y historial limpio."
