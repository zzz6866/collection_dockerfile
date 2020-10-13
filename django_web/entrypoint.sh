#!/usr/bin/env bash
set -ex
if test -e /alldev/requirements.txt; then \
    pip install -r /alldev/requirements.txt && echo "pip install success !!"; \
fi

# Apply database migrations
echo "Apply database migrations"
make migrate

# Start server
echo "Start server"
python school/manage.py runserver 0.0.0.0:8000