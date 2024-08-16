# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up the app:

```shell
$ spin build --up
```

Then in another terminal window, get the results:

```shell
$ curl -i localhost:3000/outbound-http
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Fri, 16 Aug 2024 21:42:38 GMT

{"timestamp":1723844558854,"fact":"Water slows down light"}
```
