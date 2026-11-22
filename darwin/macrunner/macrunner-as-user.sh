#!/bin/sh
set -eu
uid="$(id -u _macrunner)"
exec /bin/launchctl asuser "$uid" /usr/bin/sudo -H -u _macrunner -- \
  /usr/bin/env MACRUNNER_CTX=1 "$@"
