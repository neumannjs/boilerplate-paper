param(
    [string] $BaseFileName,
    [string[]] $Commits,
    [string] $SaveAsFileName,
    [string] $Author
)

$BaseFileNameWithoutExt = $BaseFileName.Substring(0, $BaseFileName.LastIndexOf("."))
$BaseFileNameExt = $BaseFileName.Substring($BaseFileName.LastIndexOf("."), $BaseFileName.length - $BaseFileName.LastIndexOf("."))

$OrginalFile = $BaseFileNameWithoutExt + $Commits[0] + $BaseFileNameExt
$RevisedFile = $BaseFileNameWithoutExt + $Commits[1] + $BaseFileNameExt

$ErrorActionPreference = 'Stop'

function resolve($relativePath) {
    (Resolve-Path $relativePath).Path
}

$OrginalFile = resolve $OrginalFile
$RevisedFile = resolve $RevisedFile

# Resolve the folder, because the file might not exits
$SaveAsPath = resolve $SaveAsFileName.Substring(0, $SaveAsFileName.LastIndexOf("\") + 1)

# Append the filename to the resolved folder
$SaveAsFileName = $SaveAsPath + $SaveAsFileName.Substring($SaveAsFileName.LastIndexOf("\") + 1, $SaveAsFileName.length - $SaveAsFileName.LastIndexOf("\") -1 )

# Constants
$wdDoNotSaveChanges = 0
$wdCompareTargetNew = 2

try {
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    $document = $word.Documents.Open($OrginalFile, $false, $false)
    $document.Compare($RevisedFile, [ref]$Author, [ref]$wdCompareTargetNew, [ref]$true, [ref]$true)

    $word.ActiveDocument.Saved = 1

    # Now close the documents
    $document.Close([ref]$wdDoNotSaveChanges)
    $newDocument = $word.Documents.Item(1)
    $newDocument.SaveAs2($SaveAsFileName)
    $newDocument.Close([ref]$wdDoNotSaveChanges)
} catch {
    Write-Host($_.Exception)
}