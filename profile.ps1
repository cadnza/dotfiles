# Import the Chocolatey Profile (for completions)
$ChocolateyProfile = "C:\ProgramData\chocoportable\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Import posh-git for git indicators
$poshgitPsd = "$HOME\Repos\posh-git\src\posh-git.psd1"
if ( Test-Path -Path $poshGitPsd) {
	Import-Module $poshgitPsd
	$hasPoshgit = $true
}
else {
	Write-Host "$([char]27)[41;30mposh-git not installed; see https://github.com/dahlbyk/posh-git$([char]27)[0m"
	$hasPoshgit = $false
}

# Define Microsoft colors (https://usbrandcolors.com/microsoft-colors/)
$cMsOrange = "242;80;34"
$cMsGreen = "127;186;0"
$cMsBlue = "0;164;239"
$cMsYellow = "255;185;0"
$cMsGrey = "115;115;115"

# Define characters
$charSep = " | "
$charReset = "$([char]27)[0m"

# Set colors
$cUser = "$([char]27)[38;2;$cMsOrange" + "m"
$cSep = "$([char]27)[38;2;$cMsGrey" + "m"
$cMachine = "$([char]27)[38;2;$cMsYellow" + "m"
$cDirectory = "$([char]27)[38;2;$cMsBlue" + "m"

# Set prompt
function prompt {
	$final = "$cUser$env:USERNAME$charReset$cSep$charSep$charReset$cMachine$env:COMPUTERNAME$charReset $cDirectory$( Split-Path $PWD -Leaf )$charReset "

	if ($hasPoshgit) {
	}

	return $final
}
