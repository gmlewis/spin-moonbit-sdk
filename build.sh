#!/bin/bash -ex

# wasm-gc can be useful for debugging in the browser:
# moon build --target wasm-gc --output-wat
# moon build --target wasm-gc

# Due to this current MoonBit issue: https://github.com/moonbitlang/core/issues/520
# it is necessary to replace the `export "_start"` with `export "_initialize"`,
# so this Go program performs that task:
# moon build --target wasm --output-wat
moon build --target wasm
BASE_DIR=target/wasm/release/build
for wasmpath in ${BASE_DIR}/examples/*/*.wasm ; do
  FILENAME=${wasmpath#"${BASE_DIR}/"}
  cp ${wasmpath} ${FILENAME}
done
