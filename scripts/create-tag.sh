#!/usr/bin/env bash
set -e

# Configure git
if [ -n "${GITHUB_ACTOR}" ]; then
  git config user.name "${GITHUB_ACTOR}"
  git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
else
  git config user.name "github-actions[bot]"
  git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
fi

RAW_TAG="$TAG_NAME"

# Extract semver core + optional postfix (example: 1.2.3, 1.2.3-alpha, 1.2.3-rc1)
VERSION=$(echo "$RAW_TAG" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+(-[A-Za-z0-9\.]+)?')

# Remove prefix → keep only semver part + postfix
CLEAN_TAG="$VERSION"

# Prefix = everything before version
PREFIX="${RAW_TAG%"$VERSION"}"

# Create tag
git tag -a "$TAG_NAME" -m "Release version $VERSION"
echo "✅ Created tag: $TAG_NAME"

# Push if requested
if [ "$PUSH" = "true" ]; then
  git push origin "$TAG_NAME"
  echo "✅ Pushed tag: $TAG_NAME"
fi
