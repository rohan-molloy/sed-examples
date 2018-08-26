#
# Find and replace on all lines
# Usage: $find $replace
#
find_and_replace(){
	sed 's/'$1'/'$2'/g' "${@:3}"
}
#
# Find and replace on lines matching patterns
# Usage: $pattern $find $replace 
#
find_and_replace_on_lines() {
	sed '/'$1'/'$2'/'$3'/g' "${@:4}"
}
#
# Find and replace first match
# Usage: $find $replace
#
find_and_replace_first_match(){
	sed 's/'$1'/'$2'/' "${@:3}"
}
#
# Find and replace last match
# Usage: $find $replace
#
find_and_replace_last_match() {
	sed 's/\(.*\)'$1'/'$2'/' "${@:3}"
}
#
# Find and replace on lines within range
# Usage: $find $replace $range
#
find_and_replace_inside_range() {
	sed '$3 s/'$1'/'$2'/g' "${@:4}"
} 
#
# Find and replace on lines outside range
# Usage: $find $replace $range
#
find_and_replace_outside_range(){
	sed '$3 !s/'$1'/'$2'/g' "${@:4}"
}
#
# Find and replace on nth instance of line
# Usage: $find $replace $range
#
find_and_replace_nth_instance(){
	sed 's/'$find'/'$replace'/'$nth_instance'' "${@:4}"
}
#
# Find and replace on nth instance of line
# Usage: $find $replace $range
#
find_and_replace_within_start_end(){
	sed -e '/'$3'/,/^'$4'/s/'$1'/'$2'/g'${@:4}
}
#
# Print line immediately before match 
# Usage: $pattern
#
print_line_preceeding_pattern() {
    sed -n '/'$1'/{g;1!p;};h' ${@:2} 
}
#
# Print line immediately after match 
# Usage: $pattern
#
print_line_suceeding_pattern(){
sed -n '/'$1'/{n;p;}' ${@:2}
}
#
# Print all lines after and including pattern match 
# Usage: $pattern
#
print_line_matching_pattern_and_all_subsequent(){
    sed '/'$1'/,$!d' ${@:2}
}
#
# Print all lines that match pattern; give context
# Usage: $pattern
#
print_line_matching_pattern_with_context(){
    sed -n -e '/'$1'/{=;x;1!p;g;$!N;p;D;}' ${@:2}
}
#
# Print all lines that match pattern
# Usage: $pattern
#
print_lines_matching_pattern(){
sed '/'$1'/!d' ${@:2}
}
#
# Print lines with no less than n characters 
# Usage: print_lines_min_nchars $nchars
#
print_lines_min_nchars(){
sed -n '/^.\{$1\}/p' ${@:2}
}
#
# Print lines with no greater than n characters 
# Usage: print_lines_max_nchars $nchars
#
print_lines_max_nchars(){
sed -n '/^.\{$1\}/!p'${@:2} 
}
#
# Print the remainder of the line following match
# Usage: print_substring_after_matching_pattern $pattern
#
print_substring_after_matching_pattern(){
sed -n -e 's/^.*'$1' //p' ${@:2}
}
#
# Print word immediately after match
# Usage: print_word_after_matching_pattern @pattern
#
print_word_after_matching_pattern(){
sed -n -e 's/^.*'$1' //p' ${@:2}
}
#
# Comment all lines
# Usage: comment_all_lines
#
comment_all_lines(){
sed "s/^/#/g" $@
}
#
# Comment lines from start to end(
# Usage: comment_lines_from_start_to_end $start $end
#
comment_lines_from_start_to_end(){
sed "$start,$end {s/^/#/}"  ${@:3}
}
#
# Uncomment lines from start to end
# Usage: uncomment_lines_from_start_to_end $start $end
#
uncomment_lines_from_start_to_end(){
sed "$start,$end {s/'^#'//}"  ${@:3}
}
#
# Uncomment all lines matching pattern
# usage: uncomment_lines_matching_pattern
#
uncomment_lines_matching_pattern(){
sed '/'$1'/s/^/#/g' $@ ${@:2}
}
#
# Uncomment all lines 
# usage: uncomment_all_lines
#
uncomment_all_lines(){
    sed 's/^#//g'  $@
}
#
# Capitalize word matching pattern
# Usage: change_word_matching_pattern_to_uppercase
#
change_word_matching_pattern_to_uppercase(){
    sed -r "s/\<'$1'[a-z]+/\U&/g" ${@:2}
}
#
# Join two lines ending with '\' into 1 
# Usage: join_two_lines_backslash
#
join_two_lines_backslash(){
    sed ':a; /\$/N; s/\\n//; ta'  $@
}
#
# Sort paragraphs alphabetically
# Usage: sort_paragraphs_alphabetically
#
sort_paragraphs_alphabetically(){
  (sed '/./{H;d;};x;s/\n/={NL}=/g'| sort | sed '1s/={NL}=//;s/={NL}=/\n/g')
}
#
# Print paragraph containing pattern
# Usage: print_paragraph_containing_pattern $pattern
#
print_paragraph_containing_pattern(){
  sed '/./{H;$!d;};x;/'$1'/!d' ${@:2}
}
#
# Insert a newline below matching lines 
# Usage: insert_linebreak_below_matching_lines $pattern
#
insert_linebreak_below_matching_lines(){
  sed '/'$1'/G' ${@:2}
}
#
# Insert a newline above matching lines 
# Usage: insert_linebreak_above_matching_lines $pattern
#
insert_linebreak_above_matching_lines(){
  sed '/'$1'/{x;p;x;}' ${@:2}
}
#
# Insert a newline between matching lines 
# Usage: insert_linebreak_between_matching_lines $pattern
#
insert_linebreak_between_matching_lines(){
  sed '/'$1'/{x;p;x;G;}' ${@:2}
}
#
# Delete last line of each paragraph
# Usage: delete_last_line_of_each_paragraph
#
delete_last_line_of_each_paragraph(){
  sed -n '/^$/{p;h;};/./{x;/./p;}' $@
}
#
# Print every nth line starting at x 
# Usage: print_every_nthline_starting_with_linex $nth $linex
#
print_every_nthline_starting_with_linex(){
  sed -n '$1~$2' ${@:3}
}
#
# Delete lines matching pattern
# Usage: delete_lines_matching_pattern $pattern
#
delete_lines_matching_pattern(){
sed '/'$1'/d' "${@:2}"
}
#
# Delete all blank lines
# Usage: delete_all_blank_lines
#
delete_all_blank_lines(){
sed '/./!d' $@
}
#
# Delete all whitespace lines
# Usage: delete_all_whitespace_lines
#
delete_all_blank_whitespace_lines(){
sed "/^\s*$/d" $@
}
#
# Delete all consecutive blank lines except end
# Usage: delete_all_consecutive_blank_lines_except_end
#
delete_all_consecutive_blank_lines_except_end(){
  sed '/./,/^$/!d' $@
}
#
# Delete all consecutive blank lines except start
# Usage: delete_all_consecutive_blank_lines_except_start
#
delete_all_consecutive_blank_lines_except_start(){
  sed '/^$/N;/\n$/D' $@
}
#
# Read lines from bottom to top
# Usage:read_lines_bottom_to_top
#
read_lines_bottom_to_top(){
    sed '1!G;h;$!d' $@
}
#
# Read lines from right to left
# Usage:read_lines_right_to_left
#
read_lines_right_to_left(){
sed '/\n/!G;s/\(.\)\(.*\n\)/&/;//D;s/.//' $@
}
#
# Strip HTML tags
# Usage: remove_html_tags
#
#
remove_html_tags(){
	sed -e :a -e 's/<[^>]*>//g;/</N;//ba' $@
}
#
# join an absolute path with a relative path
# Usage: join_pathAbsolute_with_pathRelative $pathAbsolute $pathRelative
#
join_pathAbsolute_with_pathRelative(){
	sed 's@'$pathAbsolute'@&'/$pathRelative'@g' ${@:3}
}
