#! /bin/bash
# appLariat generic entrypoint.sh

echo "Printing build log"
cat /tmp/build.log

cat /test.txt
cat /sec.txt

APP="Application"

echo "Starting API..."

exec python - <<-EOF
from apl_api import api
ws_app = api.${APP}()
ws_app.run(8080)
EOF