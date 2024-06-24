#!/bin/bash -ex

# wasm-gc can be useful for debugging in the browser:
# moon build --target wasm-gc --output-wat
# moon build --target wasm-gc

# moon build --target wasm
# Due to this current MoonBit issue: https://discord.com/channels/1135479745207869510/1136927496688906260/1254582273991250041
# it is necessary to replace the fermyon `export`
# so this Go program performs that task on the generated `.wat` file:
moon build --target wasm --output-wat
go run cmd/fix-exports/main.go --watflags="--debug-names"
BASE_DIR=target/wasm/release/build
for wasmpath in ${BASE_DIR}/examples/*/*.wasm ; do
  FILENAME=${wasmpath#"${BASE_DIR}/"}
  cp "${wasmpath}" "${FILENAME}"
  # wasm2wat "${FILENAME}" > "${FILENAME%.wasm}.wat"
done
