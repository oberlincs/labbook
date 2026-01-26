#!/bin/bash

set -e

# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Build all of the binaries for the given architecture.
# - aarch64-apple-darwin
# - x86_64-apple-darwin
# - x86_64-unknown-linux-gnu
#
# The architecture can be given by `rustc --print host-tuple`

host=$(rustc --print host-tuple)
target=${1-${host}}

cd "${SCRIPT_DIR}/mdBook"
[[ "${target}" == "${host}" ]] && cargo test
cargo build --target "${target}" --release

cd "${SCRIPT_DIR}"
[[ "${target}" == "${host}" ]] && cargo test
cargo build --target "${target}" --release

mkdir -p bin
cp -v \
  "mdBook/target/${target}/release/mdbook" \
  "target/${target}/release/mdbook-"{admonish,katex,tera} \
  bin
