# Import the Chocolatey Profile (for completions)
$ChocolateyProfile = "C:\ProgramData\chocoportable\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
	Import-Module "$ChocolateyProfile"
}

# Define Microsoft colors (https://usbrandcolors.com/microsoft-colors/)
$msOrange = "242;80;34"
$msGreen = "127;186;0"
$msBlue = "0;164;239"
$msYellow = "255;185;0"
$msGrey = "115;115;115"

# Define characters
$charSep = " | "

# Set prompt
function prompt {
	"$([char]27)[38;2;$msOrange" + "m$env:USERNAME$([char]27)[0m$([char]27)[38;2;$msGrey" + "m$charSep$([char]27)[0m$([char]27)[38;2;$msYellow" + "m$env:COMPUTERNAME$([char]27)[0m $([char]27)[38;2;$msBlue" + "m$( Split-Path $PWD -Leaf )$([char]27)[0m "
}
