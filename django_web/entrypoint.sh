#!/usr/bin/env bash
if test -e /alldev/requirements.txt; then \
    pip install -r /alldev/requirements.txt && echo "pip install success !!"; \
fi

