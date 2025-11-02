#!/usr/bin/env bash
set -e

# Configure git
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"

# Create tag
git tag -a "$TAG_NAME" -m "Release $TAG_NAME"
echo "✅ Created tag: $TAG_NAME"

# Push if requested
if [ "$PUSH" = "true" ]; then
  git push origin "$TAG_NAME"
  echo "✅ Pushed tag: $TAG_NAME"
fi