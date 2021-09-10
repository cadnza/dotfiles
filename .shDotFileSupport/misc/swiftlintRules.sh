#!/usr/bin/env zsh

# Go to shDotFiles directory
cd $(git -C $(dirname $0:A) rev-parse --show-toplevel)

# Get master rules table
t=$(swiftlint rules)

# Open final variable
final=""

# Open loop through rows
echo $t | while read -r line
do
	# Skip drawn borders
	[[ $(echo $line | grep -c "^\+") = 1 ]] && continue

	# Get rule name
	ruleName=$(echo $line | cut -d "|" -f 2 | sed "s/^ *//g" | sed "s/ *$//g")

	# Skip header row
	[[ $ruleName = "identifier" ]] && continue

	# Get opt-in value
	isOptIn=$(echo $line | cut -d "|" -f 3 | sed "s/^ *//g" | sed "s/ *$//g")

	# Get enabled value
	isEnabled=$(echo $line | cut -d "|" -f 4 | sed "s/^ *//g" | sed "s/ *$//g")

	# Skip rules that are either opt-in and enabled or opt-out and disabled
	[[ $isOptIn = "yes" ]] && [[ $isEnabled = "yes" ]] && continue
	[[ $isOptIn = "no" ]] && [[ $isEnabled = "no" ]] && continue

	# Format title into link
	link="https://realm.github.io/SwiftLint/$ruleName.html"

	# Format link according to opt-in and enabled status
	[[ $isOptIn = "yes" ]] && \
		link="\033[38;5;10m"$link"\033[0m" \
	|| \
		link="\033[38;5;0;48;5;9m"$link"\033[0m"

	# Add link to final
	final=$final$link"\n"

# Close loop
done

# Echo
echo -en $final

# Exit
exit 0
