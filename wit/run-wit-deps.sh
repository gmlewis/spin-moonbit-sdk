#!/bin/bash -ex
rm -rf ./deps
cargo install wit-deps-cli
pushd .. && wit-deps
