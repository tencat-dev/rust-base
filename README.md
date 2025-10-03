# 🦀 rust-base

[![Rust](https://img.shields.io/badge/rust-1.90.0-orange.svg)](https://www.rust-lang.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](Dockerfile)

A modern Rust boilerplate template with async runtime, environment management, and containerization support.

## ✨ Features

- **Rust 2024 Edition** with stable toolchain
- **Async Runtime** powered by Tokio
- **Environment Configuration** with dotenvy
- **Reproducible Development** using devenv (Nix)
- **Docker Ready** with optimized multi-stage builds
- **Development Tools** pre-configured (clippy, rustfmt, rust-analyzer)

## 🚀 Quick Start

```bash
# Clone and setup
git clone https://github.com/tencat-dev/rust-base.git my-project
cd my-project
cp .env.example .env

# Run with devenv (recommended)
devenv shell
cargo run

# Or run with cargo directly
cargo run

# Or use Docker
docker build -t my-project .
docker run --env-file .env my-project
```

## 📦 Installation

### Option 1: devenv (Recommended)

```bash
# Install Nix and devenv
curl -L https://install.determinate.systems/nix | sh
nix profile install nixpkgs#devenv

# Enter development environment
devenv shell
```

### Option 2: Local Rust

```bash
# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add clippy rustfmt rust-analyzer
```

## 🏗️ Project Structure

```
rust-base/
├── src/main.rs          # Application entry point
├── .env.example         # Environment template
├── Cargo.toml           # Package manifest
├── devenv.nix           # Development environment
├── Dockerfile           # Container configuration
└── README.md            # This file
```

## ⚙️ Configuration

Create `.env` from template and configure as needed:

```bash
# .env
HOST=localhost
PORT=8080
RUST_LOG=info
```

## 🔨 Development

### Running the Application

```bash
# Development mode
cargo run

# With file watching
cargo watch -x run

# Release mode
cargo build --release
./target/release/rust-base
```

### Code Quality

```bash
# Format code
cargo fmt

# Lint code
cargo clippy

# Run tests
cargo test

# Generate documentation
cargo doc --open
```

### Docker Usage

```bash
# Build image
docker build -t rust-base .

# Run container
docker run --env-file .env rust-base

# Development with volume
docker run -v $(pwd):/app --env-file .env rust-base
```

## 🧪 Testing

```bash
# Run all tests
cargo test

# Run with output
cargo test -- --nocapture

# Integration tests
cargo test --test integration
```

## 📚 Dependencies

| Crate                                         | Purpose               |
| --------------------------------------------- | --------------------- |
| [`tokio`](https://tokio.rs/)                  | Async runtime         |
| [`dotenvy`](https://crates.io/crates/dotenvy) | Environment variables |

### Adding Dependencies

```bash
# Runtime dependency
cargo add serde --features derive

# Development dependency
cargo add --dev proptest
```

## 🚀 Deployment

### Building for Production

```bash
# Optimized build
cargo build --release

# Cross-compile for Linux
cargo build --release --target x86_64-unknown-linux-musl

# Docker production build
docker build --target runtime -t rust-base:prod .
```

### Environment Variables

Required environment variables:

- `HOST`: Server hostname
- `PORT`: Server port (optional, defaults in code)
- `RUST_LOG`: Logging level (optional)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Make changes and test: `cargo test && cargo clippy`
4. Format code: `cargo fmt`
5. Commit changes: `git commit -m 'Add new feature'`
6. Push and create a Pull Request

### Development Workflow

```bash
# Before committing
cargo fmt && cargo clippy -- -D warnings && cargo test
```

## 🔧 Troubleshooting

### Common Issues

**Environment variables not loading:**

```bash
# Ensure .env exists
cp .env.example .env
```

**Build failures:**

```bash
# Update Rust
rustup update

# Clear cache
cargo clean
```

**Docker issues:**

```bash
# Rebuild without cache
docker build --no-cache -t rust-base .
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Resources

- [Rust Documentation](https://doc.rust-lang.org/)
- [Tokio Tutorial](https://tokio.rs/tokio/tutorial)
- [devenv Guide](https://devenv.sh/)

---

Built with ❤️ using Rust
