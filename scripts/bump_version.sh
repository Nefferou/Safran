#!/bin/bash
set -e

echo "🔍 Recherche du label de version..."

LABELS=$(gh pr view "$PR_NUMBER" --json labels --jq '.labels[].name')
echo "Labels trouvés : $LABELS"

if echo "$LABELS" | grep -q "fix"; then
  bump="patch"
elif echo "$LABELS" | grep -q "feature"; then
  bump="minor"
elif echo "$LABELS" | grep -q "major"; then
  bump="major"
else
  echo "❌ Aucun label de version valide trouvé."
  exit 1
fi

# Lire la version actuelle
VERSION_FILE="safran/pubspec.yaml"
current_version=$(grep '^version: ' $VERSION_FILE | awk '{print $2}' | cut -d+ -f1)
IFS='.' read -r major minor patch <<< "$current_version"

case $bump in
  patch)
    patch=$((patch + 1))
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
esac

new_version="${major}.${minor}.${patch}"

# Mise à jour du fichier pubspec.yaml
sed -i "s/^version: .*/version: $new_version+1/" "$VERSION_FILE"

# Création du tag conditionnel
if [[ "$GITHUB_REF_NAME" == "dev" ]]; then
  git config user.name "github-actions"
  git config user.email "github-actions@github.com"
  git tag "v$new_version-dev"
  git push origin "v$new_version-dev"
elif [[ "$GITHUB_REF_NAME" == "main" ]]; then
  git config user.name "github-actions"
  git config user.email "github-actions@github.com"
  git tag "v$new_version"
  git push origin "v$new_version"
fi

echo "✅ Version mise à jour : $new_version"
echo "version=$new_version" >> $GITHUB_OUTPUT
