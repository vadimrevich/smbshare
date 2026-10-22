#Requires -Version 2
#Requires -RunAsAdmin
<#
# Repair and Insecure SMB Protocol
# at Windows 10 Computers
# Copyright (c) New Internet Technologies Inc. 2026
#>

### Set Functions

function Set-RegistryRepair {

    # Set Variables
    $regexe = Join-Path -Path $env:SystemRoot -ChildPath "System32\reg.exe"
    $regnode01="HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
    $regnode02="HKLM\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"
    $regnode03="HKLM\SOFTWARE\WOW6432Node\Policies\Microsoft\Windows\LanmanWorkstation"

    # Run Payloads
    & $regexe add $regnode01 /v RequireSecuritySignature /t REG_DWORD /d 0 /f
    & $regexe add $regnode02 /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f
    & $regexe add $regnode03 /v AllowInsecureGuestAuth /t REG_DWORD /d 1 /f
}

function Set-PoshRepair {

    # Run Payloads
    Set-SmbClientConfiguration -EnableInsecureGuestLogons $true -Force
    Set-SmbClientConfiguration -RequireSecuritySignature $false -Force
    Set-SmbServerConfiguration -RequireSecuritySignature $false -Force
}

function Delete-RegistryRepair {

    # Set Variables
    $regexe = Join-Path -Path $env:SystemRoot -ChildPath "System32\reg.exe"
    $regnode01="HKLM\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0"
    $regnode02="HKLM\System\CurrentControlSet\Services\NetBt\Parameters"
    
    # Run Payloads
    & $regexe delete $regnode01 /v RestrictReceivingNTLMTraffic /f
    & $regexe delete $regnode01 /v RestrictSendingNTLMTraffic /f
    & $regexe delete $regnode02 /v NodeType /f
    & $regexe delete $regnode02 /v DhcpNodeType /f
}

Delete-RegistryRepair

