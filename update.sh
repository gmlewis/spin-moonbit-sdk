#!/bin/bash -ex
moon update && moon install && rm -rf target
moon fmt && moon info --target wasm
moon test --target wasm
