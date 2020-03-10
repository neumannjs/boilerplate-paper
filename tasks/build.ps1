param ($source, $defaults, $referencedoc, $to, $output)

$Dir = Get-ChildItem -Path "$source".replace("\","/")
$defaults = $defaults.replace("\","/")
 
$List = $Dir | Where-Object {$_.extension -eq ".md"}| ForEach-Object {$_.FullName} 
$List = $([string]$List).replace("\","/")

$Command = "pandoc $List --defaults=$defaults"

if($referencedoc){
  $referencedoc =$referencedoc.replace("\","/")
  $Command = "$Command --reference-doc=$referencedoc"
}

if($to){
  $to =$to.replace("\","/")
  $Command = "$Command --to=$to"
}

if($output){
  $output =$output.replace("\","/")
  $Command = "$Command --output=$output"
}

Write-Host($Command)

Invoke-Expression $Command