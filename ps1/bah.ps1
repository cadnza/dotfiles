# Set Booz Allen colors

# Redefine colors
$cUser = "$([char]27)[38;2;1;128;126m"
$cMachine = "$([char]27)[38;2;255;255;255m"
$cDirectory = "$([char]27)[3m$([char]27)[38;2;1;128;126m"

# Show logo
$bahLogo = "$([char]27)[1m$([char]27)[48;2;1;128;126m$([char]27)[38;2;255;255;255m Booz | Allen | Hamilton $([char]27)[0m"
Write-Host $bahLogo
