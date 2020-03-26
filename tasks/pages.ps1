git checkout gh-pages
Copy-Item -Force output/images .
Copy-Item -Force output/slides.html index.html
((Get-Content -path index.html -Raw) -replace '"../reveal.js','"reveal.js') | Set-Content -Path index.html
((Get-Content -path index.html -Raw) -replace '"../output/images','"images') | Set-Content -Path index.html
git add images/**
git add index.html
git commit -m "New slides"
git push origin gh-pages
git checkout master