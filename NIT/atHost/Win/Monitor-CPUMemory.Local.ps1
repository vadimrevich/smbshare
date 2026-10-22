$counters = @(
    '\Processor(_Total)\% Processor Time',
    '\Memory\Available MBytes',
    '\LogicalDisk(_Total)\% Free Space'
)
Get-Counter -Counter $counters
