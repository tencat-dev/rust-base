# Dockerfile for Rust Boilerplate
#
# Inspired by:
# - https://depot.dev/blog/rust-dockerfile-best-practices
# - https://depot.dev/docs/languages/rust-dockerfile
# - https://www.lpalmieri.com/posts/fast-rust-docker-builds/
# - https://github.com/LukeMathWalker/cargo-chef

ARG RUST_VERSION=${RUST_VERSION:-"1.90"}
ARG RUST_TARGET=${RUST_TARGET:-"x86_64-unknown-linux-musl"}

FROM rust:${RUST_VERSION}-slim AS base
WORKDIR /app

ARG RUST_TARGET

# Install only minimal dependencies
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        musl-tools \
        curl \
    && rm -rf /var/lib/apt/lists/*

# Install cargo-binstall (much faster and smaller than cargo install)
RUN curl -fsSL https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh \
    | bash

# Add the target required for building artifacts
RUN rustup target add "${RUST_TARGET}" \
    && cargo binstall --no-confirm --force \
        cargo-chef \
        sccache \
    && cargo cache -a || true \
    && rm -rf ~/.cargo/registry ~/.cargo/git

ENV RUSTC_WRAPPER=sccache SCCACHE_DIR=/sccache

FROM base AS planner

COPY . .

RUN cargo chef prepare --recipe-path recipe.json

FROM base AS builder

ARG RUST_TARGET

COPY --from=planner /app/recipe.json .

RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/local/cargo/git \
    --mount=type=cache,target=$SCCACHE_DIR,sharing=locked \
    cargo chef cook --release --target $RUST_TARGET --recipe-path recipe.json

COPY . .

RUN --mount=type=cache,target=/usr/local/cargo/registry \
    --mount=type=cache,target=/usr/local/cargo/git \
    --mount=type=cache,target=$SCCACHE_DIR,sharing=locked \
    cargo build --release --target $RUST_TARGET

FROM debian:bookworm-slim AS runtime
WORKDIR /app

ARG RUST_TARGET

COPY --from=builder /app/target/$RUST_TARGET/release/rust-base /usr/local/bin/app

ENTRYPOINT ["/usr/local/bin/app"]