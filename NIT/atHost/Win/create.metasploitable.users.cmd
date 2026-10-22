@echo off
rem *******************************************************
rem create.metasploitable3.users.cmd
rem *******************************************************
@echo off

rem This Windows batch script (create.metasploitable3.users.cmd) 
rem is designed to configure user accounts on 
rem a Windows system, specifically tailored 
rem for setting up a deliberately vulnerable 
rem virtual machine (likely Metasploitable 3).

rem Summary of Functionality:

rem User Creation:

rem The script creates multiple user accounts 
rem using the net user command, each with predefined 
rem usernames and weak passwords. Examples include:

rem CMD
rem %NETEXE% user vagrant vagrant /ADD
rem %NETEXE% user leah_organa help_me_obiw@n /ADD

rem These users are fictional or themed 
rem (e.g., Star Wars characters), which 
rem suggests this is intended for training 
rem or penetration testing.

rem Privilege Escalation:

rem It adds the vagrant user to the local 
rem Administrators group:

rem CMD
rem %NETEXE% localgroup Администраторы vagrant /ADD

Thenrem  attempts to remove vagrant from 
rem the Users group 

rem Hide Users from Login Screen:

rem Uses the reg add command to modify 
rem the Windows Registry under:

rem HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList

rem By setting a DWORD value of 0 for each non-admin 
rem user, it hides them from appearing on 
rem the welcome screen or login prompt.

rem Purpose:
rem This script automates the setup of multiple 
rem user accounts?some visible, some hidden?with 
rem known credentials and elevated privileges. 
rem It's typically used in security training 
rem environments where attackers are expected 
rem to discover and exploit these weak accounts.

rem Note: This configuration is highly insecure 
rem and should never be used in production systems.

setlocal enableextensions enabledelayedexpansion

rem Set Variables

set NETEXE=%SystemRoot%\system32\net.exe
set REGEXE=%SystemRoot%\system32\reg.exe
set REGNODE= "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList"

rem Run Payloads
rem
rem Create Users

%NETEXE% user vagrant vagrant /ADD
%NETEXE% user leah_organa help_me_obiw@n /ADD
%NETEXE% user luke_skywalker use_the_f0rce /ADD
%NETEXE% user han_solo sh00t-first /ADD
%NETEXE% user artoo_detoo beep_b00p /ADD
%NETEXE% user c_three_pio pr0t0c0l /ADD
%NETEXE% user ben_kenobi thats_no_moon /ADD
%NETEXE% user darth_vader d@rk_sid3 /ADD
%NETEXE% user anakin_skywalker yipp33!! /ADD
%NETEXE% user jarjar_binks mesah_p@ssw0rd /ADD
%NETEXE% user lando_calrissian b@ckstab /ADD
%NETEXE% user boba_fett mandalorian1 /ADD
%NETEXE% user jabba_hutt not-a-slug12 /ADD
%NETEXE% user greedo hanShotFirst! /ADD
%NETEXE% user chewbacca rwaaaaawr5 /ADD
%NETEXE% user kylo_ren daddy_issues1 /ADD

rem Add as Local Admin
%NETEXE% localgroup Администраторы vagrant /ADD
%NETEXE% localgroup Пользователи vagrant /delete


rem Hide Users
%REGEXE% ADD %REGNODE% /v leah_organa /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v luke_skywalker /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v han_solo /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v artoo_detoo /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v c_three_pio /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v ben_kenobi /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v darth_vader /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v anakin_skywalker /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v jarjar_binks /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v lando_calrissian /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v boba_fett /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v jabba_hutt /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v greedo /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v chewbacca /t REG_DWORD /d 0 /f
%REGEXE% ADD %REGNODE% /v kylo_ren /t REG_DWORD /d 0 /f

