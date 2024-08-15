# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

To save a key/value pair:

```shell
$ curl -i -X POST localhost:3000/kv-store/key -d 'value'
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Thu, 15 Aug 2024 13:43:18 GMT

OK
```

To get a value:

```shell
$ curl -i localhost:3000/kv-store/key
HTTP/1.1 200 OK
content-type: application/octet-stream
transfer-encoding: chunked
date: Thu, 15 Aug 2024 13:44:12 GMT

value
```
