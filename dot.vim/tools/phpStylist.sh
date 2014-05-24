#!/bin/sh

# http://sourceforge.net/projects/phpstylist/のラッパー

php=`which php`
stylist="$HOME/.vim/tools/phpStylist.php"

$php $stylist "$@" \
--indent_size 4 \
--line_before_comment_multi \
--keep_redundant_lines \
--space_after_comma \
--space_around_assignment \
--align_var_assignment \
--space_around_comparison \
--space_around_arithmetic \
--space_around_logical \
--space_around_colon_question \
--line_before_function \
--space_after_if \
--add_missing_braces \
--space_inside_for \
--indent_case \
--line_after_break \
--space_around_double_arrow \
--space_around_concat \
--vertical_array \
--align_array_assignment
