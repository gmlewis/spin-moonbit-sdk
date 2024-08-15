# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

To get a value:

```shell
curl -i localhost:3000/kv-store/key
```

To save a key/value pair:

```shell
curl -i -X POST localhost:3000/kv-store/key -d 'value'
```

NOTE: This example is not working yet. It fails when attempting to POST a key/value pair:

```shell
$ spin build --up
Finished. moon: ran 2 tasks, now up to date
Finished building all Spin components
Logging component stdio to ".spin/logs/"
Storing default key-value data to ".spin/sqlite_key_value.db"

Serving http://127.0.0.1:3000
Available Routes:
  kvstore: http://127.0.0.1:3000 (wildcard)
2024-08-15T02:52:22.794106Z ERROR spin_trigger_http: Error processing request: guest invocation failed

Caused by:
    0: error while executing at wasm backtrace:
           0: 0x1746 - <unknown>!<wasm function 37>
           1: 0x58b1 - <unknown>!<wasm function 160>
           2: 0x5a87 - <unknown>!<wasm function 164>
           3: 0x5d33 - <unknown>!<wasm function 166>
           4: 0x5dab - <unknown>!<wasm function 169>
           5: 0x5da0 - <unknown>!<wasm function 168>
    1: memory fault at wasm address 0xfffffff9 in linear memory of size 0x10000
    2: wasm trap: out of bounds memory access
```
