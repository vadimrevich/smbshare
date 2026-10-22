#####
# Copy-FilesWithVersioning
#####

# The provided PowerShell script copies a file 
# from a source location to a destination, 
# ensuring that no existing files are overwritten 
# by automatically generating a unique filename 
# if necessary.

# It takes two mandatory parameters:

# $path: the path to the source file.
# $destination: the target location, 
# which can be either a directory or a specific 
# file path.
# If the source file does not exist, the script 
# throws an error. If the destination is a directory, 
# the script preserves the original filename; 
# otherwise, it uses the specified destination 
# filename.

# Before copying, the script checks whether 
# a file with the same name already exists 
# at the destination. If it does, 
# the FindUniqueFileName function appends 
# an incrementing number in parentheses 
# (e.g., "file (1).txt") until a unique name is found.

# Finally, the file is copied using Copy-Item 
# with the -Force flag, allowing overwrites 
# only when directed to do so by the unique 
# filename resolution — although in practice, 
# due to the uniqueness check, no overwrite occurs.

# In summary: This script safely copies a single file 
# to a destination with automatic versioning 
# to prevent overwriting.

param(
    [Parameter(mandatory=$true)] $path,
    [Parameter(mandatory=$true)] $destination
)

Function FindUniqueFileName($fileName) {
    $result = $fileName
    $i = 0
    While (Test-Path $result -PathType Leaf) {
        $i += 1
        $parentPath = Split-Path $fileName -Parent
        $fileNameBase = Split-Path $fileName -LeafBase
        $extension = Split-Path $fileName -Extension
        $establishedFileName = $fileNameBase + " ($i)" + $extension
        $result = Join-Path $parentPath $establishedFileName
    }
    return $result
}

If (!(Test-Path $path -PathType Leaf)) {
    throw "Source file $path does not exist"
}

$destinationFileName = (Test-Path $destination -PathType Container) `
    ? (Join-Path $destination (Split-Path $path -Leaf))
    : $destination

$uniqueFileName = FindUniqueFileName $destinationFileName

Copy-Item -Path $path -Destination $uniqueFileName -Force
