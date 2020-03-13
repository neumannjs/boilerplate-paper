param ([String] $source, [String] $defaults, [String] $referencedoc, [String] $to, [String] $output, [String[]] $commits)

function build($source, $defaults, $referencedoc, $to, $output) {
  $Dir = Get-ChildItem -Path $source.replace("\", "/") | Sort-Object
  $defaults = $defaults.replace("\", "/")
 
  $List = $Dir | Where-Object { $_.extension -eq ".md" } | ForEach-Object { $_.FullName } 
  $List = $([string]$List).replace("\", "/")

  $Command = "pandoc $List --defaults=$defaults"

  if ($referencedoc) {
    $referencedoc = $referencedoc.replace("\", "/")
    $Command = "$Command --reference-doc=$referencedoc"
  }

  if ($to) {
    $to = $to.replace("\", "/")
    $Command = "$Command --to=$to"
  }

  if ($output) {
    $output = $output.replace("\", "/")
    $Command = "$Command --output=$output"
  }

  Write-Host($Command)

  Invoke-Expression $Command

}

if($commits){
  foreach ($commit in $commits){
    Write-Host $commit
    $OutputWithoutExt = $output.Substring(0, $output.LastIndexOf("."))
    $OutputExt = $output.Substring($output.LastIndexOf("."), $output.length - $output.LastIndexOf("."))
    $outputWithCommit = $OutputWithoutExt + $commit + $OutputExt
    Write-Host $output
    Invoke-Expression "git checkout $commit"
    build $source $defaults $referencedoc $to $outputWithCommit
    Invoke-Expression "git checkout -"
  }
} else {
  build $source $defaults $referencedoc $to $output
}