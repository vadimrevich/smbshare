#######
# Set-AccountTokenFilterPolicy.ps1
# This Script will allow Eleveted Connection to the Remote Computer
#######

### Run Payload
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
