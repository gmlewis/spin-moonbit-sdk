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
foo: bar
content-length: 440
date: Thu, 26 Oct 2023 18:18:19 GMT

== REQUEST ==
URL:     http://localhost:3000/hello
Method:  GET
Headers:
  "Host": "localhost:3000"
  "User-Agent": "curl/8.1.2"
  "Spin-Full-Url": "http://localhost:3000/hello"
  "Spin-Base-Path": "/"
  "Spin-Client-Addr": "127.0.0.1:52164"
  "Accept": "*/*"
  "Spin-Path-Info": ""
  "Spin-Matched-Route": "/hello"
  "Spin-Raw-Component-Route": "/hello"
  "Spin-Component-Route": "/hello"
Body:
== RESPONSE ==
Hello Fermyon!
```
