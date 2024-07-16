############################################################
# Set-ScriptAcl-003.ps1
# This Script Sets a Downloaded Scripts Acls
############################################################

# Make Owner of Scripts an Administrators Group
&takeown /F C:\.BIN\smbshare\*.* /R /A

# Set ACL on Downloaded Files...
# Full Access for Administrators (SID S-1-5-32-544)
&icacls C:\.BIN\smbshare\*.* /grant *S-1-5-32-544:F /t /C
# Full Access for Computer Administrator
$sid = Get-LocalUser | Select SID | Where SID -Like "*-500"
$sid1="*"+($sid).SID + ":F"
&icacls C:\.BIN\smbshare\*.* /grant $sid1 /t /C
#
&icacls C:\.BIN\smbshare\*.* /grant vagrant:F /t /C
&icacls C:\.BIN\smbshare\*.* /grant yuden:F /t /C
&icacls C:\.BIN\smbshare\*.* /grant mssqlsr:F /t /C
# Full Access for Everyone (SID S-1-1-0)
&icacls C:\.BIN\smbshare\*.* /grant *S-1-1-0:F /t /C
