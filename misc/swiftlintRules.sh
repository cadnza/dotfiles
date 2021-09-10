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

	# Get untrimmed name
	ruleNameUntrimmed=$(echo $line | cut -d "|" -f 2 | sed "s/^ *//g")

	# Get trimmed name
	ruleName=$(echo $ruleNameUntrimmed | sed "s/ *$//g")

	# Get untrimmed kind
	kindUntrimmed=$(echo $line | cut -d "|" -f 6 | sed "s/^ *//g")

	# Get trimmed kind
	kind=$(echo $kindUntrimmed | sed "s/ *$//g")

	# Remove whitespace from line
	line=$(echo $line | sed "s/ //g")

	# Skip header row
	[[ $ruleName = "identifier" ]] && continue

	# Get opt-in value
	isOptIn=$(echo $line | cut -d "|" -f 3)

	# Get enabled value
	isEnabled=$(echo $line | cut -d "|" -f 5)

	# Get correctable-capable
	isCorrectable=$(echo $line | cut -d "|" -f 4)

	# Get analyzer-capable
	isAnalyzable=$(echo $line | cut -d "|" -f 6)

	# Get link from title
	link="https://realm.github.io/SwiftLint/$ruleName.html"

	# Set light characters
	lightOn="\u25CF"
	lightOff="\u25CB"

	# Format name by opt-in and enabled
	[[ $isOptIn = "yes" ]] && [[ $isEnabled = "yes" ]] && \
		final_ruleNameUntrimmed="\033[38;5;0;48;5;2m"$ruleNameUntrimmed"\033[0m"
	[[ $isOptIn = "yes" ]] && [[ $isEnabled = "no" ]] && \
		final_ruleNameUntrimmed="\033[38;5;2m"$ruleNameUntrimmed"\033[0m"
	[[ $isOptIn = "no" ]] && [[ $isEnabled = "yes" ]] && \
		final_ruleNameUntrimmed="\033[38;5;0;48;5;1m"$ruleNameUntrimmed"\033[0m"
	[[ $isOptIn = "no" ]] && [[ $isEnabled = "no" ]] && \
		final_ruleNameUntrimmed="\033[38;5;1m"$ruleNameUntrimmed"\033[0m"

	# Format correctable
	[[ $isCorrectable = "yes" ]] && \
		final_isCorrectable="\033[38;5;11m$lightOn\033[0m" \
	|| \
		final_isCorrectable="\033[38;5;8m$lightOff\033[0m"
	final_isCorrectable="\033[38;5;11m$final_isCorrectable\033[0m"

	# Format kind
	[[ $kind = "idiomatic" ]] && kindColor=3
	[[ $kind = "lint" ]] && kindColor=7
	[[ $kind = "metrics" ]] && kindColor=9 #change #TEMP
	[[ $kind = "performance" ]] && kindColor=13
	[[ $kind = "style" ]] && kindColor=14
	final_kindUntrimmed="\033[38;5;"$kindColor"m$kindUntrimmed\033[0m"

	# Build string
	border="|"
	newRow="$border $final_isCorrectable $final_ruleNameUntrimmed $final_kindUntrimmed$border"

	# Add link to final
	final=$final$newRow"\n"

# Close loop
done

# Echo
echo -en $final

# Exit
exit 0
