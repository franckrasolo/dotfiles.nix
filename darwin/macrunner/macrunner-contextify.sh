#!/bin/sh
set -eu
as_user="/run/current-system/sw/bin/macrunner-as-user"
for run in /Users/_macrunner/.mac-runner/runners/*/run.sh; do
  [ -f "$run" ] || continue           # skip missing, symlinks, sockets
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
  chown root:wheel "$tmp"
  chmod 0555 "$tmp"
  mv "$tmp" "$run"
done
