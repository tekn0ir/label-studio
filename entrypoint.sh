#!/bin/bash

label-studio init ${PROJECT_NAME:-project} --root-dir /data --use-gevent || true
label-studio start ${PROJECT_NAME:-project} --root-dir /data -b --use-gevent --host 0.0.0.0 --port ${PORT:-8888}
