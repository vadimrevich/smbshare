#requires -version 4.0


Function Get-LocalGroupMember {

<#
.SYNOPSIS
Get local group membership using ADSI.

.DESCRIPTION
This command uses ADSI to connect to a server and enumerate the members of a local group. By default it will retrieve members of the local Administrators group.

The command uses legacy protocols to connect and enumerate group memberships. You may find it use PowerShell remoting. See examples.

.PARAMETER Computername
The name of a computer to query. The parameter has aliases of 'CN' and 'Host'.

.PARAMETER Name
The name of a local group. 

.PARAMETER UseRemoting
Use PowerShell remoting to connect to the computer.

.PARAMETER Credential
An alternate credential if using PowerShell remoting.

.EXAMPLE
PS C:\> Get-LocalGroupMember -computer chi-core01 | tmo -clip

Computername : CHI-CORE01
Group        : Administrators
Name         : Administrator
ADSPath      : WinNT://GLOBOMANTICS/chi-core01/Administrator
Class        : User
Domain       : GLOBOMANTICS
IsLocal      : True

Computername : CHI-CORE01
Group        : Administrators
Name         : Domain Admins
ADSPath      : WinNT://GLOBOMANTICS/Domain Admins
Class        : Group
Domain       : GLOBOMANTICS
IsLocal      : False

Computername : CHI-CORE01
Group        : Administrators
Name         : Chicago IT
ADSPath      : WinNT://GLOBOMANTICS/Chicago IT
Class        : Group
Domain       : GLOBOMANTICS
IsLocal      : False

Computername : CHI-CORE01
Group        : Administrators
Name         : OMAA
ADSPath      : WinNT://GLOBOMANTICS/OMAA
Class        : User
Domain       : GLOBOMANTICS
IsLocal      : False

Computername : CHI-CORE01
Group        : Administrators
Name         : LocalAdmin
ADSPath      : WinNT://GLOBOMANTICS/chi-core01/LocalAdmin
Class        : User
Domain       : GLOBOMANTICS
IsLocal      : True
.EXAMPLE
PS C:\> "chi-hvr1","chi-hvr2","chi-core01","chi-fp02" | get-localgroupmember  | where {$_.IsLocal} | Select Computername,Name,ADSPath

Computername Name          ADSPath                                      
------------ ----          -------                                      
CHI-HVR1     Administrator WinNT://GLOBOMANTICS/chi-hvr1/Administrator  
CHI-HVR2     Administrator WinNT://GLOBOMANTICS/chi-hvr2/Administrator  
CHI-HVR2     Jeff          WinNT://GLOBOMANTICS/chi-hvr2/Jeff           
CHI-CORE01   Administrator WinNT://GLOBOMANTICS/chi-core01/Administrator
CHI-CORE01   LocalAdmin    WinNT://GLOBOMANTICS/chi-core01/LocalAdmin   
CHI-FP02     Administrator WinNT://GLOBOMANTICS/chi-fp02/Administrator

.EXAMPLE
PS C:\> "chi-core01","chi-hvr1","chi-hvr2","Chi-web02","chi-test02" | Get-LocalGroupMember -useremoting -credential globomantics\administrator | Where {$_.name -notmatch "Administrator|Domain Admins"} | Select Computername,ADSPath,Class

Computername ADSPath                                    Class
------------ -------                                    -----
CHI-CORE01   WinNT://GLOBOMANTICS/Chicago IT            Group
CHI-CORE01   WinNT://GLOBOMANTICS/OMAA                  User 
CHI-CORE01   WinNT://GLOBOMANTICS/chi-core01/LocalAdmin User 
CHI-HVR1     WinNT://GLOBOMANTICS/OMAA                  User 
CHI-HVR2     WinNT://GLOBOMANTICS/chi-hvr2/Jeff         User 
CHI-HVR2     WinNT://GLOBOMANTICS/OMAA                  User 
CHI-WEB02    WinNT://GLOBOMANTICS/OMAA                  User

Using PowerShell remoting and an alternate credential, find all members of the Administrators group that is not Administrator or Domain Admins.
.EXAMPLE
PS C:\> get-localgroupmember -Name "Hyper-V administrators" -Computername chi-hvr1,chi-hvr2


Computername : CHI-HVR1
Group        : Hyper-V Administrators
Name         : jeff
ADSPath      : WinNT://GLOBOMANTICS/jeff
Class        : User
Domain       : GLOBOMANTICS
IsLocal      : False

Computername : CHI-HVR2
Group        : Hyper-V Administrators
Name         : jeff
ADSPath      : WinNT://GLOBOMANTICS/jeff
Class        : User
Domain       : GLOBOMANTICS
IsLocal      : False

Check group membership for the Hyper-V Administrators group.

.EXAMPLE
PS C:\> get-localgroupmember -Computername chi-core01 | where class -eq 'group' | select Domain,Name

Domain       Name         
------       ----         
GLOBOMANTICS Domain Admins
GLOBOMANTICS Chicago IT   

Get members of the Administrators group on CHI-CORE01 that are groups and select a few properties.


.NOTES
NAME        :  Get-LocalGroupMember
VERSION     :  2.1   
LAST UPDATED:  2/18/2016
AUTHOR      :  Jeff Hicks (@JeffHicks)

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

.INPUTS
[string] for computer names

.OUTPUTS
[object]

#>


[cmdletbinding(DefaultParameterSetName = "ADSI")]

Param(
[Parameter(Position = 0)]
[Parameter(ParameterSetName = "remoting")]
[Parameter(ParameterSetName = "ADSI")]
[ValidateNotNullorEmpty()]
[string]$Name = "Administrators",

[Parameter(ValueFromPipeline,ValueFromPipelineByPropertyName)]
[Parameter(ParameterSetName = "remoting")]
[Parameter(ParameterSetName = "ADSI")]
[ValidateNotNullorEmpty()]
[Alias("CN","host")]
[string[]]$Computername = $env:computername,

[Parameter(ParameterSetName = "remoting")]
[switch]$UseRemoting,
[Parameter(ParameterSetName = "remoting")]
[Alias("RunAs")]
[System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty,
[Parameter(ParameterSetName = "remoting")]
[ValidateRange(1, 65535)]
[int]$Port,
[Parameter(ParameterSetName = "remoting")]
[switch]$UseSSL,
[Parameter(ParameterSetName = "remoting")]
[string]$CertificateThumbprint
)


Begin {
    Write-Verbose "[Starting] $($MyInvocation.Mycommand)"  
    Write-Verbose "[Begin]    Using parameter set $($PSCmdlet.ParameterSetName)"
    
    #define a scriptblock
    $do = {
    Param(
    [string]$Name = "Administrators",
    [string]$Computer=$env:computername,
    [string]$Verbose
    )
    
    $VerbosePreference = $Verbose

    #define a flag to indicate if there was an error
    $script:NotFound = $False
    
    #define a trap to handle errors because we're not using cmdlets that
    #could support Try/Catch. Traps must be in same scope.
    Trap [System.Runtime.InteropServices.COMException] {
        $errMsg = "Failed to enumerate $name on $computer. $($_.exception.message)"
        Write-Warning $errMsg

        #set a flag
        $script:NotFound = $True
    
        Continue    
    }

    #define a Trap for all other errors
    Trap {
      Write-Warning "Oops. There was some other type of error on $Computer : $($_.exception.message)"
      Continue
    }

    Write-Verbose "[Process]  Connecting to $computer"
    #the WinNT moniker is case-sensitive
    [ADSI]$group = "WinNT://$computer/$Name,group"
    Write-Verbose "[Process]  Querying members of the $Name group"
    $members = $group.invoke("Members") 

    Write-Verbose "[Process]  Counting group members"
    
    if (-Not $script:NotFound) {
        $found = ($members | measure).count
        Write-Verbose "[Process]  Found $found members"

        if ($found -gt 0 ) {
        $members | foreach {
        
            #define an ordered hashtable which will hold properties
            #for a custom object
            $Hash = [ordered]@{Computername = $computer.toUpper();Group = $Group.Name.Value}

            #Get the name property
            $hash.Add("Name",$_[0].GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null))
        
            #get ADS Path of member
            $ADSPath = $_[0].GetType().InvokeMember("ADSPath", 'GetProperty', $null, $_, $null)
            $hash.Add("ADSPath",$ADSPath)
    
            #get the member class, ie user or group
            $hash.Add("Class",$_[0].GetType().InvokeMember("Class", 'GetProperty', $null, $_, $null))  
    
            <#
            Domain members will have an ADSPath like WinNT://MYDomain/Domain Users.  
            Local accounts will be like WinNT://MYDomain/Computername/Administrator
            #>

            $hash.Add("Domain",$ADSPath.Split("/")[2])

            #if computer name is found between two /, then assume
            #the ADSPath reflects a local object
            if ($ADSPath -match "/$computer/") {
                $local = $True
                }
            else {
                $local = $False
                }
            $hash.Add("IsLocal",$local)

            #turn the hashtable into an object
            New-Object -TypeName PSObject -Property $hash
         } #foreach member
        } 
        else {
            Write-Warning "No members found in $Name on $Computer."
        }
    } #if no errors
    
    } #close Do scriptblock
    
    if ($PSCmdlet.ParameterSetName -eq "Remoting") {
        
        <#
         Use the PSBoundParameters hastable to splat to Invoke-Command
         so remove the few parameters that don't belong
        #>
        $PSBoundParameters.Remove("Name") | Out-Null
        $PSBoundParameters.Remove("UseRemoting") | Out-Null

        #and add new ones
        $PSBoundParameters.Add("Scriptblock",$do)
        $PSBoundParameters.Add("HideComputername",$True)
        

    }    
} #begin

Process {
 
 foreach ($computer in $computername) {
    if ($PSCmdlet.ParameterSetName -eq "Remoting") {
        #set values for each computer
        $PSBoundParameters.ArgumentList = @($Name,$computer,$VerbosePreference)
        $PSBoundParameters.Computername = $Computer
        
        #invoke the scriptblock in a remoting session and display everything
        #except the runspaceID
        Invoke-Command @PSBoundParameters | Select * -exclude runspaceID
    }
    else {
        #execute locally
        #scriptblock parameters are positional
        &$do $Name $computer $VerbosePreference
    }
   
} #foreach computer

} #process

End {
    Write-Verbose "[Ending]  $($MyInvocation.Mycommand)"
} #end

} #end function

<#
Copyright (c) 2016 JDH Information Technology Solutions, Inc.


Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:


The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.


THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
#>