#!/usr/bin/env zsh

# This script shows swiftlint rules according to how they stand with the global
# swiftlint configuration in the shDotFiles repo. It only shows rules that are
# either opt-in and disabled or opt-out and enabled. Opt-in are green; opt-out
# are red. Happy configuring!

# Go to shDotFiles directory
cd $(git -C $(dirname $0:A) rev-parse --show-toplevel)

# Open final variable
final=""

# Open loop through rows
swiftlint rules | while read -r line
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
	isEnabled=$(echo $line | cut -d "|" -f 5 | sed "s/^ *//g" | sed "s/ *$//g")

	# Format title into link
	link="https://realm.github.io/SwiftLint/$ruleName.html"

	# Format link according to opt-in and enabled status
	[[ $isOptIn = "yes" ]] && [[ $isEnabled = "yes" ]] && \
		link="\033[38;5;0;48;5;10m"$link"\033[0m"
	[[ $isOptIn = "yes" ]] && [[ $isEnabled = "no" ]] && \
		link="\033[38;5;10m"$link"\033[0m"
	[[ $isOptIn = "no" ]] && [[ $isEnabled = "yes" ]] && \
		link="\033[38;5;0;48;5;9m"$link"\033[0m"
	[[ $isOptIn = "no" ]] && [[ $isEnabled = "no" ]] && \
		link="\033[38;5;9m"$link"\033[0m"

	# Add link to final
	final=$final$link"\n"

# Close loop
done

# Echo
echo -en $final

# Exit
exit 0
