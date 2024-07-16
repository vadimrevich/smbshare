#requires -version 4.0
#requires -module Microsoft.WSMan.Management

<#
This is a copy of:

CommandType Name       Version Source                    
----------- ----       ------- ------                    
Cmdlet      Test-WSMan 3.0.0.0 Microsoft.WSMan.Management

Updated: 2 June 2016
Version: 2.0
Author : Jeff

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************
#>


Function Test-MyWsman {
<#

.SYNOPSIS
Tests whether the WinRM service is running on a local or remote computer.

.DESCRIPTION
This command is a modified version of Test-WsMan. The Test-MyWsman cmdlet submits an identification request that determines whether the WinRM service is running on a local or remote computer. If the tested computer is running the service, the cmdlet displays the WS-Management identity schema, the protocol version, the product vendor, and the product version of the tested service.
This version will automatically set the Authentication parameter to Default unless you specify something else. This should ensure that the ProductVersion property will have values. The result will also include the computername and separate properties for the OS, Service pack and Stack versions.

.PARAMETER ApplicationName
Specifies the application name in the connection. The default value of the ApplicationName parameter is "WSMAN". The complete identifier for the remote endpoint is in the following format:

<transport>://<server>:<port>/<ApplicationName>

For example:

http://server01:8080/WSMAN

Internet Information Services (IIS), which hosts the session, forwards requests with this endpoint to the specified application. This default setting of "WSMAN" is appropriate for most uses. This parameter is designed to be used when numerous computers establish remote connections to one computer that is running Windows PowerShell. In this case, IIS hosts Web Services for Management (WS-Management)  for efficiency.

.PARAMETER Authentication
Specifies the authentication mechanism to be used at the server.  Possible values are:
- Basic: Basic is a scheme in which the user name and password are sent in clear text to the server or proxy.
- Default : Use the authentication method implemented by the WS-Management protocol.
- Digest: Digest is a challenge-response scheme that uses a server-specified data string for the challenge.
- Kerberos: The client computer and the server mutually authenticate by using Kerberos certificates.
- Negotiate: Negotiate is a challenge-response scheme that negotiates with the server or proxy to determine the scheme to use for authentication. For example, this parameter value allows negotiation to determine whether the Kerberos protocol or NTLM is used.
- CredSSP: Use Credential Security Support Provider (CredSSP) authentication, which allows the user to delegate credentials. This option is designed for commands that run on one remote computer but collect data from or run additional commands on other remote computers.
Caution: CredSSP delegates the user's credentials from the local computer to a remote computer. This practice increases the security risk of the remote operation. If the remote computer is compromised, when credentials are passed to it, the credentials can be used to control the network session.
Important: If the authentication parameter is not specified, then the Test-MyWsman request will be sent to the remote machine anonymously (without using authentication).  If the Test-MyWsman request is made anonymously, it does not return any information that is specific to the operating-system version.  Instead, Test-MyWsman displays null values for the operating system version and service pack level (OS: 0.0.0 SP: 0.0).

.PARAMETER CertificateThumbprint
Specifies the digital public key certificate (X509) of a user account that has permission to perform this action. Enter the certificate thumbprint of the certificate.
Certificates are used in client certificate-based authentication.  They can be mapped only to local user accounts; they do not work with domain accounts.
To get a certificate thumbprint, use the Get-Item or Get-ChildItem command in the Windows PowerShell Cert: drive.

.PARAMETER ComputerName
Specifies the computer against which you want to run the management operation. The value can be a fully qualified domain name, a NetBIOS name, or an IP address. Use the local computer name, use localhost, or use a dot (.) to specify the local computer. The local computer is the default. When the remote computer is in a different domain from the user, you must use a fully qualified domain name must be used.

.PARAMETER Credential
Specifies a user account that has permission to perform this action. The default is the current user. Type a user name, such as "User01", "Domain01\User01", or User@Domain.com. Or, enter a PSCredential object, such as one returned by the Get-Credential cmdlet. When you type a user name, you will be prompted for a password.

.PARAMETER Port
Specifies the port to use when the client connects to the WinRM service. When the transport is HTTP, the default port is 80. When the transport is HTTPS, the default port is 443. When you use HTTPS as the transport, the value of the ComputerName parameter must match the server's certificate common name (CN).

.PARAMETER UseSSL
Specifies that the Secure Sockets Layer (SSL) protocol should be used to establish a connection to the remote computer. By default, SSL is not used.
WS-Management encrypts all the Windows PowerShell content  that is transmitted over the network. The UseSSL parameter lets you specify the additional protection of HTTPS instead of HTTP. If SSL is not available on the port that is used for the connection and you specify this parameter, the command fails.

.PARAMETER Quiet
Write a Boolean result to the pipeline depending on whether Test-WSMan got a result.

.EXAMPLE
PS C:\>Test-MyWsman

Computername    : WIN81-ENT-01
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
OS              : 6.3.9600
SP              : 0.0
Stack           : 3.0

This command determines whether the WinRM service is running on the local computer or on a remote computer.

.EXAMPLE
PS C:\>Test-MyWsman -computername server01

Computername    : SERVER01
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
OS              : 6.2.9200
SP              : 0.0
Stack           : 3.0

This command determines whether the WinRM service is running on the server01 computer named.

.EXAMPLE
PS C:\> test-mywsman chi-p50 -Credential globomantics\administrator -Authentication Default

Computername    : CHI-P50
wsmid           : http://schemas.dmtf.org/wbem/wsman/identity/1/wsmanidentity.xsd
ProtocolVersion : http://schemas.dmtf.org/wbem/wsman/1/wsman.xsd
ProductVendor   : Microsoft Corporation
OS              : 10.0.14300 
SP              : 0.0 
Stack           : 3.0

Test a connection using an alternate credential.
.EXAMPLE

PPS C:\> "chi-hvr2","chi-hvr1","chi-dc01","chi-p50","chi-dc04" | where {Test-MyWsman -ComputerName $_ -quiet }
chi-hvr2
chi-dc01
chi-p50
chi-dc04

Using the -Quiet parameter filter out computer names that can't be reached.

.EXAMPLE
PS C:\> test-mywsman "chi-dc01","chi-dc02","chi-dc04" | Select Computername,OS,SP,Stack

Computername OS       SP  Stack
------------ --       --  -----
CHI-DC01     6.1.7601 1.0 3.0  
CHI-DC02     6.1.7600 0.0 2.0  
CHI-DC04     6.2.9200 0.0 3.0  

Test multiple computers and display selected information.

.EXAMPLE
PS C:\> test-mywsman chi-dc01,chi-dc02,chi-dc04 | where stack -ge 3.0 | get-ciminstance win32_operatingsystem | Select PSComputername,Caption

PSComputerName Caption                                     
-------------- -------                                     
CHI-DC01       Microsoft Windows Server 2008 R2 Enterprise 
CHI-DC04       Microsoft Windows Server 2012 Datacenter   

Test several computers and filter out those with a WSMan stack version less than 3. Computers with a stack version of 3 are piped to Get-CimInstance.
.NOTES
Updated: 2 June 2016
Version: 2.0
Author : Jeff Hicks

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************
.INPUTS
[string]

.OUTPUTS
[pscustomobject]

.LINK
https://gist.github.com/jdhitsolutions/8ed8ac39130cd84e87409e948122d442

.LINK
Test-WsMan
Connect-WSMan
Disable-WSManCredSSP
Disconnect-WSMan
Enable-WSManCredSSP
Get-WSManCredSSP
Get-WSManInstance
Invoke-WSManAction
New-WSManInstance
New-WSManSessionOption
Remove-WSManInstance
Set-WSManInstance
Set-WSManQuickConfig

#>
[CmdletBinding()]
Param(

    [Parameter(Position=0, ValueFromPipeline)]
    [Alias('cn')]
    [ValidateNotNullorEmpty()]
    [string[]]$ComputerName = $env:COMPUTERNAME,

    [Alias('auth','am')]
    [ValidateNotNullOrEmpty()]
    [Microsoft.WSMan.Management.AuthenticationMechanism]$Authentication,

    [Parameter(ParameterSetName='ComputerName')]
    [ValidateNotNullOrEmpty()]
    [ValidateRange(1, 2147483647)]
    [int]$Port,

    [Parameter(ParameterSetName='ComputerName')]
    [switch]$UseSSL,

    [Parameter(ParameterSetName='ComputerName')]
    [ValidateNotNullOrEmpty()]
    [string]$ApplicationName,

    [Parameter(ValueFromPipelineByPropertyName=$true)]
    [Alias('cred','c')]
    [ValidateNotNullOrEmpty()]
    [pscredential]
    [System.Management.Automation.CredentialAttribute()]$Credential,

    [ValidateNotNullOrEmpty()]
    [string]$CertificateThumbprint,

    [Switch]$Quiet
)

Begin {

    Write-Verbose "Starting $($MyInvocation.Mycommand)"
    Write-Verbose "Using parameter set $($PSCmdlet.ParameterSetName)"
    #remove Quiet from PSBoundParameters since Test-WSMan doesn't use it
    if ($Quiet) {
        $PSBoundParameters.Remove("Quiet") | Out-Null
    }

    #add Default authentication if nothing else is specified
    #so that ProductVersion is filled out
    if (-NOT $PSBoundParameters.ContainsKey("Authentication")) {
        $PSBoundParameters.Add("Authentication","Default")
    }
    Write-Verbose ($PSBoundParameters | Out-String)

} #begin

Process {

Foreach ($computer in $Computername) {
    Write-Verbose "Testing $Computer"
    #modify PSBoundparameters
    $PSBoundParameters.Computername = $computer
    Try {
        $test = Test-WSMan @PSBoundParameters -ErrorAction Stop
 
    }
    Catch {
        Write-Verbose "[$Computer] FAILED with error"
        #capture error
        $wsmanError = $_
    }

    if ($Quiet -AND $Test) {
        #user asked for -Quiet and there is a test result
        $True
    }
    elseif ($Quiet) {
        #user asked for a result and if this block is reached,
        #there was no result
        $False
    }
    elseif ($wsmanError) {
        #if there is an error, write it
        write-error $wsmanError
    }
    else {
        #parse the product version line into separate properties
        [regex]$rx = "OS:\s(?<OS>\S+)\sSP:\s(?<SP>\d\.\d)\sStack:\s(?<Stack>\d\.\d)"
        $pv = $test.productVersion
        
        [string]$os = ($rx.Matches($pv)).foreach({$_.groups["OS"].value})

        #force these as strings and later treat them as [decimal]
        [string]$sp = ($rx.Matches($pv)).foreach({$_.groups["SP"].value})
        [string]$stack = ($rx.Matches($pv)).foreach({$_.groups["Stack"].value})
       
        #write custom result to the pipeline
        $test | Select-Object -property @{Name="Computername";Expression={$Computer.ToUpper()}},
        wsmid,protocolVersion,ProductVendor,
        @{Name="OS";Expression={$OS}},@{Name="SP";Expression={$SP -as [decimal]}},
        @{Name="Stack";Expression={$Stack -as [decimal]}}
    }
    #reset variables
    Clear-Variable wsmanError,Test -ErrorAction SilentlyContinue -Force
 } #foreach computern
} #process

End {
   
    Write-Verbose "Ending $($MyInvocation.Mycommand)"

} #end

} #end function Test-MyWsman

Test-MyWsman