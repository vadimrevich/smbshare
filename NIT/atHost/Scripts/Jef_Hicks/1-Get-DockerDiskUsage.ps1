#requires -version 5.1

Function Get-DockerDiskUsage {
    [cmdletbinding()]
    [alias("gddu")]
    [OutputType("Get-DockerDiskUsage.DockerDiskUsage")]
    Param(
        [Parameter(Position = 0, HelpMessage = "Get specific usage types. The default is All")]
        [ValidateSet("Images","Containers","Volumes","Cache")]
        [string[]]$Type
    )

    Begin {
        Write-Verbose "[BEGIN  ] Starting: $($MyInvocation.Mycommand)"

        #define a class
        Class DockerDiskUsage {
            [string]$Type
            [int]$Total
            [int]$Active
            [double]$Size
            [double]$Reclaim
            [int]$ReclaimPercent
            #these properties are hidden but they can be used in format.ps1xml files or Select-Object expressions
            hidden [string]$SizeUnit
            hidden [string]$ReclaimUnit

            #methods are hidden because they are only used internally
            hidden [string] GetUnit($value) {
                Write-Verbose "[CLASS] Getting unit string from $value"
                [regex]$unitrx = "[KMGT]?B"
                $r = $unitrx.match($value).value
                write-Verbose "[CLASS] Returning $r"
                return $r
            }

            hidden [double] GetValue($value) {
                Write-Verbose "[CLASS] Getting numeric value from $value"
                [regex]$szrx = "\d+(\.\d+)?"
                $r = $szrx.match($value).value
                Write-Verbose "[CLASS] Returning $r"
                return $r
            }

            hidden [int] GetUnitValue([string]$SizeUnit) {
                Write-Verbose "[CLASS] Getting unit value from $SizeUnit"
                $unit = Switch ($sizeUnit) {
                    "TB" {  1TB; break}
                    "GB" { 1GB; break}
                    "MB" { 1MB; break}
                    "KB" { 1KB; break}
                    default { 1}
                }
                Write-Verbose "[CLASS] Returning $unit"
                return $unit
            }
            #the constructor
            DockerDiskUsage ($Item) {
                Write-Verbose "[CLASS] Invoking constructor for $($item.type)"
                $this.Type = $item.Type
                $this.Total = $item.totalCount
                $this.Active = $item.active
                $this.SizeUnit = $this.getunit($item.size)
                $this.reclaimUnit = $this.GetUnit($item.reclaimable)
                $this.Size = $this.getValue($item.size) * $this.GetUnitValue($this.SizeUnit)
                $this.Reclaim = $this.GetValue($item.reclaimable.split()[0]) * $this.GetUnitValue($this.ReclaimUnit)
                $this.ReclaimPercent = $this.GetValue($item.reclaimable.split()[1])
            }
        } #close class definition

    } #begin
    Process {
        Write-Verbose "[PROCESS] Getting Docker Disk Usage"
        $data = docker system df --format "{{json .}}" | ConvertFrom-Json

        if ($data) {
            foreach ($item in $data) {
                $item | Out-String | Write-Verbose
                #filter on type if specified via the Type parameter
                if ( (-not $Type) -OR ( $item.type -match $($type -join "|"))){
                    New-Object -TypeName DockerDiskUsage -ArgumentList $item
                }
            } #foreach item
        }
        else {
            Write-Warning "Failed to get any Docker disk usage data"
        }
    } #process
    End {
        Write-Verbose "[END    ] Ending: $($MyInvocation.Mycommand)"
    } #end
}

$format = "C:\scripts\dockerusage.format.ps1xml"
if (Test-Path -path $format) {
    Update-FormatData $format
}