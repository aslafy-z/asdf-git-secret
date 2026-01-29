# Contributing

Thanks for considering contributing to asdf-git-secret! 

## Development Setup

1. Fork and clone the repository
2. Install asdf or mise
3. Install dependencies (see README.md)

## Testing Changes

### Manual Testing

```bash
# Add your local plugin
asdf plugin add git-secret /path/to/your/asdf-git-secret

# Install a version
asdf install git-secret 0.5.0

# Test it
asdf shell git-secret 0.5.0
git-secret --version

# Clean up
asdf plugin remove git-secret
```

### With mise

```bash
# Add to your mise.toml
[plugins]
git-secret = "/path/to/your/asdf-git-secret"

# Install
mise install

# Test
git-secret --version
```

## Code Standards

- Follow existing code style
- Use shellcheck to lint bash scripts: `shellcheck bin/* lib/*.bash`
- Ensure scripts are executable: `chmod +x bin/*`
- Test with multiple git-secret versions

## Pull Request Process

1. Update the README.md with details of changes if applicable
2. Test the plugin with at least one git-secret version
3. Ensure scripts pass shellcheck
4. Update version numbers following [SemVer](http://semver.org/)

## Reporting Issues

When reporting issues, please include:

- Your OS and version
- asdf/mise version
- git-secret version you're trying to install
- Full error output
- Steps to reproduce

## Questions?

Feel free to open an issue for questions or discussions.
