#!/bin/bash
set -e

LABEL=$1
SUFFIX=$2  # ex: "-dev" ou vide

# Lire la version actuelle
VERSION_FILE="safran/pubspec.yaml"
CURRENT_VERSION=$(grep '^version:' $VERSION_FILE | cut -d' ' -f2 | cut -d+ -f1)
IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT_VERSION"

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
    echo "❌ Label non reconnu. Utilise fix, feature ou major."
    exit 1
    ;;
esac

# Construire la nouvelle version
NEW_VERSION="${MAJOR}.${MINOR}.${PATCH}"

# Écrire la nouvelle version dans pubspec.yaml
sed -i "s/^version: .*/version: ${NEW_VERSION}+1/" "$VERSION_FILE"

echo "✅ Nouvelle version: $NEW_VERSION$SUFFIX"
echo "version=$NEW_VERSION" >> $GITHUB_OUTPUT
