# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up a redis server:

```shell
$ redis-server
```

In another terminal window, start up the app:

```shell
$ spin build --up
```

Then in yet another terminal window, get the redis results:

```shell
$ curl -i localhost:3000/redis
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Thu, 15 Aug 2024 19:46:48 GMT

Hello, World!
```
