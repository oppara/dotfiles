#!/bin/sh

cli=/Applications/KeyRemap4MacBook.app/Contents/Applications/KeyRemap4MacBook_cli.app/Contents/MacOS/KeyRemap4MacBook_cli

$cli set repeat.wait 30
/bin/echo -n .
$cli set repeat.initial_wait 400
/bin/echo -n .
$cli set remap.doublepresscommandQ 1
/bin/echo -n .
$cli set private.app_terminal_esc_with_eisuu 1
/bin/echo -n .
/bin/echo
