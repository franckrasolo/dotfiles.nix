#!/bin/sh
set -eu
as_user="/run/current-system/sw/bin/macrunner-as-user"
runners_dir="${MACRUNNER_RUNNERS_DIR:-/Users/_macrunner/.mac-runner/runners}"
patched=0
for run in "$runners_dir"/*/run.sh; do
  [ -f "$run" ] || continue           # skip missing, sockets
  [ -L "$run" ] && continue           # never follow a symlink into someone else's file
  if grep -q MACRUNNER_CTX "$run"; then
    continue
  fi
  tmp="$(mktemp)"
  {
    head -n 1 "$run"
    printf 'if [ -z "$MACRUNNER_CTX" ]; then exec /usr/bin/sudo -n %s /bin/bash %s "$@"; fi\n' \
      "$as_user" "$run"
    tail -n +2 "$run"
  } > "$tmp"
  chmod 0555 "$tmp"
  mv "$tmp" "$run"
  patched=1
done

if [ "$patched" -eq 1 ]; then
  exit 10
fi
exit 0
