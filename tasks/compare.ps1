param(
    [string] $BaseFileName,
    [string] $ChangedFileName,
    [string] $SaveAsFileName,
    [string] $Author
)

$ErrorActionPreference = 'Stop'

function resolve($relativePath) {
    (Resolve-Path $relativePath).Path
}

$BaseFileName = resolve $BaseFileName
$ChangedFileName = resolve $ChangedFileName

# Resolve the folder, because the file might not exits
$SaveAsPath = resolve $SaveAsFileName.Substring(0, $SaveAsFileName.LastIndexOf("\") + 1)

# Append the filename to the resolved folder
$SaveAsFileName = $SaveAsPath + $SaveAsFileName.Substring($SaveAsFileName.LastIndexOf("\") + 1, $SaveAsFileName.length - $SaveAsFileName.LastIndexOf("\") -1 )

# Remove the readonly attribute because Word is unable to compare readonly
# files:
$baseFile = Get-ChildItem $BaseFileName
if ($baseFile.IsReadOnly) {
    $baseFile.IsReadOnly = $false
}

# Constants
$wdDoNotSaveChanges = 0
$wdCompareTargetNew = 2

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $document = $word.Documents.Open($BaseFileName, $false, $false)
    $document.Compare($ChangedFileName, [ref]$Author, [ref]$wdCompareTargetNew, [ref]$true, [ref]$true)

    $word.ActiveDocument.Saved = 1

    # Now close the documents
    $document.Close([ref]$wdDoNotSaveChanges)
    $newDocument = $word.Documents.Item(1)
    $newDocument.SaveAs2($SaveAsFileName)
    $newDocument.Close([ref]$wdDoNotSaveChanges)
} catch {
    Write-Host($_.Exception)
}