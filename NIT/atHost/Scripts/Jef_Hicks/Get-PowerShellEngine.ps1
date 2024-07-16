#Requires -version 4.0

Function Get-PowerShellEngine {
    <#
    .Synopsis
    Get the path to the current PowerShell engine
    .Description
    Use this command to find the path to the PowerShell executable, or engine that is running your current session. The path for PowerShell 6 is different than previous versions.

    The default is to provide the path only. But you can also get detailed information
    .Parameter Detail
    Include additional information. Not all properties may have values depending on operating system and PowerShell version.
    .Example
    PS C:\> Get-PowerShellEngine
    C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe
    .Example
    PS C:\> Get-PowerShellEngine -detail

    Path           : C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe
    FileVersion    : 10.0.15063.0 (WinBuild.160101.0800)
    PSVersion      : 5.1.15063.502
    ProductVersion : 10.0.15063.0
    Edition        : Desktop
    Host           : Visual Studio Code Host
    Culture        : en-US
    Platform       :

    Result from running in the Visual Studio Code integrated PowerShell terminal

    .Example
    PS C:\> Get-PowerShellEngine -detail

    Path           : C:\Program Files\PowerShell\6.0.0-beta.5\powershell.exe
    FileVersion    :
    PSVersion      : 6.0.0-beta
    ProductVersion :
    Edition        : Core
    Host           : ConsoleHost
    Culture        : en-US
    Platform       : Win32NT

    Result from running in a PowerShell 6 session on Windows 10

    .Example
   PS /home/> get-powershellengine -Detail                           

    Path           : /opt/microsoft/powershell/6.0.0-beta.5/powershell
    FileVersion    : 
    PSVersion      : 6.0.0-beta
    ProductVersion : 
    Edition        : Core
    Host           : ConsoleHost
    Culture        : en-US
    Platform       : Unix

    Result from running in a PowerShell session on Linux

    .Link
    $PSVersionTable
    .Link
    $Host
    .Link
    Get-Process

    .Outputs
    [string]
    [pscustomobject]
    #>
    [CmdletBinding()]
    Param([switch]$Detail)
    
    #get the current PowerShell process and the file that launched it
    $engine =  Get-Process -id $pid | Get-Item
    if ($Detail) {
        [pscustomobject]@{
            Path = $engine.Fullname
            FileVersion = $engine.VersionInfo.FileVersion
            PSVersion = $PSVersionTable.PSVersion.ToString()
            ProductVersion = $engine.VersionInfo.ProductVersion
            Edition = $PSVersionTable.PSEdition
            Host = $host.name
            Culture = $host.CurrentCulture
            Platform = $PSVersionTable.platform
        }
    }
    else {
        $engine.FullName
    }
}
Get-PowerShellEngine
