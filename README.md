# gmlewis/spin-moonbit-sdk

This is an experimental [Spin SDK] for the [MoonBit] programming language.

[Spin SDK]: https://www.fermyon.com/spin
[MoonBit]: https://www.moonbitlang.com/

## Build

Before building, you must have already installed the MoonBit programming language
and the [Spin CLI tool].

To install MoonBit, follow the instructions here (it is super-easy with VSCode):
https://www.moonbitlang.com/download/

Then, to build this SDK, clone the repo, and type:

```bash
moon update && moon install
./build.sh
```

[Spin CLI tool]: https://developer.fermyon.com/spin

## Run

To run the examples, type:

```bash
$ cd examples/greet
$ spin up
```

then from another terminal, hit the endpoint with `curl`:

```bash
$ curl -i localhost:3000
```

## Status

The code has been updated to support compiler:

```bash
$ moon version --all
moon 0.1.20240726 (67f143f 2024-07-26) ~/.moon/bin/moon
moonc v0.1.20240729+3efb92d5a ~/.moon/bin/moonc
moonrun 0.1.20240716 (08bce9c 2024-07-16) ~/.moon/bin/moonrun
```

Use [`moonup`] to manage `moon` compiler versions:
https://github.com/chawyehsu/moonup
