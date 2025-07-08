#!/bin/bash

# Par défaut, chemin du fichier pubspec
VERSION_FILE="../safran/pubspec.yaml"

# Le type de bump à faire : fix (patch), feature (minor), major
LABEL=$1

# Lire version actuelle (ex: 1.2.3)
VERSION=$(grep '^version:' "$VERSION_FILE" | cut -d' ' -f2 | cut -d'+' -f1)
IFS='.' read -r MAJOR MINOR PATCH <<< "$VERSION"

# Appliquer le bump selon le label
case "$LABEL" in
  fix)
    PATCH=$((PATCH + 1))
    ;;
  feature)
    MINOR=$((MINOR + 1))
    PATCH=0
    ;;
  major)
    MAJOR=$((MAJOR + 1))
    MINOR=0
    PATCH=0
    ;;
  *)
    echo "Type de bump inconnu. Utilise : fix, feature, major"
    exit 1
    ;;
esac

# Nouvelle version
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Remplacer dans pubspec.yaml (on garde le build number à +1)
sed -i.bak "s/^version: .*/version: ${NEW_VERSION}+1/" "$VERSION_FILE"

echo "Version bumpée : $NEW_VERSION"
