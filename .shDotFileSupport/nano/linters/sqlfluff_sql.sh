#!/usr/bin/env zsh

# Open final variable
final=""

# Open loop to format sqlfluff messages
sqlfluff lint -n $1 | grep "^L:" | while read -r msg
do
	# Set delimiter
	delim="|"
	# Get line and column numbers
	rw=$(echo $msg | cut -d $delim -f 1 | grep -o "[0-9]*")
	cn=$(echo $msg | cut -d $delim -f 2 | grep -o "[0-9]*")
	# Get linting note
	note=$(echo $msg | cut -d $delim -f 4 | sed 's/^ *//g' | sed 's/ *$//g')
	# Add to final
	final="$final$1:$rw:$cn: $note\n"
done

# Echo
echo $final

# Exit
exit 0
