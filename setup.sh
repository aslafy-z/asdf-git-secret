#!/usr/bin/env bash
# Quick setup script for asdf-git-secret plugin

set -euo pipefail

REPO_URL="https://github.com/aslafy-z/asdf-git-secret.git"

echo "🔧 asdf-git-secret Plugin Setup"
echo "================================"
echo ""

# Detect if using asdf or mise
if command -v mise &> /dev/null; then
  TOOL="mise"
elif command -v asdf &> /dev/null; then
  TOOL="asdf"
else
  echo "❌ Error: Neither asdf nor mise is installed"
  echo ""
  echo "Please install one of the following:"
  echo "  - asdf: https://asdf-vm.com/guide/getting-started.html"
  echo "  - mise: https://mise.jdx.dev/getting-started.html"
  exit 1
fi

echo "✓ Detected: $TOOL"
echo ""

# Check dependencies
echo "Checking dependencies..."
MISSING_DEPS=()

for cmd in git make gawk gpg; do
  if ! command -v "$cmd" &> /dev/null; then
    MISSING_DEPS+=("$cmd")
  fi
done

if [ ${#MISSING_DEPS[@]} -gt 0 ]; then
  echo "❌ Missing dependencies: ${MISSING_DEPS[*]}"
  echo ""
  echo "Please install them first:"
  echo ""
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  brew install gnupg gawk"
  elif [[ -f /etc/debian_version ]]; then
    echo "  sudo apt-get install gnupg gawk make"
  elif [[ -f /etc/redhat-release ]]; then
    echo "  sudo dnf install gnupg2 gawk make"
  elif [[ -f /etc/alpine-release ]]; then
    echo "  sudo apk add gnupg gawk make"
  else
    echo "  Install: git, make, gawk, gnupg"
  fi
  exit 1
fi

echo "✓ All dependencies installed"
echo ""

# Add plugin
echo "Adding asdf-git-secret plugin..."
if [ "$TOOL" = "mise" ]; then
  mise plugins install git-secret "$REPO_URL" 2> /dev/null || true
else
  asdf plugin add git-secret "$REPO_URL" 2> /dev/null || true
fi

echo "✓ Plugin added"
echo ""

# Install latest version
echo "Installing latest git-secret version..."
if [ "$TOOL" = "mise" ]; then
  mise install git-secret@latest
  mise use -g git-secret@latest
else
  asdf install git-secret latest
  asdf global git-secret latest
fi

echo "✓ git-secret installed"
echo ""

# Verify
echo "Verifying installation..."
if command -v git-secret &> /dev/null; then
  VERSION=$(git-secret --version)
  echo "✓ git-secret is ready: $VERSION"
  echo ""
  echo "🎉 Setup complete!"
  echo ""
  echo "Try it out:"
  echo "  git secret init"
  echo "  git secret --help"
else
  echo "❌ git-secret command not found"
  echo ""
  echo "You may need to restart your shell or run:"
  if [ "$TOOL" = "mise" ]; then
    echo "  mise reshim"
  else
    echo "  asdf reshim git-secret"
  fi
fi
