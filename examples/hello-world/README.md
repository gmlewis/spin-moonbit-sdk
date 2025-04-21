# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up the app:

```shell
$ spin build --up
```

The application can now receive requests at `http://localhost:3000/hello`:

```shell
$ curl -i localhost:3000/hello                        
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Wed, 22 Jan 2025 14:45:01 GMT

Hello, World!
```
