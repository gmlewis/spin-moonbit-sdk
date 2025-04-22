// -*- compile-command: "go run ."; -*-

// gen-ffi-top-notwasm generates the `ffi/top_notwasm.mbt` file
// by parsing `ffi/top_wasm.mbt` and making stubs for all the `pub` functions.
package main

import (
	"bytes"
	"log"
	"os"
	"path/filepath"
	"regexp"
	"runtime"
	"strings"
)

const (
	topNotWasmRelPath = "../../ffi/top_notwasm.mbt"
	topWasmRelPath    = "../../ffi/top_wasm.mbt"
)

func main() {
	log.SetFlags(0)
	_, fileName, _, _ := runtime.Caller(0)
	wd := filepath.Dir(fileName)
	topWasmPath := filepath.Join(wd, topWasmRelPath)
	src, err := os.ReadFile(topWasmPath)
	must(err)

	var outBuf bytes.Buffer
	processSource(string(src), &outBuf)

	topNotWasmPath := filepath.Join(wd, topNotWasmRelPath)
	f, err := os.Create(topNotWasmPath)
	must(err)
	defer f.Close()
	_, err = outBuf.WriteTo(f)
	must(err)

	log.Printf("Done.")
}

var (
	keepCleanupRE    = regexp.MustCompile(`(?sm)(Cleanup {.*?})`)
	bodyRE           = regexp.MustCompile(`(?sm){\n.*?\n}\n`)
	externWasmUnitRE = regexp.MustCompile(`(?sm)(\) =\n#\|.*?\n)`)
	externWasmRE     = regexp.MustCompile(`(?sm)(=\n#\|.*?\n)`)
	intArgRE         = regexp.MustCompile(`([a-z_]+ : Int)`)
	floatArgRE       = regexp.MustCompile(`([a-z_]+ : Float)`)
	doubleArgRE      = regexp.MustCompile(`([a-z_]+ : Double)`)
	stringArgRE      = regexp.MustCompile(`([a-z_]+ : String)`)
	fixedArrayArgRE  = regexp.MustCompile(`([a-z_]+ : FixedArray)`)
	privateFnRE      = regexp.MustCompile(`(?sm)^(fn .*?)$`)
)

func processSource(src string, outBuf *bytes.Buffer) {
	src = strings.ReplaceAll(src, "wit-bindgen", "cmd/gen-ffi-top-notwasm")
	src = strings.ReplaceAll(src, `extern "wasm" `, "")
	// weird but necessary
	src = strings.ReplaceAll(src, "{{", "{")
	src = strings.ReplaceAll(src, "}}", "}")
	cleanup := keepCleanupRE.FindString(src)
	src = bodyRE.ReplaceAllString(src, `{ abort("not wasm") }`+"\n")
	src = externWasmUnitRE.ReplaceAllString(src, `) -> Unit { abort("not wasm") }`+"\n")
	src = externWasmRE.ReplaceAllString(src, `{ abort("not wasm") }`+"\n")
	src = intArgRE.ReplaceAllString(src, "_$1")
	src = floatArgRE.ReplaceAllString(src, "_$1")
	src = doubleArgRE.ReplaceAllString(src, "_$1")
	src = stringArgRE.ReplaceAllString(src, "_$1")
	src = fixedArrayArgRE.ReplaceAllString(src, "_$1")
	src = privateFnRE.ReplaceAllString(src, "")
	src = strings.Replace(src, `Cleanup { abort("not wasm") }`, cleanup, 1)
	outBuf.WriteString(src)
}

func must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
