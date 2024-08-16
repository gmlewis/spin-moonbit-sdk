# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

In one terminal window, start up the app and provide the "secret" value:

```shell
$ ./run.sh
```

Then in another terminal window, get the "secret" variable value:

```shell
$ curl -i localhost:3000/variables/secret_var_name
HTTP/1.1 200 OK
content-type: text/plain
transfer-encoding: chunked
date: Fri, 16 Aug 2024 13:28:12 GMT

secret_var_name_value
```
