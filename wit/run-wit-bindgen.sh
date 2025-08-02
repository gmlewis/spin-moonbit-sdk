#!/bin/bash -ex
wit-bindgen moonbit --derive-show --derive-eq .

rm moon.mod.json
rm -rf world
# process ffi
mv ffi/top.mbt ../ffi/top_wasm.mbt
rm -rf ffi
go run ../cmd/gen-ffi-top-notwasm/main.go
# process gen
rm gen/world_http_trigger_export.mbt
mv gen/ffi.mbt ../gen/ffi.mbt
rm -rf gen
# process interface
rm -rf ../interface/wasi ../interface/fermyon
mv interface/wasi ../interface
mv interface/fermyon ../interface
rm -rf interface

# last step:
moon fmt && moon info
