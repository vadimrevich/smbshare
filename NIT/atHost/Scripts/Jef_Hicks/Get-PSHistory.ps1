#requires -version 5.1


<#
This is a copy of:

CommandType Name        Version Source                   
----------- ----        ------- ------                   
Cmdlet      Get-History 3.0.0.0 Microsoft.PowerShell.Core

Created: 07 July 2020
Author : Jeff Hicks

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

#>


Function Get-PSHistory {

[CmdletBinding(DefaultParameterSetName = "ID")]
[alias("hh")]
[OutputType([Microsoft.PowerShell.Commands.HistoryInfo])]

Param(

    [Parameter(Position=0, ValueFromPipeline=$true,ParameterSetName="ID")]
    [ValidateRange(1, 9223372036854775807)]
    [long[]]$Id,

    [Parameter(Position=1,ParameterSetName="ID")]
    [Parameter(ParameterSetName="status")]
    [ValidateRange(0, 32767)]
    [int]$Count,

    [Parameter(ParameterSetName="status",HelpMessage="Filter by execution state")]
    [Alias("es")]
    [System.Management.Automation.Runspaces.PipelineState]$ExecutionState
)

Begin {

    Write-Verbose "[BEGIN  ] Starting $($MyInvocation.Mycommand)"
    Write-Verbose "[BEGIN  ] Using parameter set $($PSCmdlet.ParameterSetName)"
    if ($PSBoundParameters.ContainsKey("ExecutionState")) {
        [void]($PSBoundParameters.Remove("ExecutionState"))
        #also remove Count because that will be used for a slightly different purpose
        [void]($PSBoundParameters.Remove("Count"))
    }
    Write-Verbose ($PSBoundParameters | Out-String)

} #begin

Process {
    if ($ExecutionState) {
        Write-Verbose "[PROCESS] Filtering on ExecutionState"
        $filtered = (Get-History @PSBoundParameters).where({$_.ExecutionStatus -eq $executionState})
        if ($count -gt 0) {
            Write-Verbose "[PROCESS] Getting $count most recent entries"
            $filtered | Select-Object -last $count
        }
        else {
            $Filtered
        }
    }
    else {
        Get-History @PSBoundParameters
    }

} #process

End {
    Write-Verbose "[END    ] Ending $($MyInvocation.Mycommand)"

} #end

} #end function Get-PSHistory