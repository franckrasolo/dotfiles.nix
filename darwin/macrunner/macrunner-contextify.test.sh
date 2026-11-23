#!/bin/sh
set -eu
here=$(cd "$(dirname "$0")" && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$tmp/runners/one"
cat > "$tmp/runners/one/run.sh" <<'EOF'
#!/bin/bash
echo one
EOF
chmod 755 "$tmp/runners/one/run.sh"

mkdir -p "$tmp/runners/two"
printf '#!/bin/bash\necho target\n' > "$tmp/target"
ln -s "$tmp/target" "$tmp/runners/two/run.sh"

MACRUNNER_RUNNERS_DIR="$tmp/runners" sh "$here/macrunner-contextify.sh"

grep -q MACRUNNER_CTX "$tmp/runners/one/run.sh"
grep -q 'echo one' "$tmp/runners/one/run.sh"
[ -L "$tmp/runners/two/run.sh" ]
[ "$(cat "$tmp/target")" = "#!/bin/bash
echo target" ]

before=$(cksum "$tmp/runners/one/run.sh")
MACRUNNER_RUNNERS_DIR="$tmp/runners" sh "$here/macrunner-contextify.sh"
after=$(cksum "$tmp/runners/one/run.sh")
[ "$before" = "$after" ]
[ "$(grep -c MACRUNNER_CTX "$tmp/runners/one/run.sh")" -eq 1 ]

echo "ok"
