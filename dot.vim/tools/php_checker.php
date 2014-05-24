#!/usr/bin/env php
<?php

$result = `/usr/bin/env php -l "$argv[1]" 2>&1`;

if ( preg_match( '/No syntax errors detected in/mis', $result ) ) {
    exit();
}

$REGX_ERROR = '/^\w+ error:\s*(.+)\sin\s(.+)\son\sline\s(\d+)/';

$lines = split( "\n", $result );
foreach ( $lines as $line ) {
    if ( preg_match( $REGX_ERROR, $line, $matches ) ) {
        $message = $matches[1];
        $file = $matches[2];
        $lineno = $matches[3];
        echo "$file:$lineno:$message\n";
    }
}
?>