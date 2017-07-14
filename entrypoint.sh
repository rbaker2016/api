#! /bin/bash
# appLariat generic entrypoint.sh

echo "Printing build log"
cat /tmp/build.log

TAG=${TAG}
APL_COMMON_TAG=${APL_COMMON_TAG}
BB_API_KEY=${BB_API_KEY}
APP="Application"

cd /usr/src/app/

#pulling down and installing code
apt update \
    && apt install -y openssl libc-dev gcc \
	&& pip install . \
    && pip install --upgrade https://applariat:$BB_API_KEY@bitbucket.org/applariat/apl-common/get/${APL_COMMON_TAG}.zip


echo "Starting API..."

exec python - <<-EOF
from apl_api import api
ws_app = api.${APP}()
ws_app.run(8080)
EOF