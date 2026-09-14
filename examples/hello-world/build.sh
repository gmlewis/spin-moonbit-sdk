#!/bin/bash -ex
rm -rf _build target *.wasm
spin build
