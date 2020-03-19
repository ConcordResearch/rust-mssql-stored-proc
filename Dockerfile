FROM rust:1.41.0-stretch as build

ARG SCCACHE_ENDPOINT
ARG SCCACHE_BUCKET
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_ACCESS_KEY_ID

WORKDIR /build
COPY Cargo.toml Cargo.lock /build/
RUN mkdir src &&\
    echo "pub fn main() {}" > src/main.rs &&\
    cargo build --release 

RUN rm -rf /build/src
RUN rm -rf /build/target/release/.fingerprint/rust-mssql-stored-proc-*

# Now copy over the source and compile our app
COPY src/ /build/src/
RUN cargo build --release

# ==================================================

FROM debian:stretch-20190910 as service

WORKDIR /app

COPY --from=build /build/target/release/rust-mssql-stored-proc /app

CMD ["./rust-mssql-stored-proc"]
