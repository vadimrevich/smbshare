#requires -version 3.0

<#
This command will attempt to execute a very simple scriptblock remotely using Invoke-Command. If the command fails
then PowerShell remoting is not properly enabled or configured.
#>
Function Test-PSRemoting {
[cmdletbinding()]

Param(
[Parameter(Position=0,Mandatory,HelpMessage = "Enter a computername",ValueFromPipeline)]
[ValidateNotNullorEmpty()]
[Alias('Cn')]
[string]$Computername,
[System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
[ValidateRange(1, 65535)]
[int]$Port,
[switch]$UseSSL,
[string]$ConfigurationName,
[string]$ApplicationName,
[System.Management.Automation.Remoting.PSSessionOption]$SessionOption,
[System.Management.Automation.Runspaces.AuthenticationMechanism]$Authentication,
[string]$CertificateThumbprint
)

Begin {
    Write-Verbose "Starting $($MyInvocation.Mycommand)"  

    #add a very,very simple scriptblock to PSBoundParameters
    $sb = { 1 }
    $PSBoundParameters.Add("Scriptblock",$sb)

    Write-Verbose "PSBoundparameter:"
    Write-Verbose ($PSBoundParameters | out-string).Trim()
} #begin

Process {
  Write-Verbose "Testing $computername"
  Try {
    #splat PSBoundParameters to Invoke-Command
    $r = Invoke-Command @PSBoundParameters -ErrorAction Stop
    #if no error remoting should be working
    $True 
  }
  Catch {
    Write-Verbose $_.Exception.Message
    $False
  }

} #Process

End {
    Write-Verbose "Ending $($MyInvocation.Mycommand)"
} #end

} #close function

Test-PSRemoting
