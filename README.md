# Semantic Version Tag Action

[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Semantic%20Version%20Tag-blue.svg)](https://github.com/marketplace/actions/semantic-version-tag)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Automatically create semantic version tags with intelligent pre-release detection.

## ✨ Features

- 🎯 **Semantic Versioning**: Support for major, minor, and patch bumps
- 🚀 **Pre-release Support**: Alpha, beta, RC, and dev versions
- 🤖 **Auto-detection**: Automatically detect current version from git tags
- 🔧 **Customizable**: Custom tag prefixes and options
- 📤 **Optional Push**: Choose to push immediately or create locally
- 🎨 **Rich Outputs**: Use outputs in subsequent workflow steps

## 📖 Usage

### Basic Example

```yaml
- name: Create version tag
  uses: anantakumarghosh/semver-tag-action@v1
  with:
    version-level: patch
```

## 📥 Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `version-level` | Version bump level | ✅ Yes | - |
| `current-version` | Current version | ❌ No | Auto-detect |
| `tag-prefix` | Prefix for version tags | ❌ No | `v` |
| `push` | Push the tag to remote | ❌ No | `true` |
| `token` | GitHub token | ❌ No | `${{ github.token }}` |

## 📤 Outputs

| Output | Description |
|--------|-------------|
| `new-version` | The new version created |
| `is-prerelease` | Whether this is a pre-release |
| `tag-name` | Full tag name with prefix |

## 📄 License

MIT License - see LICENSE for details.
