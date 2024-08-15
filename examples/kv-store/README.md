# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

To save a key/value pair:

```shell
$ curl -i -X POST localhost:3000/kv-store/key -d 'value'
HTTP/1.1 200 OK
transfer-encoding: chunked
date: Thu, 15 Aug 2024 12:57:50 GMT

```

To get a value:

```shell
$ curl -i localhost:3000/kv-store/key
HTTP/1.1 200 OK
transfer-encoding: chunked
date: Thu, 15 Aug 2024 12:57:55 GMT

value
```
