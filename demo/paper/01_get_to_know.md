Get to know Boilerplate Paper
=============================

%revision%

If you know Git and Github, and just want to start using Boilerplate Paper on your local computer, you can skip this part an go ahead to [@sec:installation].

If you want to get to know Boilerplate Paper before you invest the time to get everything up and running on your local computer, you can use the directions below.

First fork the Boilerplate Paper by visiting the [repository on Github](https://github.com/gijswijs/boilerplate-paper). Click on the Fork-button. Github will now copy the repository to your own Github account, allowing you to freely experiment with Boilerplate Paper. 

![Fork button in the top right of the screen](paper/images/fork-repository.png){ width=250px }

Forking should only take a few seconds, after which you see the copy of the repository in your own Github account. The url should read https://github.com/[your username]/boilerplate-paper.

![Forking should not take long](paper/images/fork-in-action.png){ width=350px }

Now you have to enable the Github Actions for your own repository. Github Actions are automatic workflows that jump into action once something changes in the repository. By default Github disables them from running on your fork. Go the the Actions tab and click on *I understand my workflows, go ahead and run them*

![Enable workflows](paper/images/enable-workflows.png){ width=350px }

The next thing you have to do is supply a link to your Bibtex file. If you use a reference manager like Mendeley, Zotero or Endnote, you can easily export your references to the Bibtex format. If you store this exported file using a file hosting service like Dropbox, you can easily create a accessible link to you Bibtex file. For this demo it's not needed to use you own link yet; you can use the link supplied by Boilerplate Paper: https://www.dropbox.com/s/7mwh7oi3q8mxmeo/latex.bib?raw=1
Either way, you have to tell your repository about this link. Go to the Settings tab, Secrets and click on *Add a new secret*.

![The settings tab, secrets](paper/images/secrets.png){ width=350px }

The Name of the secret should be BIBTEX_LINK and the value should be the url to the Bibtex file.

![BIBTEX_LINK secret](paper/images/bibtex-link-secret.png){ width=350px }

Now that you have enabled the workflows and told your repository where to find your bibtex file, it's time to start making some changes. Go back to the Code tab and go to the file demo / paper / _metadata.md and click on the edit icon.

![Edit this file](paper/images/edit-this-file.png){ width=250px }

This file contains the metadata of the document. It's uses the [YAML](https://yaml.org/) format for storing this metadata, but for now that isn't really important. Let's change the title to anything you want.

![Change the title](paper/images/edit-title.png){ width=350px }

Now we have to commit this change. With Git it is a good habit to commit your changes often. Every commit is a snapshot of the current state of your repository. You can always revert back to an older commit. Every commit has a commit message describing the changes in the commit. You should make a habit of writing clear and concise commit messages. For now it suffices to only give it a proper title. Click on *Commit Changes*.

![Commit new title](paper/images/Commit-new-title.png){ width=350px }

After you have committed your change, Github detects the change and starts running the Github Action for building your paper. If you click on the Actions tab, you should see the action running or just having finished.

![Github is done building your paper](paper/images/github-action-finished.png){ width=350px }

If you click on the finished workflow you see the artifact with the result of the workflow. It is called *output* and if you click on it, it will download a zip file containing the Pdf of your paper.

![The artifact containing the output with your paper](paper/images/Artifacts.png){ width=350px }

If everything went according to plan you should have a beautiful typesetted paper with the new title.

![The Pdf with the new title](paper/images/The-Pdf-with-the-new-title.png){ width=350px }
