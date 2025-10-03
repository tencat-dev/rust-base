# 🦀 Rust Base Template

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/yourusername/rust-base)
[![Rust Version](https://img.shields.io/badge/rust-1.90.0-orange.svg)](https://www.rust-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)
[![devenv](https://img.shields.io/badge/devenv-enabled-purple.svg)](https://devenv.sh/)

A modern, production-ready Rust boilerplate template designed to kickstart your next Rust project with best practices, modern tooling, and a batteries-included development environment.

## 🚀 Features

- **Modern Rust**: Uses Rust 2024 edition with the latest stable toolchain
- **Async Runtime**: Pre-configured with Tokio for high-performance async applications
- **Environment Management**: Secure configuration handling with dotenvy
- **Development Environment**: Reproducible dev setup using devenv (Nix-based)
- **Docker Ready**: Multi-stage Dockerfile optimized for fast builds and small images
- **Code Quality**: Pre-configured with rustfmt, clippy, and rust-analyzer
- **Cross-platform**: Supports multiple targets including musl for static linking

## 📋 Table of Contents

- [Quick Start](#-quick-start)
- [Installation](#-installation)
- [Project Structure](#-project-structure)
- [Development Setup](#-development-setup)
- [Configuration](#-configuration)
- [Building & Running](#-building--running)
- [Docker Usage](#-docker-usage)
- [Testing](#-testing)
- [Available Scripts](#-available-scripts)
- [Dependencies](#-dependencies)
- [Architecture & Design](#-architecture--design)
- [Best Practices](#-best-practices)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

## 🏃 Quick Start

```bash
# Clone the template
git clone https://github.com/yourusername/rust-base.git my-project
cd my-project

# Set up environment variables
cp .env.example .env

# Option 1: Using devenv (recommended)
devenv shell
cargo run

# Option 2: Using cargo directly (requires Rust installed)
cargo run

# Option 3: Using Docker
docker build -t my-project .
docker run --env-file .env my-project
```

## 📦 Installation

### Prerequisites

Choose one of the following installation methods:

#### Method 1: devenv (Recommended)

- [Nix](https://nixos.org/download/) package manager
- [devenv](https://devenv.sh/getting-started/) development environment

#### Method 2: Local Rust Installation

- [Rust](https://rustup.rs/) (1.90.0 or later)
- [cargo](https://doc.rust-lang.org/cargo/) package manager

#### Method 3: Docker Only

- [Docker](https://docs.docker.com/get-docker/) (20.10 or later)

### Setup Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/rust-base.git your-project-name
   cd your-project-name
   ```

2. **Environment configuration:**

   ```bash
   cp .env.example .env
   # Edit .env with your specific configuration
   ```

3. **Choose your development method:**

   **With devenv (Nix-based):**

   ```bash
   # Install nix if not already installed
   curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

   # Install devenv
   nix profile install --accept-flake-config nixpkgs#devenv

   # Enter development shell
   devenv shell
   ```

   **With local Rust:**

   ```bash
   # Install Rust via rustup
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   source ~/.cargo/env

   # Install required components
   rustup component add clippy rustfmt rust-analyzer
   ```

## 📁 Project Structure

```
rust-base/
├── src/
│   └── main.rs              # Application entry point
├── .env.example             # Environment variables template
├── .envrc                   # direnv configuration
├── .gitignore              # Git ignore rules
├── Cargo.toml              # Rust package manifest
├── Cargo.lock              # Dependency lock file
├── devenv.nix              # Development environment config
├── devenv.yaml             # devenv inputs configuration
├── devenv.lock             # Development environment lock file
├── Dockerfile              # Multi-stage Docker build
├── LICENSE                 # MIT License
└── README.md               # This file
```

### Key Files Explained

- **[`src/main.rs`](src/main.rs:1)**: The main application entry point with async Tokio runtime
- **[`Cargo.toml`](Cargo.toml:1)**: Package configuration and dependencies
- **[`devenv.nix`](devenv.nix:1)**: Reproducible development environment using Nix
- **[`Dockerfile`](Dockerfile:1)**: Optimized multi-stage Docker build with cargo-chef
- **[`.env.example`](.env.example:1)**: Template for environment variables

## 🛠 Development Setup

### Using devenv (Recommended)

The project uses [devenv](https://devenv.sh/) for reproducible development environments:

```bash
# Enter the development shell
devenv shell

# The environment provides:
# - Rust 1.90.0 with stable channel
# - cargo, clippy, rustfmt, rust-analyzer
# - Git and other development tools
# - Automatic environment variable loading
```

### Manual Setup

If you prefer not to use devenv:

```bash
# Install Rust components
rustup component add clippy rustfmt rust-analyzer

# Install additional tools (optional)
cargo install cargo-watch cargo-audit cargo-deny
```

### Editor Configuration

**VS Code:**
Install the following extensions:

- rust-analyzer
- CodeLLDB (for debugging)
- Better TOML

**Other editors:**
The project works with any editor that supports rust-analyzer LSP.

## ⚙️ Configuration

### Environment Variables

Copy [`.env.example`](.env.example:1) to `.env` and configure:

```bash
# .env
HOST=your-host.com
PORT=8080
RUST_LOG=info
DATABASE_URL=postgresql://user:pass@localhost/db
```

### Cargo Configuration

The [`Cargo.toml`](Cargo.toml:1) includes:

- **tokio**: Async runtime with macros and multi-threading
- **dotenvy**: Environment variable loading
- **Rust 2024 edition**: Latest language features

### Adding Dependencies

```bash
# Add a new dependency
cargo add serde --features derive

# Add a development dependency
cargo add --dev proptest

# Add a build dependency
cargo add --build cc
```

## 🔨 Building & Running

### Development

```bash
# Run in development mode
cargo run

# Run with file watching (requires cargo-watch)
cargo watch -x run

# Run with specific environment
RUST_LOG=debug cargo run
```

### Production Build

```bash
# Build optimized release
cargo build --release

# Run release binary
./target/release/rust-base

# Build for different target
cargo build --release --target x86_64-unknown-linux-musl
```

### Cross-compilation

The project supports multiple targets:

```bash
# Add target
rustup target add x86_64-pc-windows-gnu

# Build for Windows
cargo build --target x86_64-pc-windows-gnu

# Build for ARM64
rustup target add aarch64-unknown-linux-gnu
cargo build --target aarch64-unknown-linux-gnu
```

## 🐳 Docker Usage

### Building the Image

```bash
# Build with default settings
docker build -t rust-base .

# Build with custom Rust version
docker build --build-arg RUST_VERSION=1.91 -t rust-base .

# Build for different target
docker build --build-arg RUST_TARGET=aarch64-unknown-linux-musl -t rust-base .
```

### Running the Container

```bash
# Run with environment file
docker run --env-file .env rust-base

# Run with individual environment variables
docker run -e HOST=production.com rust-base

# Run interactively
docker run -it --env-file .env rust-base

# Run with volume mounts
docker run -v $(pwd)/data:/app/data --env-file .env rust-base
```

### Docker Features

- **Multi-stage build**: Optimized for size and security
- **cargo-chef**: Faster builds with dependency caching
- **sccache**: Compilation caching for repeated builds
- **Static linking**: musl target for smaller, portable binaries
- **Non-root user**: Security best practices

## 🧪 Testing

### Running Tests

```bash
# Run all tests
cargo test

# Run tests with output
cargo test -- --nocapture

# Run specific test
cargo test test_name

# Run tests in release mode
cargo test --release

# Run integration tests
cargo test --test integration_test
```

### Test Organization

```rust
// Unit tests in src files
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_example() {
        assert_eq!(2 + 2, 4);
    }

    #[tokio::test]
    async fn test_async_example() {
        // Async test code
    }
}
```

### Integration Tests

Create files in `tests/` directory:

```rust
// tests/integration_test.rs
use rust_base::*;

#[tokio::test]
async fn test_integration() {
    // Integration test code
}
```

## 📜 Available Scripts

### Cargo Commands

```bash
# Development
cargo run                    # Run the application
cargo run --bin binary_name  # Run specific binary
cargo watch -x run          # Run with auto-reload

# Building
cargo build                  # Debug build
cargo build --release       # Release build
cargo check                  # Fast compilation check

# Testing
cargo test                   # Run tests
cargo test --doc            # Run doc tests
cargo bench                 # Run benchmarks

# Code Quality
cargo fmt                   # Format code
cargo clippy                # Lint code
cargo clippy -- -D warnings # Lint with warnings as errors

# Documentation
cargo doc                   # Generate documentation
cargo doc --open            # Generate and open docs

# Maintenance
cargo update                # Update dependencies
cargo audit                 # Security audit (requires cargo-audit)
cargo deny check            # License and security checks
```

### devenv Commands

```bash
devenv shell               # Enter development shell
devenv up                  # Start background services
devenv test                # Run environment tests
devenv info                # Show environment info
```

## 📚 Dependencies

### Runtime Dependencies

| Crate                                         | Version | Purpose                      |
| --------------------------------------------- | ------- | ---------------------------- |
| [`tokio`](https://tokio.rs/)                  | 1.x     | Async runtime and utilities  |
| [`dotenvy`](https://crates.io/crates/dotenvy) | 0.15.7  | Environment variable loading |

### Development Dependencies

The devenv configuration provides:

- Rust 1.90.0 with stable toolchain
- cargo, clippy, rustfmt, rust-analyzer
- Git version control
- Additional Nix packages as needed

### Recommended Additional Crates

Consider adding these popular crates based on your needs:

```toml
# Web frameworks
axum = "0.7"                 # Modern async web framework
warp = "0.3"                 # Lightweight web server

# Serialization
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"

# Database
sqlx = { version = "0.7", features = ["runtime-tokio-rustls", "postgres"] }
diesel = { version = "2.1", features = ["postgres"] }

# Error handling
anyhow = "1.0"               # Easy error handling
thiserror = "1.0"           # Custom error types

# Logging
tracing = "0.1"              # Structured logging
tracing-subscriber = "0.3"

# Configuration
config = "0.14"              # Configuration management
clap = { version = "4.0", features = ["derive"] }  # CLI parsing
```

## 🏗 Architecture & Design

### Design Principles

1. **Simplicity**: Start simple, evolve as needed
2. **Performance**: Async-first with Tokio runtime
3. **Security**: Environment-based configuration
4. **Portability**: Docker and cross-platform support
5. **Developer Experience**: Modern tooling and practices

### Architectural Patterns

#### Async/Await Pattern

```rust
#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    // Async application logic
    Ok(())
}
```

#### Environment Configuration

```rust
use std::env;

fn load_config() -> Config {
    dotenvy::dotenv().ok();

    Config {
        host: env::var("HOST").unwrap_or_else(|_| "localhost".to_string()),
        port: env::var("PORT")
            .unwrap_or_else(|_| "8080".to_string())
            .parse()
            .expect("PORT must be a number"),
    }
}
```

#### Error Handling

```rust
use anyhow::{Context, Result};

async fn process_data() -> Result<String> {
    let data = fetch_data()
        .await
        .context("Failed to fetch data")?;

    Ok(process(data))
}
```

### Project Organization

```
src/
├── main.rs              # Application entry point
├── lib.rs               # Library root (optional)
├── config/              # Configuration modules
│   ├── mod.rs
│   └── settings.rs
├── handlers/            # Request handlers
├── models/              # Data models
├── services/            # Business logic
└── utils/               # Utility functions
```

## 🎯 Best Practices

### Code Organization

1. **Module Structure**: Use clear module hierarchy
2. **Error Handling**: Prefer `Result<T, E>` over panics
3. **Documentation**: Document public APIs with `///`
4. **Testing**: Write unit and integration tests

### Performance Considerations

1. **Async Operations**: Use async/await for I/O operations
2. **Memory Management**: Leverage Rust's ownership system
3. **Compilation**: Use release builds for production
4. **Dependencies**: Keep dependencies minimal and up-to-date

### Security Best Practices

1. **Environment Variables**: Never commit secrets to version control
2. **Input Validation**: Validate all external inputs
3. **Dependencies**: Regularly audit with `cargo audit`
4. **Docker**: Use non-root users and minimal base images

### Development Workflow

```bash
# Before committing
cargo fmt                    # Format code
cargo clippy -- -D warnings # Check for issues
cargo test                   # Run tests
cargo audit                  # Security audit
```

### CI/CD Integration

Example GitHub Actions workflow:

```yaml
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: dtolnay/rust-toolchain@stable
      - run: cargo test --all-features
      - run: cargo clippy -- -D warnings
      - run: cargo fmt --all -- --check
```

## 🔧 Troubleshooting

### Common Issues

#### Environment Variables Not Loading

**Problem**: [`dotenvy::dotenv()`](src/main.rs:3) not finding `.env` file

**Solution**:

```bash
# Ensure .env file exists in project root
cp .env.example .env

# Check file permissions
ls -la .env

# Verify environment variables
cargo run -- --help  # if using clap
```

#### Compilation Errors

**Problem**: Missing system dependencies

**Solution**:

```bash
# Ubuntu/Debian
sudo apt-get install build-essential pkg-config libssl-dev

# macOS
xcode-select --install

# Or use devenv for consistent environment
devenv shell
```

#### Docker Build Issues

**Problem**: Slow Docker builds or caching issues

**Solution**:

```bash
# Clear Docker cache
docker builder prune

# Build with no cache
docker build --no-cache -t rust-base .

# Check multi-platform builds
docker buildx build --platform linux/amd64,linux/arm64 -t rust-base .
```

#### Performance Issues

**Problem**: Slow application startup

**Solutions**:

1. Use release builds: `cargo build --release`
2. Enable link-time optimization in `Cargo.toml`:
   ```toml
   [profile.release]
   lto = true
   codegen-units = 1
   ```
3. Profile with `cargo flamegraph` (requires installation)

### Getting Help

1. **Rust Documentation**: https://doc.rust-lang.org/
2. **Tokio Guide**: https://tokio.rs/tokio/tutorial
3. **devenv Documentation**: https://devenv.sh/
4. **Community**: https://users.rust-lang.org/

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

### Development Process

1. **Fork** the repository
2. **Clone** your fork: `git clone https://github.com/yourusername/rust-base.git`
3. **Create** a feature branch: `git checkout -b feature/amazing-feature`
4. **Set up** development environment: `devenv shell`
5. **Make** your changes following the coding standards
6. **Test** your changes: `cargo test`
7. **Format** code: `cargo fmt`
8. **Lint** code: `cargo clippy`
9. **Commit** changes: `git commit -m 'Add amazing feature'`
10. **Push** to branch: `git push origin feature/amazing-feature`
11. **Open** a Pull Request

### Coding Standards

- Follow Rust naming conventions
- Write comprehensive tests for new features
- Document public APIs with rustdoc comments
- Keep commits atomic and well-described
- Ensure all CI checks pass

### Pull Request Guidelines

- Provide clear description of changes
- Reference related issues
- Include tests for new functionality
- Update documentation as needed
- Ensure backward compatibility when possible

### Issue Reporting

When reporting issues, please include:

- Rust version (`rustc --version`)
- Operating system
- Steps to reproduce
- Expected vs actual behavior
- Relevant logs or error messages

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Tokio](https://tokio.rs/) for the excellent async runtime
- [devenv](https://devenv.sh/) for reproducible development environments
- [cargo-chef](https://github.com/LukeMathWalker/cargo-chef) for Docker build optimization
- The Rust community for creating an amazing ecosystem

---

**Happy coding! 🦀**

For more information, visit the [official Rust documentation](https://doc.rust-lang.org/) or join the [Rust community](https://www.rust-lang.org/community).
