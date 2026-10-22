#Requires -Version 5.1

#####
# NIT.Get-VCRedist.ps1
# This Script will get Visual Studio C++ Redistributible Versions
# on Microsoft Windows server operation systems
#
#####

#### Set Variables ####

#### Run Payloads ####

# Source - https://stackoverflow.com/a/79334549
# Posted by Tilo
# Retrieved 2026-02-13, License - CC BY-SA 4.0

##check VC Redistributable packages installed
 Get-ChildItem HKLM:\SOFTWARE\WoW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | ForEach-Object { 
    $CurDisplayName = $_.GetValue("DisplayName")
    if( $CurDisplayName -match "^Microsoft Visual C\+\+\D*(?<Year>(\d|-){4,9}).*Redistributable.*") {
        #$Year = $Matches.Year
        echo $Matches.0
    }
}


