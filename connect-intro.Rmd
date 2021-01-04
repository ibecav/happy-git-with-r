# Connecting -- Can you hear me now? {#connect-intro}

Next we'll walk through some basic operations to confirm you have
installed the necessary software and that the necessary connections are being
made, between tools on your computer and between your computer and GitHub.

We use Git in the shell to make sure you can clone a repo
from GitHub and establish two-way communications.

We confirm that RStudio can work with your Git installation to perform local
operations and communicate with GitHub.

We present two approaches for persistently authenticating yourself with GitHub,
so you don't need to provide credentials *ad nauseam*.

Hopefully you won't need it, but this part concludes with two troubleshooting
chapters: [Detect Git from RStudio] and [RStudio, Git, GitHub Hell].

## Connect to GitHub {#push-pull-github}

Objective: make sure that you can pull from and push to GitHub from your
computer.

I do not explain all the shell (Appendix \@ref(shell)) and Git commands in
detail. This is a black box diagnostic / configuration exercise. In later
chapters, we revisit these operations with much more narrative.

### Make a repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click green "New repository" button. Or, if you are on your own profile page,
click on "Repositories", then click the green "New" button.

How to fill this in:

  * Repository name: `myrepo` (or whatever you wish, we'll delete this soon
    anyway).
  * Description: "testing my setup" (or whatever, but some text is good for the
    README).
  * Public.
  * YES Initialize this repository with a README.
  
For everything else, just accept the default.

Click big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download"
button.

### Clone the repo to your local computer

Go to the shell (Appendix \@ref(shell)).

Take charge of -- or at least notice! -- what directory you're in. `pwd`
displays the working directory. `cd` is the command to change directory.
Personally, I would do this sort of thing in `~/tmp`.

Clone `myrepo` from GitHub to your computer. This URL should have **your GitHub
username** and the name of **your practice repo**. If your shell (Appendix
\@ref(shell)) cooperates, you should be able to paste the whole `https://....`
bit that we copied above. But some shells are not (immediately) clipboard aware.
In that sad case, you must type it. **Accurately.**

``` bash
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
```
        
This should look something like this:

``` bash
jenny@2015-mbp tmp $ git clone https://github.com/jennybc/myrepo.git
Cloning into 'myrepo'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
Checking connectivity... done.
```

Make this new repo your working directory, list its files, display the README,
and get some information on its connection to GitHub:

``` bash
cd myrepo
ls
head README.md
git remote show origin
```

This should look something like this:

``` bash
jenny@2015-mbp ~ $ cd myrepo

jenny@2015-mbp myrepo $ ls
README.md

jenny@2015-mbp myrepo $ head README.md 
# myrepo
tutorial development

jenny@2015-mbp myrepo $ git remote show origin
* remote origin
  Fetch URL: https://github.com/jennybc/myrepo.git
  Push  URL: https://github.com/jennybc/myrepo.git
  HEAD branch: master
  Remote branch:
    master tracked
  Local branch configured for 'git pull':
    master merges with remote master
  Local ref configured for 'git push':
    master pushes to master (up to date)
```

### Make a local change, commit, and push

Add a line to README and verify that Git notices the change:

``` bash
echo "A line I wrote on my local computer" >> README.md
git status
```

This should look something like this:

``` bash
jenny@2015-mbp myrepo $ echo "A line I wrote on my local computer" >> README.md
jenny@2015-mbp myrepo $ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

	modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

Stage ("add") and commit this change and push to your remote repo on GitHub. If
you're a new GitHub user, you will be challenged for your GitHub username and
password. Provide them!

``` bash
git add -A
git commit -m "A commit from my local computer"
git push
```

The `-m "blah blah blah"` piece is very important! Git requires a commit message
for every commit, so if you forget the `-m` flag, Git will prompt you for a
commit message anyway. And you might not like [the editor that Git
chooses](#git-editor). It is good practice to write meaningful commit messages,
so that, in the future, potential collaborators (and your future self) will
understand the progression of a project.

This should look something like this:

``` bash
jenny@2015-mbp myrepo $ git add -A

jenny@2015-mbp myrepo $ git commit -m "A commit from my local computer"
[master de669ba] A commit from my local computer
 1 file changed, 1 insertion(+)
 
jenny@2015-mbp myrepo $ git push
Counting objects: 3, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 311 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/jennybc/myrepo.git
   b4112c5..de669ba  master -> master
```

### Windows and line endings

On Windows, you might see a message about `LF will be replaced by CRLF`. This is
normal and does not require any action on your part. Windows handles line
endings differently from other operating systems, but the default setup for Git
for Windows is appropriate for most people and situations.

Here's a command to reveal the current line ending configuration and some
typical output **on Windows**:

``` bash
$ git config --show-origin --get core.autocrlf
file:"C:\\ProgramData/Git/config"      true
```

If your value shows as `false`, you can set it to `true` with this command:

``` bash
$ git config --global core.autocrlf true
```

`true` is the current default setting for `core.autocrlf` for [Git for
Windows](#install-git-windows), our recommended method for installing Git on
Windows. The need to set this explicitly in your global user config suggests you
should consider reinstalling or updating Git for Windows.

### Confirm the local change propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see the new "A line I wrote on my local computer" in the README.

If you click on "commits," you should see one with the message "A commit from my
local computer."

If you have made it this far, you are ready to graduate to using Git and GitHub
with RStudio (chapter \@ref(rstudio-git-github)). But first ...

### Am I really going to type GitHub username and password on each push?

It is likely that your first push, above, leads to a challenge for your GitHub
username and password. This will drive you crazy in the long-run and make you
reluctant to push. You want to eliminate this annoyance.

Luckily, if you've installed Git one of the ways recommended by Happy Git, it is
likely that Git is already using a credential helper provided by your operating
system! If so, your GitHub credentials were cached when you successfully pushed
above. This setup applies across repos, i.e. it's not limited to our current
test repo.

I suggest you make another local change to README.md, stage (i.e. "add") it,
commit it, and push, using the commands shown above. If this "just works" and
shows up on GitHub, rejoice. You are ready to work with GitHub via HTTPS without
constantly re-entering your credentials. You are ready to delete this toy repo.

If you are challenged for your username and password *again*, do one of the
following:

  * Cache credentials for HTTPS access, chapter \@ref(credential-caching).
  * Set up SSH keys, chapter \@ref(ssh-keys).

Now is the perfect time to do this, since you have a functioning test repo.

### Clean up

**Local** When you're ready to clean up, you can delete the local repo any way
you like. It's just a regular directory on your computer.

Here's how to do that in the shell, if current working directory is `myrepo`:

``` bash
cd ..
rm -rf myrepo/
```

**GitHub** In the browser, go to your repo's landing page on GitHub. Click on
"Settings".

Scroll down, click on "delete repository," and do as it asks.

## Connect RStudio to Git and GitHub {#rstudio-git-github}

Here we verify that RStudio can issue Git commands on your behalf. Assuming that
you've gotten local Git to talk to GitHub, this means you'll also be able to
pull from and push to GitHub from RStudio.

In later chapters and in live workshops, we revisit these operations with much
more explanation.

If you succeed here, your set up is DONE.

### Prerequisites

We assume the following: 

  * You've registered a free GitHub account (chapter \@ref(github-acct)).
  * You've installed/updated R and RStudio (chapter \@ref(install-r-rstudio)).
  * You've installed Git (chapter \@ref(install-git)).
  * You've introduced yourself to Git (chapter \@ref(hello-git)).
  * You've confirmed that you can push to / pull from GitHub from the command
    line (chapter \@ref(push-pull-github)).

### Make a repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click the green "New repository" button. Or, if you are on your own profile
page, click on "Repositories", then click the green "New" button.

How to fill this in:

  * Repository name: `myrepo` (or whatever you wish, we'll delete this soon anyway).
  * Description: "testing my setup" (or whatever, but some text is good for the README).
  * Public.
  * YES Initialize this repository with a README.
  
For everything else, just accept the default.

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button.

### Clone the new GitHub repository to your computer via RStudio

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In "Repository URL", paste the
    URL of your new GitHub repository. It will be something like this
    `https://github.com/jennybc/myrepo.git`.
    - Do you NOT see an option to get the Project from Version Control? Restart
      RStudio and try again. Still no luck? Go to chapter \@ref(rstudio-see-git)
      for tips on how to help RStudio find Git.
  * Accept the default project directory name, e.g. `myrepo`, which coincides
    with the GitHub repo name.
  * Take charge of -- or at least notice! -- where the Project will be saved
    locally. A common rookie mistake is to have no idea where you are saving
    files or what your working directory is. Pay attention. Be intentional.
    Personally, I would do this in `~/tmp`.
  * I suggest you check "Open in new session", as that's what you'll usually do in real life.
  * Click "Create Project".

You should find yourself in a new local RStudio Project that represents the new
test repo we just created on GitHub. This should download the `README.md` file
from GitHub. Look in RStudio's file browser pane for the `README.md` file.

### Make local changes, save, commit

From RStudio, modify the `README.md` file, e.g., by adding the line "This is a
line from RStudio". Save your changes.

Commit these changes to your local repo. How?

From RStudio:

  * Click the "Git" tab in upper right pane.
  * Check "Staged" box for `README.md`.
  * If you're not already in the Git pop-up, click "Commit".
  * Type a message in "Commit message", such as "Commit from RStudio".
  * Click "Commit".

### Push your local changes online to GitHub
  
Click the green "Push" button to send your local changes to GitHub. If you are
challenged for username and password, provide them (but see below). You should
see some message along these lines.

``` bash
[master dc671f0] blah
 3 files changed, 22 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 myrepo.Rproj
```

### Confirm the local change propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see the new "This is a line from RStudio" in the README.

If you click on "commits", you should see one with the message "Commit from RStudio".

If you have made it this far, you are DONE with set up. But first ...

### Were you challenged for GitHub username and password?

If you somehow haven't done so yet, now is the perfect time to make sure you
don't need to keep providing username and password on each push.

First, make another small change locally and push again, to make sure we've
given your system every opportunity to cache your credentials and retrieve them
from the cache. It might "just work".

Are you still challenged? Pick one:

  * Credential caching for HTTPS access, chapter \@ref(credential-caching).
  * Set up SSH keys, chapter \@ref(ssh-keys).

Now is the perfect time to do this, since you have a functioning test repo.

### Clean up

**Local** When you're ready to clean up, you can delete the local repo any way
you like. It's just a regular directory on your computer.

**GitHub** In the browser, go to your repo's landing page on GitHub. Click on
"Settings".

Scroll down, click on "delete repository," and do as it asks.


## Detect Git from RStudio {#rstudio-see-git}

If you want RStudio to help with your Git and GitHub work, it must be able to
find the Git executable.

This usually "just works", so this page is aimed at people who have reason to
suspect they have a problem.

This is something you set up once-per-computer.

### Do you have a problem?

Let's check if RStudio can find the Git executable.

  * *File > New Project...* Do you see an option to create from Version Control?
    If yes, good.
  * Select *New Directory* > *Empty Project*. Do you see a checkbox "Create a
    git repository"? If yes, good, CHECK IT.
  * Give this disposable test project a name and click *Create Project*. Do you
    see a "Git" tab in the upper right pane, the same one that has "Environment"
    and "History"? If yes, good.
  
If all looks good, you can delete this project. Looks like RStudio and Git are
talking to each other.

Keep reading if things don't go so well or you want to know more.

### Find Git yourself

RStudio can only act as a GUI front-end for Git if Git has been successfully
installed (chapter \@ref(install-git)) **AND RStudio can find it**.

A basic test for successful installation of Git is to simply enter `git` in the
shell (Appendix \@ref(shell)). If you get a complaint about Git not being found,
it means installation was unsuccessful or that it is not being found, i.e. it is
not on your `PATH`.

If you are not sure where the Git executable lives, try this in a shell:
  
* `which git` (Mac, Linux, Git Bash shell on Windows)

* `where git` (Windows command prompt, i.e. `cmd.exe`)

### Tell RStudio where to find Git

If Git appears to be installed and findable, launch RStudio. Quit and re-launch RStudio if there's __any doubt in your mind__ about whether you opened RStudio before or after installing Git. Don't make me stop this car and restart RStudio for you in office hours. DO IT.

From RStudio, go to *Tools > Global Options > Git/SVN* and make sure that the box *Git executable* points to your Git executable.

On macOS and Linux, the path usually looks something like this:

``` bash
/usr/bin/git
```

If you need to set this on macOS, it can sometimes be hard to navigate to the necessary directory, once you've clicked "Browse" and are working with a Finder-type window. The keyboard shortcut "command + shift + g" will summon "Go To Folder", where you will be able to type or paste any path you want.

On Windows, this path should look something like this:

``` bash
C:/Program Files/Git/bin/git.exe
```

and here is a screenshot on Windows:

![RStudio screenshot showing path to Git executable](img/windows-rstudio-git-executable-screenshot.png)

**WARNING**: On Windows, do __NOT__ use `C:/Program Files/Git/cmd/git.exe`. `bin` in the path is GOOD YES! `cmd` in the path is BAD NO!

**WARNING**: On Windows, do __NOT__ set this to `git-bash.exe`. Something that ends in `git.exe` is GOOD YES! `git-bash.exe` is BAD NO!
  
**Restart RStudio if you make any changes.** Don't make me stop this car again and restart RStudio for you in office hours. DO IT.

Do the steps at the top of the page to see if RStudio and Git are communicating now.

No joy?

  * I've seen this help: With your Project open, go to `Tools > Project Options...`. If available, click on "Git/SVN" and select "Git" in the Version control system dropdown menu. Answer "yes" to the "Confirm New Git Repository" pop up. Answer "yes" to the "Confirm Restart RStudio" pop up.

  * If you installed Git via GitHub for Windows, it is possible the Git executable is really well hidden. Get help or use one of [our recommended methods of installing Git](#install-git).

  * Your `PATH` is probably not set up correctly and/or you should re-install Git and control/notice where it's going. Read more in \@ref(troubleshooting).

  * Get our help.

