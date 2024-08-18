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

To test the `md5sum` and `sha256sum` endpoints, start up a python server in
another terminal window in the root directory of this repo:

```shell
$ python3 -m http.server 8080
```

Then use `curl` to test the endpoint:

```shell
$ curl -X POST http://localhost:3000/md5sum -d 'http://localhost:8080/LICENSE' | wc
     201    1581   11357
$ md5sum LICENSE
86d3f3a95c324c9479bd8986968f4327  LICENSE
$ curl -X POST http://localhost:3000/sha256sum -d 'http://localhost:8080/LICENSE' | wc
     201    1581   11357
$ sha256sum LICENSE
c71d239df91726fc519c6eb72d318ec65820627232b2f796219e87dcf35d0ab4  LICENSE
```

View the `spin` output:

```shell
INFO: Performing GET 'http://localhost:8080/LICENSE'
INFO: Status code = 200
INFO: Header['server'] = 'SimpleHTTP/0.6 Python/3.9.6'
INFO: Header['date'] = 'Sat, 17 Aug 2024 23:33:23 GMT'
INFO: Header['content-type'] = 'application/octet-stream'
INFO: Header['content-length'] = '11357'
INFO: Header['last-modified'] = 'Tue, 04 Jun 2024 20:58:42 GMT'
INFO: Streamed 11357 bytes from 'GET http://localhost:8080/LICENSE', md5sum = 86d3f3a95c324c9479bd8986968f4327

INFO: Performing GET 'http://localhost:8080/LICENSE'
INFO: Status code = 200
INFO: Header['server'] = 'SimpleHTTP/0.6 Python/3.9.6'
INFO: Header['date'] = 'Sun, 18 Aug 2024 00:42:45 GMT'
INFO: Header['content-type'] = 'application/octet-stream'
INFO: Header['content-length'] = '11357'
INFO: Header['last-modified'] = 'Tue, 04 Jun 2024 20:58:42 GMT'
INFO: Streamed 11357 bytes from 'GET http://localhost:8080/LICENSE', sha256sum = c71d239df91726fc519c6eb72d318ec65820627232b2f796219e87dcf35d0ab4
```
