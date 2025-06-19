# gmlewis/spin-moonbit-sdk
[![check](https://github.com/gmlewis/spin-moonbit-sdk/actions/workflows/check.yml/badge.svg)](https://github.com/gmlewis/spin-moonbit-sdk/actions/workflows/check.yml)

This is an experimental [Spin SDK] for the [MoonBit] programming language.
Please expect breaking changes while still experimenting with the API.

This is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

[Spin SDK]: https://www.fermyon.com/spin
[MoonBit]: https://www.moonbitlang.com/

## Build

Before building, you must have already installed the MoonBit programming language
and the [Spin CLI tool]. You also need version `v1.222.0` or later of [wasm-tools].

To install MoonBit, follow the instructions here (it is super-easy with VSCode):
https://www.moonbitlang.com/download/

Then, to build this SDK, clone the repo, and type:

```bash
moon update && moon install
moon build
```

[Spin CLI tool]: https://developer.fermyon.com/spin
[wasm-tools]: https://github.com/bytecodealliance/wasm-tools

## Run

Examples can be found at: https://github.com/gmlewis/spin-moonbit-sdk-examples

To run an example, type:

```bash
$ cd hello-world
$ spin up --build
```

then from another terminal, hit the endpoint with `curl`:

```bash
$ curl -i localhost:3000/hello
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Sat, 17 Aug 2024 00:15:14 GMT

Hello, World!
```

Each example contains a README. Please refer to the README for additional commands and setup instructions. It might also be required to issue an update command: `moon update` to retrieve the latest dependencies.

## Status

The code has been updated to support compiler:

```bash
$ moon version --all
moon 0.1.20250618 (722aa08 2025-06-18) ~/.moon/bin/moon
moonc v0.6.18+8382ed77e ~/.moon/bin/moonc
moonrun 0.1.20250618 (722aa08 2025-06-18) ~/.moon/bin/moonrun
```
