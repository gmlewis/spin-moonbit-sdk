#!/bin/bash
set -euo pipefail

# publish-and-tag.sh publishes this module to mooncakes.io and records the
# release as a pushed git tag "vMAJOR.MINOR.PATCH", so GitHub shows exactly
# when each "moon publish" happened.
#
#   1. Run ./update.sh (required before publishing).
#   2. If moon.mod's version is newer than the last published version, tag
#      HEAD "vA.B.C", push the tag, and publish. If that tag already exists,
#      fall through to step 3.
#   3. Bump the PATCH version in moon.mod, refresh dependencies with
#      `update-moonbit-deps -refresh`, commit "Bump version to A.B.C", tag
#      "vA.B.C", push the commit and the tag, and publish.
#
# After a successful publish, `update-moonbit-deps -refresh` runs again so the
# registry cache and every dependent repository see the new version.
#
# The module name and version come from moon.mod, so this file is identical
# in every sibling repo, but each copy is independent: it only reads, tags,
# and publishes the repo it lives in, and it is meant to be run manually in
# one repo at a time.

cd "$(dirname "$0")"

die() { echo "error: $*" >&2; exit 1; }
note() { echo "==> $*"; }
warn() { echo "warning: $*" >&2; }

# --- Preflight -------------------------------------------------------------

[[ -f moon.mod ]] || die "moon.mod not found in $PWD"
[[ -x ./update.sh ]] || die "./update.sh not found or not executable"
[[ -x "$HOME/tools/bin/update-moonbit-deps" ]] ||
  die "~/tools/bin/update-moonbit-deps not found or not executable"
for cmd in git moon python3; do
  command -v "$cmd" >/dev/null 2>&1 || die "$cmd not found on PATH"
done

module=$(sed -n 's/^name *= *"\([^"]*\)".*/\1/p' moon.mod | head -n 1)
local_version=$(sed -n 's/^version *= *"\([^"]*\)".*/\1/p' moon.mod | head -n 1)
[[ -n "$module" ]] || die "could not read the module name from moon.mod"
[[ -n "$local_version" ]] || die "could not read the version from moon.mod"
[[ "$local_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] ||
  die "moon.mod version '$local_version' is not MAJOR.MINOR.PATCH"

branch=$(git rev-parse --abbrev-ref HEAD)
[[ "$branch" == "master" ]] || warn "publishing from '$branch', not master"

# compare_versions A B prints -1, 0, or 1.
compare_versions() {
  python3 -c '
import sys
def key(v):
    parts = v.split(".")
    parts += ["0"] * max(0, 3 - len(parts))
    return tuple(int(p) for p in parts[:3])
a, b = key(sys.argv[1]), key(sys.argv[2])
print((a > b) - (a < b))' "$1" "$2"
}

# bump_patch A.B.C prints A.B.(C+1).
bump_patch() {
  python3 -c '
import sys
parts = sys.argv[1].split(".")
parts += ["0"] * max(0, 3 - len(parts))
print("%s.%s.%d" % (parts[0], parts[1], int(parts[2]) + 1))' "$1"
}

# set_version rewrites the module version in moon.mod.
set_version() {
  python3 - "$1" <<'PY'
import re
import sys

path = "moon.mod"
text = open(path).read()
pattern = r'(?m)^version\s*=\s*"[^"]*"'
text, count = re.subn(pattern, 'version = "' + sys.argv[1] + '"', text, count=1)
if count != 1:
    sys.exit("error: could not rewrite the version in moon.mod")
open(path, "w").write(text)
PY
}

tag_exists() {
  git rev-parse -q --verify "refs/tags/$1" >/dev/null 2>&1
}

# refresh_registry runs update-moonbit-deps with -refresh: the on-disk cache is
# bypassed, so a version that was just published is seen immediately and every
# dependent repository's pins are advanced.
refresh_registry() {
  note "Refreshing update-moonbit-deps (-refresh) ..."
  "$HOME/tools/bin/update-moonbit-deps" -refresh
}

# --- Step 1: update --------------------------------------------------------

note "Running ./update.sh (required before publishing) ..."
./update.sh

# Never release a module that still has compiler warnings.
note "Checking for compiler warnings (moon check --deny-warn) ..."
moon check --deny-warn --no-mbti ||
  die "moon check reported warnings or errors; refusing to cut the release"

# --- Find the last published version ---------------------------------------

published_version=""
if registry_json=$(moon view "$module" --json 2>/dev/null); then
  published_version=$(printf '%s' "$registry_json" | python3 -c '
import json
import sys
try:
    print(json.load(sys.stdin)["result"]["latest_version"])
except Exception:
    pass')
  [[ -n "$published_version" ]] ||
    die "could not read latest_version for $module from: $registry_json"
elif [[ "$registry_json" == *"404 Not Found"* ]]; then
  note "$module has never been published"
else
  die "registry lookup failed for $module: ${registry_json:-no output from moon view}"
fi

note "$module: moon.mod has $local_version, registry has ${published_version:-<none>}"

# --- Step 2: publish a version that is already ahead -----------------------

if [[ -n "$published_version" ]] &&
  [[ "$(compare_versions "$local_version" "$published_version")" == "1" ]]; then
  if tag_exists "v$local_version"; then
    note "tag v$local_version already exists; bumping the patch version instead"
  else
    if [[ -n "$(git status --porcelain --untracked-files=no)" ]]; then
      head_version=$(git show HEAD:moon.mod 2>/dev/null |
        sed -n 's/^version *= *"\([^"]*\)".*/\1/p' | head -n 1)
      if [[ "$head_version" != "$local_version" ]]; then
        commit_message="Bump version to $local_version"
      else
        commit_message="Update dependencies and generated files"
      fi
      note "Committing ./update.sh changes: $commit_message"
      git commit -sam "$commit_message"
    fi
    git push origin HEAD
    git tag "v$local_version"
    git push origin "refs/tags/v$local_version"
    note "Publishing $module@$local_version ..."
    moon publish
    refresh_registry
    note "Published $module@$local_version with tag v$local_version"
    exit 0
  fi
fi

# --- Step 3: bump the patch version, then tag and publish ------------------

new_version=$(bump_patch "$local_version")
if [[ -n "$published_version" ]] &&
  [[ "$(compare_versions "$new_version" "$published_version")" != "1" ]]; then
  warn "$new_version is not newer than the published $published_version; using $(bump_patch "$published_version")"
  new_version=$(bump_patch "$published_version")
fi
if tag_exists "v$new_version"; then
  die "tag v$new_version already exists; delete it or bump the version manually"
fi

refresh_registry

note "Bumping $local_version -> $new_version in moon.mod ..."
set_version "$new_version"

note "Committing the release ..."
git commit -sam "Bump version to $new_version"

git push origin HEAD
git tag "v$new_version"
git push origin "refs/tags/v$new_version"

note "Publishing $module@$new_version ..."
moon publish
refresh_registry
note "Published $module@$new_version with tag v$new_version"
