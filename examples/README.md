# examples

More examples can be found at: https://github.com/gmlewis/spin-moonbit-sdk-examples

This directory is used for sanity-checking the repo before performing a release.

To run an example, type:

```bash
$ cd hello-world
$ spin up --build
```

then from another terminal, hit the endpoint with `curl`:

```bash
$ curl -i localhost:3000/hello
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Sat, 17 Aug 2024 00:15:14 GMT

Hello, World!
```
