# asdf-git-secret

[![Build](https://github.com/aslafy-z/asdf-git-secret/actions/workflows/build.yml/badge.svg)](https://github.com/aslafy-z/asdf-git-secret/actions/workflows/build.yml)
[![Lint](https://github.com/aslafy-z/asdf-git-secret/actions/workflows/lint.yml/badge.svg)](https://github.com/aslafy-z/asdf-git-secret/actions/workflows/lint.yml)

[git-secret](https://sobolevn.me/git-secret/) plugin for the [asdf version manager](https://asdf-vm.com).

## Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

## Dependencies

- `bash`, `curl`, `tar`, `git`: generic POSIX utilities
- `make`: for building git-secret from source
- `gawk`: GNU awk (required by git-secret)
- `gnupg` or `gnupg2`: GPG encryption tool (required by git-secret)

### Installing Dependencies

#### macOS

```bash
brew install coreutils curl git gnupg gawk
```

#### Ubuntu/Debian

```bash
sudo apt-get install curl git gnupg gawk make
```

#### Fedora/RHEL/CentOS

```bash
sudo dnf install curl git gnupg2 gawk make
```

#### Alpine

```bash
sudo apk add bash curl git gnupg gawk make
```

## Install

### asdf

Plugin:

```bash
asdf plugin add git-secret https://github.com/aslafy-z/asdf-git-secret.git
```

git-secret:

```bash
# Show all installable versions
asdf list-all git-secret

# Install specific version
asdf install git-secret latest

# Set a version globally (on your ~/.tool-versions file)
asdf global git-secret latest

# Now git-secret commands are available
git-secret --version
```

### mise (recommended)

Add to your `mise.toml`:

```toml
[tools]
"asdf:git-secret" = "latest"

[plugins]
git-secret = "https://github.com/aslafy-z/asdf-git-secret.git"
```

Then run:

```bash
mise install
```

Check [asdf](https://github.com/asdf-vm/asdf) or [mise](https://mise.jdx.dev/) readme for more instructions on how to install & manage versions.

## Usage

After installation, you can use git-secret commands:

```bash
# Initialize git-secret in your repository
cd your-repo
git secret init

# Add a GPG user
git secret tell user@example.com

# Add files to be encrypted
git secret add config/database.yml
git secret add .env

# Encrypt all secret files
git secret hide

# Decrypt secret files (requires your private key)
git secret reveal

# List all secret files
git secret list

# Remove a user
git secret removeperson user@example.com

# Show who has access
git secret whoknows
```

For more information, see the [official git-secret documentation](https://sobolevn.me/git-secret/).

## How It Works

This plugin:

1. **Downloads** the git-secret source code from GitHub releases
2. **Builds** it using `make build` 
3. **Installs** it to the asdf installation directory using `make install`
4. **Manages** multiple versions side-by-side

The installation process follows the same method as the Homebrew formula, ensuring consistency across platforms.

## Version Support

This plugin supports all git-secret versions that are tagged in the [official repository](https://github.com/sobolevn/git-secret/tags).

To see available versions:

```bash
asdf list-all git-secret
```

## Troubleshooting

### Build Failures

If installation fails, ensure all dependencies are installed:

```bash
# Check required commands
which git
which make
which gawk
which gpg  # or gpg2
```

### Command Not Found

After installation, if `git-secret` is not found:

```bash
# Verify installation
asdf current git-secret

# Reshim asdf
asdf reshim git-secret

# For mise users
mise doctor
```

## Contributing

Contributions of any kind welcome! See the [contributing guide](CONTRIBUTING.md).

[Thanks goes to these contributors](https://github.com/aslafy-z/asdf-git-secret/graphs/contributors)!

## License

See [LICENSE](LICENSE) © [Your Name](https://github.com/aslafy-z/)

## Acknowledgments

- [asdf-plugin-template](https://github.com/asdf-vm/asdf-plugin-template) - Template used to create this plugin
- [git-secret](https://github.com/sobolevn/git-secret) - The actual tool this plugin installs
