# Remove logo
Clear-Host

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

# Import docker completions
if (Get-Module -ListAvailable -Name DockerCompletion) {
	Import-Module DockerCompletion
}
else {
	Write-Host 'For docker completions, run `Install-Module DockerCompletion -Scope CurrentUser`'
}

# Define Microsoft colors (https://usbrandcolors.com/microsoft-colors/)
$cMsOrange = "242;80;34"
$cMsGreen = "127;186;0"
$cMsBlue = "0;164;239"
$cMsYellow = "255;185;0"
$cMsGrey = "115;115;115"

# Define git color
$cGitOrange = "240;60;46"

# Define git character
$charGit = $([char]182)

# Set colors
$cUser = "$([char]27)[38;2;$cMsOrange" + "m"
$cSep = "$([char]27)[38;2;$cMsGrey" + "m"
$cMachine = "$([char]27)[38;2;$cMsYellow" + "m"
$cDirectory = "$([char]27)[38;2;$cMsBlue" + "m"
$cGit = "$([char]27)[5m$([char]27)[38;2;$cGitOrange" + "m"

# Define characters
$charSep = "|"
$charReset = "$([char]27)[0m"

# Source local logic
$localLogic = "$HOME\.local.ps1"
if (Test-Path $localLogic) {
	. $localLogic
}

# Set prompt
function prompt {

	# Define separator character
	# $sep = "$cSep$charSep$charReset" # Not currently in use

	# Define prompt
	$final = "$cUser$env:USERNAME$charReset $cMachine$env:COMPUTERNAME$charReset $cDirectory$( Split-Path $PWD -Leaf )$charReset "

	# Add indicator if we're in a git repo
	$gitIndicator = ""
	git rev-parse 2> $null
	if ($? -eq $true) {
		$gitIndicator = "$cGit$charGit$charReset "
	}
	$final += $gitIndicator

	# Return
	return $final
}

# Define function to go to top level of git repo
function gd {
	git rev-parse 2> $null
	$result = $?
	if ($result -eq $true) {
		Set-Location $(git rev-parse --show-toplevel)
	}
	else {
		Write-Host "gd only works inside a Git repo."
	}
}
