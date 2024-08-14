# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

NOTE: This example is not working yet:

```shell
$ spin build --up
error: failed to encode a component from module

Caused by:
    0: failed to decode world from module
    1: module was not valid
    2: module requires an import interface named `fermyon:spin@2.0.0/key-value`
Error: Build command for component kvstore failed with status Exited(1)
```

The application can now receive requests at `http://localhost:3000/kv-store/key`
and `http://localhost:3000/kv-store/key/value`.