#!/bin/bash -e
pushd examples/hello-world && RUST_LOG=spin=trace spin build --up
