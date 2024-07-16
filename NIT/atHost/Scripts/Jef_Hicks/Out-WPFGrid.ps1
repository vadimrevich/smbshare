#requires -version 5.0

# ToDo: Add option to use last position for Top and Left properties of the form or provide that as an option
# ToDo: Add statusbar for timer countdown and other information

Function Out-WPFGrid {

<#
.Synopsis
Send command output to an interactive WPF-based grid.

.Description
This command is an alternative to Out-Gridview. It works much the same way. Run a PowerShell command and pipe it to this command. The output will be displayed in a data grid. You can click on column headings to sort. You can resize columns and you can re-order columns.

Technically, this command should probably be called Convertto-WPFGrid because it will display all properties of the incoming object. You will want to be selective about which properties you pipe through to this command. See examples.

Unlike Out-Gridview, your PowerShell prompt will be blocked until the WPF-based grid is closed.

.Parameter Title
Specify a title for your form.

.Parameter Timeout
By default the grid will remain displayed until you manually close it. But you can specify a timeout interval in seconds. The minimum accepted value is 5 seconds. Because the timer ticks in 5 second intervals it is recommended that your time out value also be a multiple of 5.

.Parameter CenterScreen
Windows will display the form in the center of your screen.

.Parameter Width
Specify a width in pixels for your form.

.Parameter Height
Specify a height in pixels for your form.

.Example
PS C:\ Get-Service -computername Server1 | Select Name,Status,Displayname,StartType,Machinename | Out-WPFGrid -centerscreen

Get all services from Server1 and display selected properties in a grid which will be centered on the screen.

.Example
PS C:\> $vmhost = "CHI-HVR2"
PS C:\> Get-VM -computername $VMHost | 
Select Name,State,Uptime,
@{Name="AssignedMB";Expression={$_.MemoryAssigned/1mb -as [int]}},
@{Name="DemandMB";Expression={$_.MemoryDemand/1mb -as [int]}} |
Out-WPFGrid -title "VM Report $VMHost" -Width 500 -height 200 -timeout 20

Get Hyper-V virtual machine information and display in a resized grid for 20 seconds.

.Notes
Last Updated: 5 September 2018
Version     : 1.0

Learn more about PowerShell:
http://jdhitsolutions.com/blog/essential-powershell-resources/

 
.Link
Out-GridView

.Inputs
[PSObject]


#>
    [cmdletbinding()]
    [Alias("owg")]
    [outputtype("none")]

    Param(
        [Parameter(ValueFromPipeline)]
        [psobject]$InputObject,
        [string]$Title = "Out-WPFGrid",
        [ValidateScript({$_ -ge 5})]
        [int]$Timeout,
        [int]$Width = 1024,
        [int]$Height = 768,
        [switch]$CenterScreen
    )

    Begin {

        Write-Verbose "Starting $($MyInvocation.MyCommand)"

        # ! It may not be necessary to add these types but it doesn't hurt to include them
        Add-Type -AssemblyName PresentationFramework
        Add-Type –assemblyName PresentationCore
        Add-Type –assemblyName WindowsBase
        
        # define a timer to automatically dismiss the form. The timer uses a 5 second interval tick
        if ($Timeout -gt 0) {
            Write-Verbose "Creating a timer"
            $timer = new-object System.Windows.Threading.DispatcherTimer
            $terminate = (Get-Date).AddSeconds($timeout)
            Write-verbose "Form will close at $terminate"
            $timer.Interval = [TimeSpan]"0:0:5.00"
            
            $timer.add_tick( {
                if ((Get-Date) -ge $terminate) {
                        $timer.stop()
                        $form.Close()
                    }
                })
        }
        
        Write-Verbose "Defining form: $Title ($width x $height)"
        
        $form = New-Object System.Windows.Window
        #define what it looks like
        $form.Title = $Title
        $form.Height = $Height
        $form.Width = $Width
        
        if ($CenterScreen) {
            Write-Verbose "Form will be center screen"
            $form.WindowStartupLocation = [System.Windows.WindowStartupLocation]::CenterScreen
        }
        #define a handler when the form is loaded. The scriptblock uses variables defined later
        #in the script
        $form.add_Loaded( {                
                foreach ($col in $datagrid.Columns) {
                    #because of the way I am loading data into the grid
                    #it appears I need to set the sorting on each column
                    $col.CanUserSort = $True
                    $col.SortMemberPath = $col.Header
                }
                $datagrid.Items.Refresh()
                $form.focus
            })
        #Create a stack panel to hold the datagrid
        $stack = New-object System.Windows.Controls.StackPanel

        #create a datagrid
        $datagrid = New-Object System.Windows.Controls.DataGrid
        
        $datagrid.VerticalAlignment = "Bottom"
        #adjust the size of the grid based on the form dimensions
        $datagrid.Height = $form.Height - 50
        $datagrid.Width = $form.Width - 50
        $datagrid.CanUserSortColumns = $True
        $datagrid.CanUserResizeColumns = $True
        $datagrid.CanUserReorderColumns = $True
        $datagrid.AutoGenerateColumns = $True
        #enable alternating color rows
        $datagrid.AlternatingRowBackground = "gainsboro"
        
        $stack.AddChild($datagrid)
        $form.AddChild($stack)

        #initialize an array to hold all processed objects
        $data = @()
    } #begin

    Process {
        #add each incoming object to the data array
        $data += $Inputobject 
    } #process

    End {
        Write-Verbose "Preparing form"
        $DataGrid.ItemsSource = $data

        #show the form
        If ($Timeout -gt 0) {
            Write-Verbose "Starting timer"
            $timer.IsEnabled = $True
            $Timer.Start()
        }

        Write-Verbose "Displaying form"
        $form.ShowDialog() | Out-Null

        write-verbose "Ending $($MyInvocation.MyCommand)"

    } #end

} #close function