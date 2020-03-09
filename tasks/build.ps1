param ($source, $defaults)

$Dir = Get-ChildItem -Path "$source".replace("\","/")
$defaults = $defaults.replace("\","/")
 
$List = $Dir | Where-Object {$_.extension -eq ".md"}| ForEach-Object {$_.FullName} 
$List = $([string]$List).replace("\","/")
Write-Host("pandoc $List -defaults=$defaults")

Invoke-Expression "pandoc $List --defaults=$defaults"