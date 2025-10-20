# Define light profiling function to measure time since last invocation of this function
function Measure-TimeSince {
    if ((Get-Variable 'startTimeForTimeSinceFunction' -ErrorAction SilentlyContinue) -and (Get-Variable 'nthInvocationForTimeSinceFunction' -ErrorAction SilentlyContinue)) {
        $global:nthInvocationForTimeSinceFunction += 1
        Write-Warning "TIME SINCE LAST INVOCATION ($nthInvocationForTimeSinceFunction): $($($(Get-Date) - $startTimeForTimeSinceFunction).TotalMilliseconds)"
    } else {
        $global:nthInvocationForTimeSinceFunction = 0
    }
    $global:startTimeForTimeSinceFunction = Get-Date
}

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

# Set colors
$cUser = "$([char]27)[38;2;$cMsOrange" + "m"
$cSep = "$([char]27)[38;2;$cMsGrey" + "m"
$cMachine = "$([char]27)[38;2;$cMsYellow" + "m"
$cDirectory = "$([char]27)[38;2;$cMsBlue" + "m"

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

    # Return
    return $final
}
