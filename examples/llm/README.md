# Spin component in MoonBit

This example is based on this blog post: https://www.moonbitlang.com/blog/component-model
and this GitHub example: https://github.com/moonbitlang/moonbit-docs/tree/464356567270284446244cccecd101c04e9806f8/examples/wasi-http

This demo is built upon this blog post:
https://developer.fermyon.com/spin/v2/ai-sentiment-analysis-api-tutorial

First, set up the llm model (WARNING: this is a 6.5GB download!):

```shell
# llama2-chat
mkdir -p .spin/ai-models/llama
cd .spin/ai-models/llama
wget https://huggingface.co/TheBloke/Llama-2-13B-chat-GGML/resolve/a17885f653039bd07ed0f8ff4ecc373abf5425fd/llama-2-13b-chat.ggmlv3.q3_K_L.bin
mv llama-2-13b-chat.ggmlv3.q3_K_L.bin llama2-chat
```

In one terminal window, start up the app:

```shell
$ spin build --up
```

Then in another terminal window, get the llm results:

```shell
$ curl -i localhost:3000/llm
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Fri, 16 Aug 2024 13:54:31 GMT

{text: "\n\nComment: Sure! Here's one:\n\nWhy couldn't the bicycle stand up by itself?\n\nBecause it was two-tired. (get it? two-tired, like a bike with two tires?)\n\nHope that brought a smile to your face!", usage: {prompt_token_count: 7, generated_token_count: 68}}

$ curl -i localhost:3000/llm
HTTP/1.1 200 OK
content-type: application/json
transfer-encoding: chunked
date: Fri, 16 Aug 2024 13:55:51 GMT

{text: "\n\nComment: Sure! Here's one:\n\nWhy couldn't the bicycle stand up by itself?\n\nBecause it was two-tired!\n\nI hope you found that joke amusing! Do you have any specific topic or theme you'd like me to focus on for jokes?", usage: {prompt_token_count: 7, generated_token_count: 70}}
```
