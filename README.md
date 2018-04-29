
# Find and replace


## Find and replace any match anywhere in the file

	sed 's/'$find'/'$replace'/g'

## Find and replace on lines containing pattern

	sed '/'$pattern'/'$find'/'$replace'/g'

## Find and replace the first match 

    sed 's/'$find'/'$replace'/'

## Find and replace only on the last match

	sed 's/\(.*\)'$find'/'$replace'/'

## Find and replace inside a range of lines

	sed '$range s/'$find'/'$replace'/g' 

## Find and replace outside a range of lines 

	sed '$range !s/'$find'/'$replace'/g' 

## Find and replace the nth instance in a line

	sed 's/'$find'/'$replace'/$nth_instance''

## Find and replace if within matching $start and $end pattern 

    sed -e '/'$start'/,/^'$end'/s/'$find'/'$replace'/g' 

## Print every nth line starting with x

	sed -n '$n~$xp' 
	
## Print paragraphs only if they contain pattern

	sed '/./{H;$!d;};x;/'$pattern'/!d'

# Translations

## Comment lines from $start to $end

    sed "$start,$end {s/^/#/}"  

## Change word to uppercase uppercase if matching pattern

    sed -r "s/\<'$pattern'[a-z]+/\U&/g"   


## Join two lines if the first ends in a backslash

	sed ':a; /\$/N; s/\\n//; ta'  

## Remove characters in set from lines

	set="[0-9]"
	sed 's/'$set'//g' 

## Read lines from bottom-to-top (tac)

	sed '1!G;h;$!d' 

## Read lines from right to left (rev)

    sed '/\n/!G;s/\(.\)\(.*\n\)/&\
    /;//D;s/.//'

## Insert strings $before and $after to lines matching pattern

    sed '/'$pattern'/s@^.*$@'$before'&'$after'@g'

## Join a relative and absolute path

    sed 's@'$pathAbsolute'@&'/$pathRelative'@g'

## Remove HTML tags  
    sed -e :a -e 's/<[^>]*>//g;/</N;//ba'

## Sort paragraphs alphabetically

	(sed '/./{H;d;};x;s/\n/={NL}=/g'| sort | sed '1s/={NL}=//;s/={NL}=/\n/g')



# Printing lines matching patterns

## Print the line matching a pattern

    sed '/'$pattern'/!d' 

## Print the line immediately before pattern 

    sed -n '/'$pattern'/{g;1!p;};h' 

## Print the line immediately after pattern 

    sed -n '/'$pattern'/{n;p;}' 

## Print the line matching pattern and all subsequent lines

    sed '/'$pattern'/,$!d

## Print lines matching a pattern and give context and position

    sed -n -e '/'$pattern'/{=;x;1!p;g;$!N;p;D;}'

## Print lines matching multiple patterns in any order

	sed '/'$pattern3'/!d; /'$pattern1'/!d; /'$pattern2'/!d' 

## Print lines matching multiple patterns in a specific order  

	sed '/'$pattern1'.*'$pattern2'.*'$pattern3'/!d' 

## Print lines matching a minimum number characters

	sed -n '/^.\{$n\}/p' 

## Print lines matching a maximum number characters 

    sed -n '/^.\{$n\}/!p' 

## Print substring of a line after matching a section
	sed -n -e 's/^.*'$word' //p' 

---

# Deleting lines with sed

## Delete lines matching pattern

    sed '/'$pattern'/d' 

## Delete all blank lines

    sed '/./!d' 

## Delete all blank/whitespace lines 

    sed "/^\s*$/d"

## Delete all consecutive blank lines except for end

    sed '/./,/^$/!d' 

## Delete all consecutive blank lines except start

    sed '/^$/N;/\n$/D' 

## Delete all consecutive blank lines except for the first two

    sed '/^$/N;/\n$/N;//D' 

## Delete all leading blank lines

    sed '/./,$!d' 

## Delete all trailing blank lines

    sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' 

## Delete every nth line after $start 
 
    sed '"$start"~"$nth"d' 

## Delete the last line of each paragraph

    sed-n '/^$/{p;h;};/./{x;/./p;}'

## Insert blank line below lines that match pattern

	sed '/'$pattern'/G' 

## Insert blank line above lines that match pattern

	sed '/'$pattern'/{x;p;x;}'

## Insert blank line above and below matching lines

	sed '/'$pattern'/{x;p;x;G;}'

# Uncategorized 

## Number lines - delimiting with tab

    sed = \ | sed 'N;s/\n/\t/') 




<!--stackedit_data:
eyJoaXN0b3J5IjpbMTQyNjM5MzIxNywxNjc2MDAzNDA1LDE0Mj
YzOTMyMTddfQ==
-->