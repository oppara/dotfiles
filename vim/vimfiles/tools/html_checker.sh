#!/bin/sh

# -access 3
# /opt/local/bin/tidy -quiet --gnu-emacs yes -config ~/.tidyrc "$1" 1>/dev/null
/usr/bin/tidy -quiet --gnu-emacs yes -config ~/.tidyrc "$1" 1>/dev/null
# /opt/local/bin/tidy -quiet --gnu-emacs yes -config ~/.tidyrc "$1" 

# Warning:
# Error:
# | iconv -c -f EUC-JP -t UTF-8
# SHIFT_JISX0213
# CP932
