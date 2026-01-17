#!/bin/bash
set -e

# Railsのserver.pidが残っていると起動に失敗するため削除
rm -f /rails/tmp/pids/server.pid

exec "$@"