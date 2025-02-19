#!/bin/bash
set -e
if ! node -v; then
  echo "Failed to get Node.js version"
  exit 1
fi