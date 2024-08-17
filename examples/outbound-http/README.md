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

To test the `md5sum` endpoint, start up a python server in
another terminal window in the root directory of this repo:

```shell
$ python3 -m http.server 8080
```

Then use `curl` to test the endpoint:

```shell
$ curl -i -X POST http://localhost:3000/md5sum -d 'http://localhost:8080/examples/hello-world/hello-world.mbt'
...
$ curl -i -X POST http://localhost:3000/md5sum -d 'http://localhost:8080/LICENSE'
...
```

View the `spin` output:

```shell
streamed 421 bytes from 'GET http://localhost:8080/examples/hello-world/hello-world.mbt', md5sum = 0ff46e702fb63fa11791efdb87005402
streamed 11357 bytes from 'GET http://localhost:8080/LICENSE', md5sum = 86d3f3a95c324c9479bd8986968f4327
```
