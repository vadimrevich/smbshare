rem *******************************************************
rem sshfs-raspberrypi.mount.cmd
rem *******************************************************

rem Set Variables

set NETDISK=y:
set anURL=pi@home.netip4.ru
set aPORT=21022
set CYGFUSE=WinFsp;
set PATH=%PATH%;%ProgramFiles%\SSHFS-Win\bin
set CURDIR=%CD%

rem Run payloads
rem

rem cd /d "C:\Program Files\SSHFS-Win\bin"
cd /d "%ProgramFiles%\SSHFS-Win\bin"
sshfs.exe %anURL% %NETDISK% -f -o idmap=user -o PORT=%aPort%
rem cd/d %CURDIR%

