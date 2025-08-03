// bump-version reads the `moon.mod.json` file, parses the "version" line,
// bumps the patch (or '-major' or '-minor) version by one, then writes back the file.
// It also prints the old version and new version on separate lines to stdout.
package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

const filename = "moon.mod.json"

var (
	versionRE = regexp.MustCompile(`"version": "(\d+)\.(\d+)\.(\d+)"`)

	bumpMajor = flag.Bool("major", false, "Bump major instead of patch")
	bumpMinor = flag.Bool("minor", false, "Bump minor instead of patch")
	noop      = flag.Bool("n", false, "Run, but don't modify the file")
)

func main() {
	flag.Parse()

	log.SetFlags(0)
	buf, err := os.ReadFile(filename)
	must(err)

	m := versionRE.FindStringSubmatch(string(buf))
	if len(m) != 4 {
		log.Fatalf("unable to find version in %v: %+v", filename, m)
	}

	dmaj, dmin, dpat := 0, 0, 1
	if *bumpMajor {
		dmaj, dpat = 1, 0
	} else if *bumpMinor {
		dmin, dpat = 1, 0
	}

	oldLine := m[0]
	major, err := strconv.Atoi(m[1])
	must(err)
	minor, err := strconv.Atoi(m[2])
	must(err)
	patch, err := strconv.Atoi(m[3])
	must(err)
	oldVersion := fmt.Sprintf("%v.%v.%v", major, minor, patch)
	newVersion := fmt.Sprintf("%v.%v.%v", major+dmaj, minor+dmin, patch+dpat)

	newLine := strings.Replace(oldLine, oldVersion, newVersion, 1)
	outStr := strings.Replace(string(buf), oldLine, newLine, 1)

	if !*noop {
		must(os.WriteFile(filename, []byte(outStr), 0644))
	}

	fmt.Printf("%v\n%v\n", oldVersion, newVersion)

	log.Printf("Done.")
}

func must(err error) {
	if err != nil {
		log.Fatal(err)
	}
}
