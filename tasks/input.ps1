param ([String] $inputpath)
$a = Get-Content '.\.vscode\settings.json' -raw | ConvertFrom-Json
$a.boilerplatePaper.inputPath = $inputpath
$a | ConvertTo-Json | set-content '.\.vscode\settings.json'