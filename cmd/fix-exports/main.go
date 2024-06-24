// -*- compile-command: "go test -v ./..."; -*-

// fix-exports reads all *.wat files found under target/wasm/release/build
// and writes a new *.wasm file that changes the string:
// `(export "fermyon_spin_inbound_http"`
// to: `(export "fermyon:spin/inbound-http"`.
//
// Obviously, this is a royal hack, but allows the resulting WASM files to be used directly
// with the spin CLI, which is really nice.
package main

import (
	"flag"
	"io/fs"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

var (
	dir      = flag.String("dir", "target/wasm/release/build", "Directory to search for *.wat files")
	watFlags = flag.String("watflags", "", "Comma-separated list of flags to add to `wat2wasm`")
)

const (
	exportBefore = `(export "fermyon_spin_inbound_http"`
	exportAfter  = `(export "fermyon:spin/inbound-http"`
)

func main() {
	flag.Parse()

	fileSystem := os.DirFS(*dir)
	fs.WalkDir(fileSystem, ".", func(path string, d fs.DirEntry, err error) error {
		if err != nil {
			log.Fatal(err)
		}
		if strings.HasSuffix(path, ".wat") {
			processFile(filepath.Join(*dir, path))
		}
		return nil
	})

	log.Printf("Done.")
}

func processFile(path string) {
	wasmPath := strings.TrimSuffix(path, "wat") + "wasm"
	b, err := os.ReadFile(path)
	must(err)

	finalOut := strings.ReplaceAll(string(b), exportBefore, exportAfter)

	must(os.WriteFile(path, []byte(finalOut), 0644))

	args := []string{"wat2wasm", path, "-o", wasmPath}
	if *watFlags != "" {
		args = append(args, strings.Split(*watFlags, ",")...)
	}
	cmdOut, err := exec.Command(args[0], args[1:]...).CombinedOutput()
	if err != nil {
		log.Fatalf("wat2wasm error: %v\n%s", err, cmdOut)
	}
}

func must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
