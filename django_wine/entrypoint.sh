#!/bin/bash
set -e
# install wine python.exe (3.7.5)
echo "------ Download python ------"
wget https://www.python.org/ftp/python/3.7.6/python-3.7.6-amd64.exe
#wget https://www.python.org/ftp/python/3.7.6/python-3.7.6.exe

echo "------ Init wine prefix ------"
WINEPREFIX=~/.wine64 WINARCH=win64 winetricks \
    corefonts \
    win10

# Setup dummy screen
Xvfb :0 -screen 0 1024x768x16 &
jid=$!

echo "------ Install python ------"
DISPLAY=:0.0 WINEPREFIX=~/.wine64 wine cmd /c \
    python-3.7.6-amd64.exe \
    /quiet \
    PrependPath=1 \
    && echo "Python Installation complete!"
# Display=:0.0 redirects wine graphical output to the dummy display.
# This is to avoid docker errors as the python installer requires a display,
# even when quiet install is specified.

exec "$@"