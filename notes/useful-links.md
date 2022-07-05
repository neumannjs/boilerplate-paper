Useful links
============

The links below where the posts that set me on the track of using Markdown, Pandoc and Latex for my research papers:

https://sylvaindeville.net/2015/07/17/writing-academic-papers-in-plain-text-with-markdown-and-jupyter-notebook/
https://sylvaindeville.net/2015/01/04/the-automated-academic/
https://github.com/tompollard/phd_thesis_markdown/

Below is an interesting article on pre-publishing tables and graphics under a CC-BY, to facilitate re-use of your graphics and tables/data.

https://medium.com/@malte.elson/retaining-copyright-for-figures-in-academic-publications-to-allow-easy-citation-and-reuse-77c6e2b511fe

## Interesting Lua filters (that are not included by default in Boilerplate Paper)

- [author-info-blocks](https://github.com/pandoc/lua-filters/tree/master/author-info-blocks)
  This filter adds author-related header blocks usually included in scholarly articles, such as a list of author affiliations, correspondence information, and on notes equal contributors
- [scholarly-metadata](https://github.com/pandoc/lua-filters/tree/master/scholarly-metadata)
  The filter turns metadata entries for authors and their affiliations into a canonical form. This allows users to conveniently declare document authors and their affiliations. Use this filter in combination with author-info-blocks.
- [not-in-format](https://github.com/pandoc/lua-filters/tree/master/not-in-format)
  Keeps parts of a document out of selected output formats.
- [revealjs-codeblock](https://github.com/pandoc/lua-filters/tree/master/revealjs-codeblock)
  This filter overwrites the code block HTML for revealjs output to enable the code presenting features of reveal.js.
- [short-captions](https://github.com/pandoc/lua-filters/tree/master/short-captions)
  For latex output, this filter uses the attribute short-caption for figures so that the attribute value appears in the List of Figures, if one is desired.
- [table-short-captions](https://github.com/pandoc/lua-filters/tree/master/table-short-captions)
  For LaTeX output, this filter enables use of the attribute short-caption for tables. The attribute value will appear in the List of Tables.

## How to create a custom Pandoc Beamer template

<https://github.com/alexeygumirov/pandoc-beamer-how-to>