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
HTTP/1.1 500 Internal Server Error
content-type: text/plain
transfer-encoding: chunked
date: Fri, 16 Aug 2024 15:53:29 GMT

HttpRequestUriInvalid
```

The `spin` app reports:

```shell
Serving http://127.0.0.1:3000
Available Routes:
  outbound-http: http://127.0.0.1:3000 (wildcard)
Get
https://random-data-api.fermyon.app/physics/json
```
