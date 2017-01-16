#!/bin/bash

grep -q /usr/local/bin/bash /etc/shells ||
sudo bash -c "echo /usr/local/bin/bash >> /etc/shells"

CURRENT_SHELL="$(dscl . -read /Users/$USER UserShell | awk '{print $2}')"
[ "$CURRENT_SHELL" != "/usr/local/bin/bash" ] && chsh -s /usr/local/bin/bash
