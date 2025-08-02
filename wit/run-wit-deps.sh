#!/bin/bash -ex
rm -rf ./deps ./deps.lock
cargo install wit-deps-cli
pushd .. && wit-deps && popd
pushd deps
rep float32 f32 `rg -l float32`
rep float64 f64 `rg -l float64`
popd
