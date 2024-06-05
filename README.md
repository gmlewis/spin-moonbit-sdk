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
$ moon update
$ moon install
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

This SDK is just in its infancy.

These plugins work:

* [greet](examples/greet/)
