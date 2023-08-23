# Import the Chocolatey Profile (for completions)
$modChocolateyProfile = "C:\ProgramData\chocoportable\helpers\chocolateyProfile.psm1"
if (Test-Path($modChocolateyProfile)) {
	Import-Module $modChocolateyProfile
}

# Import Get-ChildItemColor
$modGetChildItemColor = "$HOME\Repos\Get-ChildItemColor\src\Get-ChildItemColor.psm1"
if (Test-Path($modGetChildItemColor)) {
	Import-Module -DisableNameChecking $modGetChildItemColor
	Set-Alias ls Get-ChildItemColor -Option AllScope
}

# Define Microsoft colors (https://usbrandcolors.com/microsoft-colors/)
$cMsOrange = "242;80;34"
$cMsGreen = "127;186;0"
$cMsBlue = "0;164;239"
$cMsYellow = "255;185;0"
$cMsGrey = "115;115;115"

# Define Git colors
$cGitAction = 15
$cGitRepo = 6
$cGitBranch = 214
$cGitStaged = 2
$cGitUnstaged = 9
$cGitUnknown = $colorSep
$cGitUnpushed = 13
$cGitUnpulled = 10

# Set colors
$cUser = "$([char]27)[38;2;$cMsOrange" + "m"
$cSep = "$([char]27)[38;2;$cMsGrey" + "m"
$cMachine = "$([char]27)[38;2;$cMsYellow" + "m"
$cDirectory = "$([char]27)[38;2;$cMsBlue" + "m"

# Define characters
$charSep = "|"
$charReset = "$([char]27)[0m"
$sep = "$cSep$charSep$charReset"

# Set prompt
function prompt {
	$final = "$cUser$env:USERNAME$charReset $sep $cMachine$env:COMPUTERNAME$charReset $sep $cDirectory$( Split-Path $PWD -Leaf )$charReset "

	return $final
}
