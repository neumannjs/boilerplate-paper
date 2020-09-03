Pandoc commands on Linux/Ubuntu
===============================

The following commands can be used.

Compile paper in tex format

```bash
pandoc --defaults=defaults/paper.yaml --output=../output/paper-pre.tex --to=latex --bibliography=../../../Documents/library.bib paper/*.md
```

Install missing packages using texliveonfly.

```bash
texliveonfly --terminal_only --arguments='-synctex=1 -interaction=nonstopmode -output-directory=../output' ../output/paper-pre.tex
```

Compile paper in pdf

```bash
pandoc --defaults=defaults/paper.yaml --bibliography=../../../Documents/library.bib paper/*.md
```