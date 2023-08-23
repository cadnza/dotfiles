# Define Booz Allen teal
$cBah = "1;128;126"

# Redefine colors
$cUser = "$([char]27)[38;2;$cBah" + "m"
$cMachine = "$([char]27)[38;2;255;255;255m"
$cDirectory = "$([char]27)[3m$([char]27)[38;2;$cBah" + "m"

# Show logo
$bahPre = "$([char]27)[1m$([char]27)[48;2;$cBah" + "m$([char]27)[38;2;255;255;255m"
$bahSpace = "                                      "
$bahLogo = $bahPre
$bahLogo += $bahSpace
$bahLogo += "`n"
$bahLogo += "       Booz | Allen | Hamilton        "
$bahLogo += "`n"
$bahLogo += $bahSpace
$bahLogo += "`n"
$bahLogo += "$([char]27)[3m"
$bahLogo += "  Empower People to Change the World  "
$bahLogo += "$([char]27)[23m"
$bahLogo += "`n"
$bahLogo += $bahSpace
$bahLogo += $charReset
$bahLogo += "`n"
Write-Host $bahLogo
