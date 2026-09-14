#!/bin/bash -ex
# Regenerates the WIT bindings for this SDK from the `wit/` directory.
#
# `wit-bindgen` still emits the long-deprecated `moon.mod.json` / `moon.pkg.json`
# manifest format and a directory layout that is not what this SDK wants, so
# `cmd/wit-translate` runs it into a temporary directory, lets `moon fmt`
# migrate the manifests to `moon.mod` / `moon.pkg`, and then reshapes the
# output into the layout this repository uses:
#
#   interface/<namespace>/<package>/<interface>/{moon.pkg,ffi.mbt,top.mbt}
#   gen/                 thin wrappers around the FFI primitives
#   ffi/top_wasm.mbt     the FFI primitives, all in one shared package
#   ffi/top_notwasm.mbt  generated from top_wasm.mbt by cmd/gen-ffi-top-notwasm
#
# Usage: cd wit && ./run-wit-bindgen.sh
cd "$(dirname "$0")"
go run ../cmd/wit-translate/main.go .
