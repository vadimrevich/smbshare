function Winrm_scanner {


Write-Output " ___       __   ___  ________   ________  _____ ______           ________  ________  ________  ________   ________   _______   ________     "
Write-Output "|\  \     |\  \|\  \|\   ___  \|\   __  \|\   _ \  _   \        |\   ____\|\   ____\|\   __  \|\   ___  \|\   ___  \|\  ___ \ |\   __  \    "
Write-Output "\ \  \    \ \  \ \  \ \  \\ \  \ \  \|\  \ \  \\\__\ \  \       \ \  \___|\ \  \___|\ \  \|\  \ \  \\ \  \ \  \\ \  \ \   __/|\ \  \|\  \   "
Write-Output " \ \  \  __\ \  \ \  \ \  \\ \  \ \   _  _\ \  \\|__| \  \       \ \_____  \ \  \    \ \   __  \ \  \\ \  \ \  \\ \  \ \  \_|/_\ \   _  _\  "
Write-Output "  \ \  \|\__\_\  \ \  \ \  \\ \  \ \  \\  \\ \  \    \ \  \       \|____|\  \ \  \____\ \  \ \  \ \  \\ \  \ \  \\ \  \ \  \_|\ \ \  \\  \| "
Write-Output "   \ \____________\ \__\ \__\\ \__\ \__\\ _\\ \__\    \ \__\        ____\_\  \ \_______\ \__\ \__\ \__\\ \__\ \__\\ \__\ \_______\ \__\\ _\ "
Write-Output "    \|____________|\|__|\|__| \|__|\|__|\|__|\|__|     \|__|       |\_________\|_______|\|__|\|__|\|__| \|__|\|__| \|__|\|_______|\|__|\|__|"
Write-Output "                                                                   \|_________|                                                             "
Write-Output "                                                                                                                                            "

Write-Output "Choose an option:"
Write-Output "Option 1: Single IP Scan             |       Option 2: IP List Scan        "

#Prompt For Options

$options = Read-Host -Prompt "Chosen Option (Enter 1 or 2)"


# User has chosen IPList

if ($options -eq "2") {

# Prompt for IPList

$iplist = Read-Host -Prompt "Please enter IPList location (Example: C:\Temp\IPlist.txt)"

#Get the IPList

$ips = Get-Content $iplist


foreach ($serverip in $ips){

#For each IP, Scan WINRM

$results = test-netconnection -ComputerName "$serverip" -CommonTCPPort WINRM -InformationLevel Quiet



if ($results -eq "True"){

#If successful, write message

Write-Output "$serverip has WinRM service enabled"


} 

#If failed, write message

elseif ($results -eq "False" -or $results -contains "failed") {

Write-Output "$serverip doesn't appear to be running WinRM"


}

}

# User has chosen Single IP

} elseif ($options -eq "1"){

# Prompt for IP Address

$singleip = Read-Host -Prompt "Enter the IP Address"

#Test WINRM against IP

$result = test-netconnection -ComputerName "$singleip" -CommonTCPPort WINRM -InformationLevel Quiet

#If successful, write message

if ($result -eq "True"){

Write-Output "$singleip has WinRM service enabled"


} 

#If failed, write message

elseif ($result -eq "False" -or $result -contains "failed") {

Write-Output "$singleip doesn't appear to be running WinRM"


}

}

}