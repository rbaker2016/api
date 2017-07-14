#! /bin/sh
# appLariat generic entrypoint.sh

echo "Printing build log"
cat /code/build.log

APP="Application"

echo "Starting API..."

exec python - <<-EOF
print "Running api.${APP}()"
from apl_api import api
ws_app = api.${APP}()
ws_app.run(8080)
EOF