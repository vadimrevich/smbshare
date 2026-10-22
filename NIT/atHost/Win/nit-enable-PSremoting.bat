@echo on
rem *******************************************************
rem nit-enable-PSremoting.bat
rem This Script will Enable WinRM at Local Computer
rem *******************************************************
@echo on

rem adjust the winrm service

call winrm quickconfig -quiet

call winrm set winrm/config/winrs @{MaxMemoryPerShellMB="512"}

call winrm set winrm/config @{MaxTimeoutms="1800000"}

call winrm set winrm/config/service @{AllowUnencrypted="true"}

call winrm set winrm/config/service/auth @{Basic="true"}

rem Adjust the winrm Clients

call winrm set winrm/config/client @{AllowUnencrypted="true"}

call winrm set winrm/config/client/auth @{Basic="true"}

call winrm set winrm/config/client @{TrustedHosts="<local>"}

rem Start WinRM Service

sc config winrm start= auto

net start winrm

