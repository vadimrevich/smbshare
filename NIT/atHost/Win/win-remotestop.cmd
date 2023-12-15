@echo off
rem Remote Services Stop on WIN Server

winrs -r:win "%AdminT%\remote_stop.cmd"
winrs -r:win "net start sshd"


