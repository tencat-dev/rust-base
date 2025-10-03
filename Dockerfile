# Dockerfile for Rust Boilerplate
#
# Inspired by:
# - https://depot.dev/blog/rust-dockerfile-best-practices
# - https://depot.dev/docs/languages/rust-dockerfile
# - https://www.lpalmieri.com/posts/fast-rust-docker-builds/
# - https://github.com/LukeMathWalker/cargo-chef

ARG RUST_VERSION=${RUST_VERSION:-"1.90"}
ARG RUST_TARGET=${RUST_TARGET:-"x86_64-unknown-linux-musl"}

FROM rust:${RUST_VERSION} AS base
WORKDIR /app

ARG RUST_TARGET
ENV RUST_TARGET=${RUST_TARGET}

RUN rustup target add $RUST_TARGET \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
    	musl-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
		# Install cargo \
		&& cargo install --locked cargo-chef sccache

ENV RUSTC_WRAPPER=sccache SCCACHE_DIR=/sccache

FROM base AS planner

COPY Cargo.toml Cargo.lock ./

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

FROM final AS runtime

WORKDIR /app

ARG RUST_TARGET

COPY --from=builder /app/target/$RUST_TARGET/release/rust-base ./main

ENTRYPOINT ["/app/main"]