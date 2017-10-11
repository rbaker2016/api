#! /bin/bash

echo Starting the SSH server
/usr/sbin/sshd -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start SSH server: $status"
  exit $status
else
  echo SSH server started successfully
fi

echo Starting the API server
APP="Application"

echo "Starting API..."
exec python - <<-EOF
from apl_api import api
ws_app = api.${APP}()
ws_app.run(8080)
EOF

status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start API server: $status"
  exit $status
else
  echo API server started successfully
fi

#Watching processes and making sure they're running
while /bin/true; do
  echo Probing running services...
  ps aux |grep sshd |grep -q -v grep
  PROCESS_SSH_STATUS=$?
  echo SSH server status: $PROCESS_SSH_STATUS
  ps aux |grep python |grep -q -v grep
  PROCESS_API_STATUS=$?
  echo API server status: $PROCESS_API_STATUS
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_SSH_STATUS -ne 0 -o $PROCESS_API_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
