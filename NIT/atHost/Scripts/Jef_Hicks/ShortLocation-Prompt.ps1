
Function prompt {

    $location = $executionContext.SessionState.Path.CurrentLocation.path
    #what is the maximum length of the path before you begin truncating?
    $len = 33

    if ($location.length -gt $len) {

        #split on the path delimiter which might be different on non-Windows platforms
        $dsc = [system.io.path]::DirectorySeparatorChar
        #escape the separator character to treat it as a literal
        #filter out any blank entries which might happen if the path ends with the delimiter
        $split = $location -split "\$($dsc)" | Where-Object { $_ -match "\S+" }
        #reconstruct a shorted path
        $here = "{0}$dsc{1}...$dsc{2}" -f $split[0], $split[1], $split[-1]

    }
    else {
        #length is ok so use the current location
        $here = $location
    }

    "PS $here$('>' * ($nestedPromptLevel + 1)) "
    # .Link
    # https://go.microsoft.com/fwlink/?LinkID=225750
    # .ExternalHelp System.Management.Automation.dll-help.xml

}