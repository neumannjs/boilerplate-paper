Prerequisites
=============

- Pandoc
- Miktex (or another Latex distribution)
- Word (optional)
- pdf2svg
- Visual Studio Code
- ImageMagick
- Ghostscript

ImageMagick and Ghostscript are used for converting pdfs to pngs. You could use Ghostscript directly, without ImageMagick (see: https://stackoverflow.com/a/36137513) but the path of ImageMagick is added to the path environment variable, and ImageMagick finds Ghostscript automatically, so that makes the lua script work better on a variety of machines.
