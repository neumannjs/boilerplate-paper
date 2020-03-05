param ($source, $template, $H, $t, $o, $csl, $bibliography)

$Dir = Get-ChildItem -Path "$source".replace("\","/")
 
$List = $Dir | Where-Object {$_.extension -eq ".md"}| ForEach-Object {$_.FullName} 
$List = $([string]$List).replace("\","/")
Write-Host($List)
$Command = -join
(
"pandoc $List ",
"--template=`"$template`" ",
"-F pandoc-crossref ",
"-o `"$o`" ",
"--csl=`"$csl`" ",
"--highlight-style pygments ",
"--lua-filter=`"C:/Repositories/boilerplate-paper/style/poster-block.lua`" ",
# "--lua-filter=`"C:/Repositories/ivic-proceedings/style/metadata-replace.lua`" ",
"--bibliography=`"$bibliography`" ",
"-V fontsize=12pt ",
"-V papersize=a4paper"
)

if($H) {
  $Command = -join
  (
    "$Command ",
    "-H `"$H`""
  )
}

if($t) {
  $Command = -join
  (
    "$Command ",
    "-t `"$t`""
  )
}

Invoke-Expression $Command