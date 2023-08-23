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
$charReset = "$([char]27)[0m"

# Set colors
$colorUser = "$([char]27)[38;2;$msOrange" + "m"
$colorSep = "$([char]27)[38;2;$msGrey" + "m"
$colorMachine = "$([char]27)[38;2;$msYellow" + "m"
$colorDirectory = "$([char]27)[38;2;$msBlue" + "m"

# Set prompt
function prompt {
	"$colorUser$env:USERNAME$charReset$colorSep$charSep$charReset$colorMachine$env:COMPUTERNAME$charReset $colorDirectory$( Split-Path $PWD -Leaf )$charReset "
}
