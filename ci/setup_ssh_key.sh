#!/bin/bash

set -e

mkdir ~/.ssh

cat >> ~/.ssh/config <<EOF
Host ts
  Hostname login.trustworthy.systems
  User lions_web_updater

EOF

eval $(ssh-agent)
ssh-add -q - <<< "${DEPLOY_SSH_KEY}"
