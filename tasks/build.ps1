param ([String] $source, [String] $defaults, [String] $referencedoc, [String] $to, [String] $output, [String[]] $commits, [String] $bibliography)

function build($source, $defaults, $referencedoc, $to, $output, $bibliography) {
  $defaults = $defaults.replace("\", "/")
 
  $List = Get-ChildItem -Path $source.replace("\", "/")*.md  -Recurse |  ForEach-Object { "'" + $_.FullName + "'" } | Sort-Object
  $List = $([string]$List).replace("\", "/")

  $Command = "pandoc $List --defaults=$defaults --bibliography='$bibliography'"

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
    build $source $defaults $referencedoc $to $outputWithCommit $bibliography
    Invoke-Expression "git checkout -"
  }
} else {
  build $source $defaults $referencedoc $to $output $bibliography
}