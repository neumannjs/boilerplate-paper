$Dir = get-childitem ./source
$List = $Dir | Where-Object {$_.extension -eq ".md"}| ForEach-Object {$_.FullName} 
$List = $([string]$List).replace("\","/")
$Command = -join
(
"pandoc $List ",
"--template=`"C:/Repositories/ivic-proceedings/style/template.tex`" ",
"-H `"C:/Repositories/ivic-proceedings/style/preamble.tex`" ",
"-F pandoc-crossref ",
"-o `"C:/Repositories/ivic-proceedings/output/proceedings.pdf`" ",
"--csl=`"C:/Repositories/ivic-proceedings/style/springer-lecture-notes-in-computer-science.csl`" ",
"--highlight-style pygments ",
"--lua-filter=`"C:/Repositories/ivic-proceedings/style/git-revision.lua`" ",
# "--lua-filter=`"C:/Repositories/ivic-proceedings/style/metadata-replace.lua`" ",
"--bibliography=`"C:/Users/Gijs van Dam/Documents/library.bib`" ",
"-V fontsize=12pt ",
"-V papersize=a4paper "
)
Invoke-Expression $Command