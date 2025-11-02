#!/usr/bin/env bash
# set -e

# Get current version
if [ -n "$CURRENT_VERSION" ]; then
  current="$CURRENT_VERSION"
else
  git fetch --tags
  current=$(git describe --tags --abbrev=0 2>/dev/null || echo "${TAG_PREFIX}0.0.0")
fi

# Fallback if still empty or invalid
if [[ -z "$current" || "$current" == "${TAG_PREFIX}" ]]; then
  echo "⚠️  No valid current version found, defaulting to ${TAG_PREFIX}0.0.0"
  current="${TAG_PREFIX}0.0.0"
fi


# Remove prefix
current=${current#"$TAG_PREFIX"}

# Parse version
IFS='.' read -r major minor patch <<<"${current}"

# Remove any pre-release suffix from patch
patch=${patch%%-*}

# Calculate next version
case $VERSION_LEVEL in
  major)
    ((major++))
    minor=0
    patch=0
    ;;
  minor)
    ((minor++))
    patch=0
    ;;
  patch)
    ((patch++))
    ;;
  alpha|beta|rc|dev)
    ((patch++))
    patch="${patch}-${VERSION_LEVEL}"
    ;;
  *)
    echo "❌ Invalid version level: $VERSION_LEVEL" >&2
    exit 1
    ;;
esac

new_version="${major}.${minor}.${patch}"
tag_name="${TAG_PREFIX}${new_version}"

# Detect pre-release
if [[ "$new_version" == *"-alpha"* ]] || [[ "$new_version" == *"-beta"* ]] || [[ "$new_version" == *"-rc"* ]] || [[ "$new_version" == *"-dev"* ]]; then
  is_prerelease="true"
else
  is_prerelease="false"
fi

# Output
echo "version=${new_version}" >> $GITHUB_OUTPUT
echo "tag_name=${tag_name}" >> $GITHUB_OUTPUT
echo "is_prerelease=${is_prerelease}" >> $GITHUB_OUTPUT

echo "📦 New version: ${tag_name}"
echo "🏷️  Pre-release: ${is_prerelease}"
