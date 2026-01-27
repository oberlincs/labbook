#!/bin/bash

set -e

if [[ $# -gt 1 ]]; then
  echo "Usage: $0 [init | update | verify]" >&2
  exit 1
fi

verify() {
    if [[ "$(git -C "$1" rev-parse HEAD)" != "$(git -C "$1" rev-parse "$2^{commit}")" ]]; then
        echo "Submodule $1 is not at expected version $2" >&2
        exit 1
    fi
}

update() {
    echo "Updating $1 to $2"
    if ! git -C "$1" checkout --quiet "$2"; then
        echo "Failed to checkout $2 in submodule $1" >&2
        exit 1
    fi
}

case "${1-verify}" in
    init)
        git submodule init
        git submodule update --checkout
        exit 0
        ;;
    update)
        action=update
        ;;
    verify)
        action=verify
        ;;
    *)
        echo "Unknown action: $1" >&2
        exit 1
        ;;
esac

# https://stackoverflow.com/a/246128
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "${SCRIPT_DIR}"

. VERSIONS

"${action}" 'mdBook' "${MDBOOK}"
"${action}" 'mdbook-admonish' "${ADMONISH}"
"${action}" 'mdbook-katex' "${KATEX}"
"${action}" 'mdbook-tera' "${TERA}"
