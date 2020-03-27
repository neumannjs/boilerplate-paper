Boilerplate Paper
=================

Boilerplate Paper is a tool for creating scientific papers, posters and slideshows in Markdown and convert them to different formats like Pdf, Word, Powerpoint or Html. Converting your Markdown files to PDF, slideshows or something else, is done using Pandoc. Pandoc is open-source software created to convert documents from one format to another. Apart from Pandoc, there is more software required to be installed on your computer to make everything work. Getting all this software to work can be a bit overwhelming if you are new to this. That's why Boilerplate Paper comes with three Github Actions preconfigured. These Github Actions are automated workflows that convert your Markdown files into your final document using the Github servers. That way you can dip your toe in the water to see if writing papers like this works for you. If it does (and I think it will), you can install the required software on your local computer and experience the benefits of all the features Boilerplate Paper offers.

Boilerplate Paper is meant to be used with Git and Github. If you create the habit of committing your changes often, using Git, you can track the changes to your work at a very granular level. On top of that you can create a Word document with Track Changes that shows what has changed between any two states of your paper. This is particularly useful when discussing your paper with collaborators or supervisors.

**Caveat**: Currently Boilerplate Paper is in alpha-release and only supports Windows.

Main Features
-------------

- Convert your Markdown paper to Word, Pdf or LaTeX
- Convert your Markdown poster to Pdf using LaTeX Beamer poster document class
- Convert your Markdown slides to Powerpoint, Pdf or Reveal.js
- Publish your slideshows online with Github Pages
- Create a Word document with Track Changes between any two Git commits

Useful filters
--------------

The functionality of Pandoc can be extended with filters. Filters are small programs that modify your document during the process of converting from input (Markdown) to output (Pdf, LaTeX, Powerpoint, etc.). Boilerplate Paper comes preconfigured with useful filters that can easily be turned on and off.

- abstract-to-meta: Enables you to write the abstract in a Markdown file, instead of in a field in the document metadata. The latter can be quite cumbersome.
- metadata-replace: Use variables defined in the document metadata throughout your document. Now you can change those variables in a central place to update them everywhere in you document.
- git-revision: Git assigns a hash to each commit. A hash is an alphanumeric value unique to that commit. The full version is 40 characters long, but Git figures out unique abbreviation of 7 characters (or longer if needed). The git-revision filter makes it possible to print out the abbreviated version in your output document. That way you can always track back to the exact version of a document that was distributed, e.g. through print-out or as an attachment.
- tikz: TikZ is a complex but very powerful tool to create graphics in LaTeX. This filter converts LaTeX TikZ graphics in your document into separate images. The filter is aware of the output format and converts the image to a format that is supported by the output format. For example, it converts the images to Png if the output format is a Word document, but it converts it to Svg if the output format is Html. This way you can use Tikz images also in output formats that do not support Tikz natively. Converted images are cached and reused in future builds if the images remain unchanged. This can speed up a build considerably.

Best practices
--------------

Boilerplate Paper comes with a few recommendations for Visual Studio Code Extensions for the optimal experience.

- Todo Tree, to keep track of your todo's that you can put as notes anywhere in your document, or in a separate file.
- Live Sever, to show your Html slideshows locally in your browser.
- Paste Image, to paste images from your clipboard directly into your Markdown document
