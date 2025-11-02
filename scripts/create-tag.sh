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

# Create tag
git tag -a "$TAG_NAME" -m "Release $TAG_NAME"
echo "✅ Created tag: $TAG_NAME"

# Push if requested
if [ "$PUSH" = "true" ]; then
  git push origin "$TAG_NAME"
  echo "✅ Pushed tag: $TAG_NAME"
fi
