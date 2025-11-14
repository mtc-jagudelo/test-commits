#!/usr/bin/env bash

# ---- Compatibilidad Windows/Linux/Mac ----
# Git Bash, WSL y PowerShell con Git lo interpretan correctamente.

clear

echo "======================================="
echo "     WORKFLOW AUTOMATION TOOL"
echo "======================================="

# ---- Preguntar por la branch ----
read -p "Ingresa el nombre de la rama personal (ej: dev/mtc-<usuario>): " BRANCH

if [[ -z "$BRANCH" ]]; then
  echo "❌ Error: no ingresaste un nombre de rama."
  exit 1
fi

# ---- Menu interactivo ----
while true; do
  echo ""
  echo "---------------------------------------"
  echo "Selecciona una opción:"
  echo "1) Finalizar tarea y preparar entorno para la siguiente"
  echo "2) Solo sincronizar main"
  echo "3) Salir"
  echo "---------------------------------------"
  read -p "Opción: " OPTION

  case $OPTION in
    1)
      echo "🔄 Cambiando a main..."
      git checkout main

      echo "⬇️ Trayendo últimos cambios..."
      git pull origin main

      echo "🗑 Eliminando rama local: $BRANCH (solo local, remoto sigue igual)..."
      git branch -D "$BRANCH" 2>/dev/null

      echo "🌱 Creando nueva rama desde main: $BRANCH"
      git checkout -b "$BRANCH"

      echo "✅ Listo. Ya puedes empezar la nueva tarea en la rama limpia: $BRANCH"
      ;;
    2)
      echo "🔄 Cambiando a main..."
      git checkout main

      echo "⬇️ Sincronizando main..."
      git pull origin main

      echo "✅ Main actualizado."
      ;;
    3)
      echo "👋 Saliendo..."
      exit 0
      ;;
    *)
      echo "❌ Opción inválida, intenta de nuevo."
      ;;
  esac
done
