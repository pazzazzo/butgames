#!/bin/bash

# Ce script a soigneusement été crée par Lorenzo Azzopardi et Angelo Chauvin.

# Vérifie si le répertoire courant est un dépôt Git
if [ ! -d .git ]; then
  echo "Ce répertoire n'est pas un dépôt Git."
  exit 1
fi

# Affiche la branche actuelle
branch=$(git rev-parse --abbrev-ref HEAD)
echo "Branche actuelle : $branch"

# Affiche les commits en avance/en retard par rapport à l'origin
git remote update > /dev/null 2>&1
ahead=$(git rev-list --count --left-right @{u}...HEAD 2>/dev/null | cut -f1)
behind=$(git rev-list --count --left-right @{u}...HEAD 2>/dev/null | cut -f2)
if [ -n "$ahead" ] || [ -n "$behind" ]; then
  echo "Commits en avance sur l'origin : $ahead"
  echo "Commits en retard par rapport à l'origin : $behind"
else
  echo "Aucun suivi distant défini ou synchronisé."
fi

# Affiche les fichiers modifiés, ajoutés, ou supprimés
status=$(git status --short)
if [ -n "$status" ]; then
  echo "Fichiers modifiés ou en attente de validation :"
  echo "$status"
else
  echo "Aucune modification détectée."
fi
