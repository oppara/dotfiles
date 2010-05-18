if test -x /opt/local/bin/lv; then
    PAGER=/opt/local/bin/lv; export PAGER
    LV="-E'$EDITOR +%d'"; export LV
else
    PAGER=/usr/bin/less; export PAGER
fi

BLOCKSIZE=k; export BLOCKSIZE

test -f ~/.zshrc && . ~/.zshrc
