# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up the app:

```shell
$ spin build --up
```

The application can now receive requests at `http://localhost:3000/`:

```shell
$ curl -i localhost:3000/
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Fri, 16 Aug 2024 23:33:10 GMT

It is now 1723851190 seconds since Unix Epoch.
```
