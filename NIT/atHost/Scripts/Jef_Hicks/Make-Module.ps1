#requires -version 5.1
#requires -module PowerShellGet

<#

The function assumes you have git installed and use it for source control

This code contains hard-coded references for my environment. This file
is offered as educational and reference material. It will not run for you
without revision.
#>

Function New-ModuleBase {

    [cmdletbinding(SupportsShouldProcess)]
    Param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$ModuleName,
        [Parameter(Mandatory)]
        [ValidateNotNullorEmpty()]
        [string]$Description,
        [Parameter(HelpMessage = "Enter a list of function names you plan to write")]
        [string[]]$Functions,
        [ValidateSet("Desktop", "Core")]
        [string[]]$Compatible = @("Desktop", "Core"),
        [alias("gh")]
        [switch]$GitHub
    )

    Write-Verbose "Provisioning a new module called $ModuleName"

    $Base = "C:\Scripts"
    $Path = Join-Path -Path $Base -ChildPath $ModuleName

    if (Test-Path -Path $path) {
        Write-Warning "A module already exists at $Path"
    }
    else {
        New-Item  -Path $base -Name $ModuleName -ItemType Directory

        Write-Verbose "Creating folder structure"
        "docs", "en-us", "images", "tests", ".vscode", "functions", "formats" |
        ForEach-Object {
            New-Item -Path $path -Name $_ -ItemType Directory
        }

        Write-Verbose "Creating README.md"

        $readme = @"
# $ModuleName

$Description

This module is under development.

Last updated $(Get-Date -format u)
"@

        Set-Content -Value $readme -Path (Join-Path -Path $path -ChildPath "README.md")

        Write-Verbose "Copy my .vscode files"
        #you might have a standard settings.json or dictionary files
        Copy-Item -Path C:\scripts\tasks.json -Destination (Join-Path -path $Path -childpath .vscode) -PassThru
        Copy-Item -Path C:\scripts\.markdownlint.json -Destination (Join-Path -path $Path -childpath .vscode) -PassThru

        Write-Verbose "Creating license"

        #update your licensing info
        $lic = @"
MIT License

Copyright (c) $((Get-Date).Year) JDH Information Technology Solutions, Inc.

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
"@

        Set-Content -Value $lic -Path (Join-Path -Path $path -ChildPath "license.txt")

        Write-Verbose "Creating module files"

        #you can also set defaults using $PSDefaultParameterValues
        $psd1 = @{
            Path                 = "$path\$modulename.psd1"
            Author               = "Jeff Hicks"
            CompanyName          = "JDH Information Technology Solutions, Inc."
            CompatiblePSEditions = $Compatible
            Copyright            = "2020 JDH Information Technology Solutions, Inc."
            Description          = $description
            FunctionsToExport    = $functions
            RootModule           = "$modulename.psm1"
            ModuleVersion        = "0.0.1"
            PowerShellVersion    = "5.1"
        }

        New-ModuleManifest @psd1

        $psm1 = @"
#enable verbose messaging in the psm1 file
if (`$myinvocation.line -match "-verbose") {
    `$VerbosePreference = "continue"
}

Write-Verbose "Loading public functions"

#dot source functions
Get-ChildItem .\functions\*.ps1 |
ForEach-Object {
    Write-Verbose `$_.fullname
    . `$_.fullname
}

"@

        Set-Content -Value $psm1 -Path (Join-Path -Path $path -ChildPath "$modulename.psm1")

        if ($Functions) {
            $txt = @"
# functions for $modulename


"@

            foreach ($f in $Functions) {
                $txt += @"
#region $F

Function $f {
    [cmdletbinding()]
    Param()
    Begin {
        Write-Verbose "[BEGIN  ] Starting `$(`$myinvocation.mycommand)"
    }

    Process {
        Write-Verbose "[PROCESS] Processing"
    }

    End {
        Write-Verbose "[END    ] Ending `$(`$myinvocation.mycommand)"
    }

}

#endregion


"@
            }

            Set-Content -Value $txt -Path "$path\functions\functions.ps1"

        }

        Write-Verbose "Creating changelog.md"
        $change = @"
# Changelog for $ModuleName

## v$($psd1.moduleVersion)

+ initial file commit
"@

        Set-Content -Value $change -Path (Join-Path -Path $path -ChildPath "changelog.md")

        Write-Verbose "Inititalizing git"
        #my git configuration is already configured with global settings and excludes
        if ($pscmdlet.ShouldProcess($path, "Initialize git")) {
            git init $Path
            Set-Location $Path
            git add .
            git commit -m "Initial git commit"
        }

        if ($GitHub) {

            Write-Verbose "Creating private GitHub repo"
            #my gittoken is stored in a CMS Mesage
            $token = Unprotect-CmsMessage -path C:\scripts\gittoken.txt
            #parameters for my New-GitHubRepository function
            $new = @{
                Name        = $ModuleName
                Description = $Description
                Private     = $True
                NoWiki      = $True
                UserToken   = $token
            }
            $repo = New-GitHubRepository @new

            Write-Verbose "Updating the module manifest"
            $up = @{
                Path       = "$path\$modulename.psd1"
                ProjectURI = $repo.URL
                LicenseURI = "$($repo.URL)/blob/master/license.txt"
            }
            Update-ModuleManifest @up
            git add .
            git commit -m "manifest update"

            if ($pscmdlet.ShouldProcess($repo.url, "Adding remote repo")) {
                git remote add origin $repo.clone
                git push -u origin master
            }
        }

        #open the project in VSCode
        # code $path

    } #else path is ok

}

Function New-GitHubRepository {
    <#
.Synopsis
Create a GitHub repository
.Description
This command will create a GitHub repository online. The command assumes you have a Github account.
#>

    [cmdletbinding(SupportsShouldProcess)]

    Param(
        [Parameter(Position = 0, Mandatory, HelpMessage = "Enter the new repository name")]
        [ValidateNotNullorEmpty()]
        # The name for the new repository.
        [string]$Name,
        # Add a repository description
        [string]$Description,
        #Make the repository private
        [switch]$Private,
        #Turn off the repository Wiki
        [switch]$NoWiki,
        #Turn off Issues
        [switch]$NoIssues,
        #Disallow downloads
        [switch]$NoDownloads,
        #auto setup with a README file
        [switch]$AutoInitialize,

        #license templates found at https://github.com/github/choosealicense.com/tree/gh-pages/_licenses
        [ValidateSet("MIT", "apache-2.0", "gpl-3.0", "ms-pl", "unlicense")]
        #specify what type of license to use
        [string]$LicenseTemplate,

        [Alias("token")]
        [ValidateNotNullorEmpty()]
        #Specify your user token
        [string]$UserToken = $gitToken,

        #write full native response to the pipeline
        [switch]$Raw
    )

    Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"
    #display PSBoundparameters formatted nicely for Verbose output
    [string]$pb = ($PSBoundParameters | Format-Table -AutoSize | Out-String).TrimEnd()
    Write-Verbose "[BEGIN  ] PSBoundparameters: `n$($pb.split("`n").Foreach({"$("`t"*2)$_"}) | Out-String) `n"

    #create the header
    $head = @{
        Accept        = 'application/vnd.github.v3+json'
        Authorization = "token $UserToken"
    }

    #create a hashtable from properties
    $hash = @{
        name          = $Name
        description   = $Description
        private       = $Private -as [boolean]
        has_wiki      = (-Not $NoWiki)
        has_issues    = (-Not $NoIssues)
        has_downloads = (-Not $NoDownloads)
        auto_init     = $AutoInitialize -as [boolean]
    }

    if ($LicenseTemplate) {
        $hash.add("license_template", $LicenseTemplate)
    }

    $body = $hash | ConvertTo-Json

    Write-Verbose "[PROCESS] Sending json"
    Write-Verbose $body

    #define parameter hashtable for Invoke-RestMethod
    $paramHash = @{
        Uri              = "https://api.github.com/user/repos"
        Method           = "Post"
        body             = $body
        ContentType      = "application/json"
        Headers          = $head
        UseBasicParsing  = $True
        DisableKeepAlive = $True
    }

    #should process
    if ($PSCmdlet.ShouldProcess("$name [$description]")) {
        $r = Invoke-RestMethod @paramHash

        if ($r.id -AND $Raw) {
            Write-Verbose "[PROCESS] Raw result"
            $r

        }
        elseif ($r.id) {
            Write-Verbose "[PROCESS] Formatted results"

            $r | Select-Object @{Name = "Name"; Expression = { $_.name } },
            @{Name = "Description"; Expression = { $_.description } },
            @{Name = "Private"; Expression = { $_.private } },
            @{Name = "Issues"; Expression = { $_.has_issues } },
            @{Name = "Wiki"; Expression = { $_.has_wiki } },
            @{Name = "URL"; Expression = { $_.html_url } },
            @{Name = "Clone"; Expression = { $_.clone_url } }
        }
        else {

            Write-Warning "Something went wrong with this process"
        }

        if ($r.clone_url) {
            $msg = @"

To push an existing local repository to Github run these commands:
-> git remote add origin $($r.clone_url)"
-> git push -u origin master

"@
            Write-Host $msg -ForegroundColor Green

        }
    }

    Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"

}
