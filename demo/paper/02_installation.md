Installation  {#sec:installation}
============

To edit and build your paper on your own computer, you need to install software. This explanation assumes you already have installed VSCode and Git. Explaining how to do that is outside the scope of this document.

## Windows

Perform the following steps on Windows

## Install packages with Chocolatey

If you use the Windows package manager Chocolatey, you can install the required packaged by using the following command.

**NOTE: The Chocolatey Miktex package seem to be broken. The installation of Miktex appears to be successful but the package is in fact not installed. Install Miktex manually to circumvent this problem.**

```powershell
choco install miktex pandoc pdf2svg imagemagick ghostscript
```

Since there is no package for Pandoc-citeproc you will have to install that manually (see below).

## Install manually

Alternatively, you can install the required software manually.

- [GhostScript](https://www.ghostscript.com/download/gsdnld.html)
- [ImageMagick](https://imagemagick.org/script/download.php#windows)
- [Miktex](https://miktex.org/download) (See the information below on installing Miktex about what options to choose during install)
- [Pandoc](https://pandoc.org/installing.html)
- [Pandoc-citeproc](https://github.com/lierdakil/pandoc-crossref/releases/) (see the information below)
- [Pdf2Svg](https://github.com/jalios/pdf2svg-windows)

### Miktex

Download and install Miktex from <https://miktex.org/download>

When presented with the option *Install missing packages* select *Yes*.

![Install missing packages](paper/images/install-missing-packages.png)

### Pandoc-citeproc

Download the [latest release](https://github.com/lierdakil/pandoc-crossref/releases/) of Pandoc-citeproc.

It is a zip-file containing the executable `pandoc-citeproc.exe`.
Unzip this file into the installation folder of Pandoc. This folder should be located here:

```
C:\Users\[username]\AppData\Local\Pandoc
```

### Clone your Boilerplate-paper fork

Clone your fork with git to create a local copy on your own computer.

The `recurse-submodules` option is needed because Boilerplate paper uses one submodule: reveal.js. Reveal.js is an open source HTML presentation framework and a great alternative for PowerPoint or Keynote.

```
git clone --recurse-submodules https://github.com/[username]/boilerplate-paper.git
```

### Restart system

At this point you should restart your computer.

### Settings.json

Open the folder containing your forked boilerplate-paper repository, using VSCode. Locate the file `settings.json` in the folder `.vscode`.
Open this file and locate the following settings:

```json
"boilerplatePaper":  {
    "inputPath":  "demo",
    "bibliography":  "C:/Users/Gijs/Documents/library.bib"
}
```

The inputPath should point to the folder containing your paper (probably "paper") but for now leave it at "demo".

Change the setting for "bibliography" to make it point to your Bibtex file containing your references.

### Test your installation

To test if everything works, execute the *Paper to PDF* task in VSCode.
![Run Task](paper/images/run-task.png)
![Paper to PDF](paper/images/paper-to-pdf.png)

The first run might take a minute or two because of all the packages Miktex needs to install. Subsequent runs should be considerably faster.
The result should be the file `paper.pdf` in the `output` folder that contains the manual for using Boilerplate Paper.

### Demo folder

The demo folder is not essential for Boilerplate Paper to function. However, it does contain examples on how to use all aspects of Boilerplate Paper. It is recommended to keep the folder as is, so it can be used as a reference.

After you have verified your installation, it is time to change the inputPath setting. You can do this directly in the `settings.json` file or use the VSCode task `Set input path` for it.

![Input Path](paper/images/input-path.png)

Change the input path to `project`.

Boilerplate Paper comes with a `project` folder that is a good starting point for a new paper. You can rename that folder to everything you like. You can also have multiple folders like that in the same repository, if you want to keep all your papers inside a single repository. Just remember to always set the input path to the name of the folder containing the paper you are working on.

### Extensions

Boilerplate paper comes with a number of suggestions for extensions in VSCode.

- *Paste Image*: An extension to paste an image from the clipboard directly into markdown. The settings.json file contains the settings that make this extension work nicely with Boilerplate Paper. The extension has the default shortcut `Ctrl+Alt+V`.
- *Live Server*: An extension to launch a local development server. Extremely convenient to use when presenting using reveal.js from your local computer. If you do not use reveal.js or always publish your reveal.js presentations, Live Server is not needed. The settings.json file contains the settings to make Live Server work with reveal.js and Boilerplate Paper.
- *Todo Tree*: It is very useful to keep track of your todo's while writing a paper. This extension helps you keep track of all todo's in a single place, but you can create todo's anywhere in your document. Just start a new line with `TODO:` anywhere in a markdown file and write a description of your todo. Very convenient for keeping track of todo's in the running text of your paper. It is good practice to keep your todo's that don not have their place in the running text of your paper in a separate file in the `notes` folder.
- *Pandoc Citer*: This extension provides autocompletion of citations stored in a bibtex file. In the `settings.json` file edit the `PandocCiter.DefaultBib` setting so that it points to your Bibtex file. You should probably have it point to the same file as the `boilerplatePaper.bibliography` setting points to.
- *Table Formatter*: This extension auto-formats and aligns tables in markdown. This extension is a time saver because it allows you to write sloppy (but syntactically correct) tables in markdown. The extension then formats the table, making it very clear and readable in your markdown document.

### VSCode tasks



