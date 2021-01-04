# Get started with GitHub {#usage-intro}

Now that we've verified your Git/GitHub/RStudio setup, we can demo the workflows
you'll use to get your work onto GitHub:

  * [New project, GitHub first] is the easiest way to get a working project.
  * [Existing project, GitHub first] is a deeply pragmatic way to get pre-existing work onto GitHub.
  * [Existing project, GitHub last] is the more proper way to connect existing
    local work to a remote on GitHub, especially if there's already a Git
    history.
  
This part concludes with two R-specific workflows that show off how well 
[R Markdown (the format)](https://rmarkdown.rstudio.com) and 
[rmarkdown (the package)](https://cran.r-project.org/package=rmarkdown) 
work with GitHub:

  * [Test drive R Markdown]
  * [Render an R script]

## New project, GitHub first {#new-github-first}

We create a new Project, with the preferred "GitHub first, then RStudio"
sequence. Why do we prefer this? Because this method of copying the Project from
GitHub to your computer also sets up the local Git repository for immediate
pulling and pushing. Under the hood, we are doing `git clone`.

You've actually done this before during set up (chapter
\@ref(rstudio-git-github)). We're doing it again, *with feeling*.

The workflow is pretty similar for other repository managers like GitLab or
Bitbucket. We will specify below when you may need to do something differently.

### Make a repo on GitHub

**Do this once per new project.**

Go to <https://github.com> and make sure you are logged in.

Click green "New repository" button. Or, if you are on your own profile page,
click on "Repositories", then click the green "New" button.

- Repository name: `myrepo` (or whatever you wish)  
- Public  
- YES Initialize this repository with a README

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download"
button. Or copy the SSH URL if you chose to set up SSH keys.

### New RStudio Project via git clone {#new-rstudio-project-via-git}

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository. It will be something like this `https://github.com/jennybc/myrepo.git`.
  * Be intentional about where you create this Project.
  * Suggest you "Open in new session".
  * Click "Create Project" to create a new directory, which will be all of these things:
    - a directory or "folder" on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project
  * **In the absence of other constraints, I suggest that all of your R projects have exactly this set-up.**

This should download the `README.md` file that we created on GitHub in the
previous step. Look in RStudio's file browser pane for the `README.md` file.

There's a big advantage to the "GitHub first, then RStudio" workflow: the remote
GitHub repo is added as a remote for your local repo and your local `master`
branch is now tracking `master` on GitHub. This is a technical but important
point about Git. The practical implication is that you are now set up to push
and pull. No need to fanny around setting up Git remotes and tracking branches
on the command line.

#### Optional: peek under the hood

Completely optional activity: use command line Git to see what we're talking
about above, i.e. the remote and tracking branch setup.

`git remote -v`or `git remote --verbose` shows the remotes you have setup.
Here's how that looks for someone using SSH with GitHub and calling it `origin`
(a convention I hate but am resigned to):

``` sh
$ git remote -v
origin  git@github.com:jennybc/myrepo.git (fetch)
origin  git@github.com:jennybc/myrepo.git (push)
```

`git branch -vv` prints info about the current branch. In particular, we can see
that local `master` is tracking the `master` branch on `origin`, a.k.a.
`origin/master`.

``` sh
$ git branch -vv
* master 7c98308 [origin/master] Initial commit
```

`git clone`, which RStudio did for us, sets all of this up automatically. This
is why "GitHub first, then RStudio" is the preferred way to start projects early
in your Git/GitHub life.

### Make local changes, save, commit

**Do this every time you finish a valuable chunk of work, probably many times a day.**

From RStudio, modify the `README.md` file, e.g., by adding the line "This is a
line from RStudio". Save your changes.

Commit these changes to your local repo. How?

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for any files whose existence or modifications you want
    to commit.
    - To see more detail on what's changed in file since the last commit, click
      on "Diff" for a Git pop-up
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message", such as "Commit from RStudio".
  * Click "Commit"

### Push your local changes to GitHub

**Do this a few times a day, but possibly less often than you commit.**

You have new work in your local Git repository, but the changes are not online
yet.

This will seem counterintuitive, but first let's stop and pull from GitHub.

Why? Establish this habit for the future! If you make changes to the repo in the
browser or from another machine or (one day) a collaborator has pushed, you will
be happier if you pull those changes in before you attempt to push.
  
Click the blue "Pull" button in the "Git" tab in RStudio. I doubt anything will
happen, i.e. you'll get the message "Already up-to-date." This is just to
establish a habit.

Click the green "Push" button to send your local changes to GitHub. You should
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

If you click on "commits," you should see one with the message "Commit from
RStudio".

### Make a change on GitHub

Click on README.md in the file listing on GitHub.

In the upper right corner, click on the pencil for "Edit this file".

Add a line to this file, such as "Line added from GitHub."

Edit the commit message in "Commit changes" or accept the default.

Click the big green button "Commit changes."

### Pull from GitHub

Back in RStudio locally ...

Inspect your README.md. It should NOT have the line "Line added from GitHub". It
should be as you left it. Verify that.

Click the blue Pull button.

Look at README.md again. You should now see the new line there.

### The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it\*
depending on where you did it, but get local and remote "synced up". Repeat.

\* Note that in general (and especially in future when collaborating with other
developers) you will usually need to pull changes from the remote (GitHub)
before pushing the local changes you have made. For this reason, it's a good
idea to try and get into the habit of pulling before you attempt to push.

## Existing project, GitHub first {#existing-github-first}

A novice-friendly workflow for bringing an existing R project into the RStudio
and Git/GitHub universe.

We do this in a slightly awkward way, in order to avoid using Git at the command
line. You won't want to work this way forever, but it's perfectly fine as you're
getting started!

We assume you've got your existing R project isolated in a directory on your computer. If that's not already true, make it so. Create a directory and marshal all the existing data and R scripts there. It doesn't really matter where you do this, but note where the project currently lives.

### Make a repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click the green "New repository" button. Or, if you are on your own profile page, click on "Repositories", then click the green "New" button.

Pick a repository name that actually reminds you what the project is about! But try to be concise.

Public  
YES Initialize this repository with a README

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download" button. Or copy the SSH URL if you chose to set up SSH keys.

### New RStudio Project via git clone

In RStudio, start a new Project:

  * *File > New Project > Version Control > Git*. In the "repository URL" paste the URL of your new GitHub repository. It will be something like this `https://github.com/jennybc/myrepo.git`.
  * Be intentional about where you create this Project.
  * Suggest you "Open in new session".
  * Click "Create Project" to create a new directory, which will be all of these things:
    - a directory or "folder" on your computer
    - a Git repository, linked to a remote GitHub repository
    - an RStudio Project

This should download the `README.md` file that we created on GitHub in the previous step. Look in RStudio's file browser pane for the `README.md` file.

### Bring your existing project over

Using your favorite method of moving or copying files, copy the files that constitute your existing project into the directory for this new project.

In RStudio, consult the Git pane and the file browser.

  * Are you seeing all the files? They should be here if your move/copy was successful.
  * Are they showing up in the Git pane with questions marks? They should be appearing as new untracked files.
  
### Stage and commit

Commit your files to this repo. How?

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for all files you want to commit.
    - Default: stage it.
    - When to reconsider: this will all go to GitHub. So do consider if that is appropriate for each file. **You can absolutely keep a file locally, without committing it to the Git repo and sending to GitHub**. Just let it sit there in your Git pane, without being staged. No harm will be done. If this is a long-term situation, list the file in `.gitignore`.
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message", such as "init".
  * Click "Commit"

### Push your local changes to GitHub

Click the green "Push" button to send your local changes to GitHub. You should see some message along these lines.

``` bash
[master dc671f0] blah
 3 files changed, 22 insertions(+)
 create mode 100644 .gitignore
 create mode 100644 myrepo.Rproj
```

### Confirm the local change propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see all the project files you committed there.

If you click on "commits," you should see one with the message "init".

### The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it\* depending on where you did it, but get local and remote "synced up". Repeat.

\* Note that in general (and especially in future when collaborating with other developers) you will usually need to pull changes from the remote (GitHub) before pushing the local changes you have made. For this reason, it's a good idea to try and get into the habit of pulling before you attempt to push.

## Existing project, GitHub last {#existing-github-last}

An explicit workflow for connecting an existing local R project to GitHub, when
for some reason you cannot or don't want to do a "GitHub first" workflow (see
chapters \@ref(new-github-first) and \@ref(existing-github-first)).

When does this come up? Example: it's an existing project that is already a Git
repo with a history you care about. Then you have to do this properly.

This is less desirable for a novice because there are more opportunities to get
confused and make a mistake. RStudio and the
[usethis](https://cran.r-project.org/package=usethis) package are gradually
making this easier, so you can avoid working with Git in the shell (Appendix
\@ref(shell)). But command line Git remains a viable option. All are covered
below.

### Make or verify an RStudio Project

We assume you've got your existing R project isolated in a directory on your computer.

If it's not already an RStudio Project, make it so:

  * If you use the [usethis](https://cran.r-project.org/package=usethis)
    package, set the existing directory as the current project with
    `usethis::create_project()`.
  * Within RStudio you can do: *File > New Project > Existing Directory* and, if
    you wish, "Open in new session".

If your project is already an RStudio Project, launch it.

### Make or verify a Git repo

You should be in RStudio now, in your project.

Is it already a Git repository? The presence of the Git pane should tip you off.
If yes, you're done.

If not, you have several options:

  * If you have the [usethis](https://cran.r-project.org/package=usethis)
    package, call `usethis::use_git()`.
  * In RStudio, go to *Tools > Project Options ... > Git/SVN*. Under "Version
    control system", select "Git". Confirm New Git Repository? Yes!
  * In the shell, in Project's directory, do `git init`.

If you used RStudio or usethis, the Project should re-launch in RStudio. Do that
yourself if you did `git init`. RStudio should now have a Git pane.

### Stage and commit

If your local project was already a Git repo and was up-to-date, move on.
Otherwise, you probably need to stage and commit.

  * Click the "Git" tab in upper right pane
  * Check "Staged" box for all files you want to commit.
    - Default: stage everything
    - When to do otherwise: this will all go to GitHub. So consider if that is
      appropriate for each file. **You can absolutely keep a file locally,
      without committing it to the Git repo and sending to GitHub**. Just let it
      sit there in your Git pane, without being staged. No harm will be done. If
      this is a long-term situation, list the file in `.gitignore`.
  * If you're not already in the Git pop-up, click "Commit"
  * Type a message in "Commit message".
  * Click "Commit"

### Make and connect a GitHub repo, option 1

If you use the [usethis](https://cran.r-project.org/package=usethis) package AND
you have configured a GitHub Personal Access Token (PAT) (see
[the appendix][GitHub Personal Access Tokens] for how to set this up.), do this
in R:

    usethis::use_github()
    
This will create a new repo on GitHub, add it as a remote, set up a tracking
branch, and open it in your browser. Read the `use_github()` help to learn about
its arguments and advice on configuring a PAT. This is extremely handy for a
variety of workflows that call the GitHub API. Consider setting this up if you
use usethis, devtools, or gh regularly.

### Make and connect a GitHub repo, option 2

#### Make a new repo on GitHub

Go to <https://github.com> and make sure you are logged in.

Click the green "New repository" button. Or, if you are on your own profile
page, click on "Repositories", then click the green "New" button.

Pick a repository name -- it should probably match the name of your local
Project and directory. Why confuse yourself?

Public or private, as appropriate  
**DO NOT initialize this repository with a README.**

Click the big green button "Create repository."

Copy the HTTPS clone URL to your clipboard via the green "Clone or Download"
button. Or copy the SSH URL if you chose to set up SSH keys.

#### Connect local repo to GitHub repo

You can do this in the shell or, with recent versions of RStudio, via RStudio.

#### In RStudio

Click on the "two purple boxes and a white square" in the Git pane. Click "Add
remote". Paste the URL here and pick a remote name, almost certainly `origin`.
Now "Add".

We should be back in the "New Branch" dialog (if not, click on the "two purple
boxes and a white square" in the Git pane again). I assume you're on the
`master` branch want it to track `master` on GitHub. Enter `master` as the
branch name and make sure "Sync branch with remote" is checked. Click "Create"
(yes, even though the branch already exists). In the next dialog, choose
"overwrite".

#### In the shell

In a shell, do this, substituting your URL:

        git remote add origin https://github.com/jennybc/myrepo.git

Push and cement the tracking relationship between your local `master` branch and `master` on GitHub:
  
        git push --set-upstream origin master

### Confirm the local files propagated to the GitHub remote

Go back to the browser. I assume we're still viewing your new GitHub repo.

Refresh.

You should see all the project files you committed there.

If this project already had a Git history, it should be reflected on GitHub.

### The end

Now just ... repeat. Do work somewhere. Commit it. Push it or pull it depending
on where you did it, but get local and remote "synced up". Repeat.

Note that in general (and especially in future when collaborating with other
developers) you will usually need to pull changes from the remote (GitHub)
before pushing the local changes you have made. For this reason, it's a good
idea to try and get into the habit of pulling before you attempt to push.

## Test drive R Markdown {#rmd-test-drive}

We will author an R Markdown document and render it to HTML. We discuss how to
keep the intermediate Markdown file, the figures, and what to commit to Git and
push to GitHub. If GitHub is the primary venue, we render directly to
GitHub-flavored markdown and never create HTML.

Here is the official R Markdown documentation: <http://rmarkdown.rstudio.com>

### Hello World

We'll practice with RStudio's boilerplate R Markdown document.

Launch RStudio in a Project that is a Git repo that is connected to a GitHub
repo.

We are modelling "walk before you run" here. It is best to increase complexity
in small increments. We test our system's ability to render the
["hello world"](http://en.wikipedia.org/wiki/%22Hello,_world!%22_program) 
of R Markdown documents before we muddy the waters with our own, probably buggy, documents.

Do this: *File > New File > R Markdown ...*

  - Give it an informative title. This will appear in the document but does not
    necessarily have anything to do with the file's name. But the title and
    filename should be related! Why confuse yourself? The title is for human
    eyeballs, so it can contain spaces and punctuation. The filename is for
    humans and computers, so it should have similar words in it but no spaces
    and no punctuation.
  - Accept the default Author or edit if you wish.
  - Accept the default output format of HTML.
  - Click OK.

Save this document to a reasonable filename and location. The filename should
end in `.Rmd` or `.rmd`. Save in the top-level of this RStudio project and Git
repository, that is also current working directory. Trust me on this and do this
for a while.

You might want to commit here. So you can see what's about to change ...

Click on "Knit HTML" or do *File > Knit Document*. RStudio should display a
preview of the resulting HTML. Also look at the file browser. You should see the
R Markdown document, i.e. `foo.Rmd` AND the resulting HTML `foo.html`.

Congratulations, you've just made your first reproducible report with R Markdown.

You might want to commit here.

### Push to GitHub

Push the current state to GitHub.

Go visit it in the browser.

Do you see the new files? An R Markdown document and the associated HTML? Visit both in the browser. Verify this:

  * Rmd is quite readable. But the output is obviously not there.
  * HTML is ugly.

### Output format

Do you really want HTML? Do you only want HTML? If so, you can skip this step!

The magical process that turns your R Markdown to HTML is like so: `foo.Rmd -->
foo.md --> foo.html`. Note the intermediate markdown, `foo.md`. By default
RStudio discards this, but you might want to hold on to that markdown.

Why? GitHub gives very special treatment to markdown files. They are rendered in
an almost HTML-like way. This is great because it preserves all the charms of
plain text but gives you a pseudo-webpage for free when you visit the file in
the browser. In contrast, HTML is rendered as plain text on GitHub and you'll
have to take special measures to see it the way you want.

In many cases, you *only want the markdown*. In that case, we switch the output
format to `github_document`. This means render will be `foo.Rmd --> foo.md`,
where `foo.md` is GitHub-flavored markdown. If you still want the HTML *but also
the intermediate markdown*, there's a way to request that too.

**Output format** is one of the many things we can control in the YAML
frontmatter -- the text at the top of your file between leading and trailing
lines of `---`.

You can make some changes via the RStudio IDE: click on the "gear" in the top
bar of the source editor, near the "Knit HTML" button. Select "Output options"
and go to the Advanced tab and check "Keep markdown source file." Your YAML
should now look more like this:

``` yaml
    ---
    title: "Something fascinating"
    author: "Jenny Bryan"
    date: "2021-01-04"
    output:
      html_document:
        keep_md: true
    ---
```

You should have gained the line `keep_md: true`. You can also simply edit the
file yourself to achieve this.

In fact this hand-edit is necessary if you want to keep only markdown and get
GitHub-flavored markdown. In that case, make your YAML look like this:

``` yaml
    ---
    title: "Something fascinating"
    author: "Jenny Bryan"
    date: "2021-01-04"
    output: github_document
    ---
```

Save!

You might want to commit here.

Render via "Knit HTML" button.

Now revisit the file browser. In addition to `foo.Rmd`, you should now see
`foo.md`. If there are R chunks that make figures, the usage of markdown output
formats will also cause those figure files to be left behind in a sensibly named
sub-directory, `foo_files`.

If you commit and push `foo.md` and everything inside `foo_files`, then anyone
with permission to view your GitHub repo can see a decent-looking version of
your report.

If your output format is `html_document`, you should still see `foo.html`. If
your output format is `github_document` and you see `foo.html`, that's leftover
from earlier experiments. Delete that. It will only confuse you later.

You might want to commit here.

### Push to GitHub

Push the current state to GitHub.

Go visit it in the browser.

Do you see the modifications and new file(s)? Your Rmd should be modified (the
YAML frontmatter changed). And you should have gained at least, the associated
markdown file.

  * Visit the markdown file and compare to our previous HTML.
  * Do you see how the markdown is much more useful on GitHub? Internalize that.

### Put your stamp on it

Select everything but the YAML frontmatter and ... delete it!

Write a single English sentence.

Insert an empty R chunk, via the "Chunk" menu in upper right of source editor or
with corresponding keyboard shortcut.

<!-- resorting to less desirable trick because usual trick does not play nice with bookdown -->

<pre><code>

```r
## insert your brilliant WORKING code here
```
</code></pre>

Insert 1 to 3 lines of functioning code that begin the task at hand. "Walk through" and run those lines using the "Run" button or the corresponding keyboard shortcut. You MUST make sure your code actually works!

Satisfied? Save!

You might want to commit here.

Now render the whole document via "Knit HTML." Voilà!

You might want to commit here.

### Develop your report

In this incremental manner, develop your report. Add code to this chunk. Refine it. Add new chunks. Go crazy! But keep running the code "manually" to make sure it works.

If it doesn't work with you babysitting it, I can guarantee you it will fail, in a more spectacular and cryptic way, when run at arms-length via "Knit HTML" or `rmarkdown::render()`.

Clean out your workspace and restart R and re-run everything periodically, if things get weird. There are lots of chunk menu items and keyboard shortcuts to accelerate this workflow. Render the whole document often to catch errors when they're easy to pinpoint and fix. Save often and commit every time you reach a point that you'd like as a "fall back" position.

You'll develop your own mojo soon, but this should give you your first successful R Markdown experience.

### Publish your report

If you've been making HTML, you can put that up on the web somewhere, email to your collaborator, whatever.

No matter what, technically you can publish this report merely by pushing a rendered version to GitHub. However, certain practices make this effort at publishing more satisfying for your audience.

Here are two behaviors I find very frustrating:

  * "Here is my code. Behold." This is when someone only pushes their source, i.e. R Markdown or R code AND they want other people to look at their "product". The implicit assumption is that target audience will download code and run it. Sometimes the potential payoff simply does not justify this effort.
  * "Here is my HTML. Behold." This is when someone doesn't bother to edit the default output format and accepts HTML only. What am I supposed to do with HTML on GitHub?

Creating, committing, and pushing markdown is a very functional, lighweight publishing strategy. Use `output: github_document` or `keep_md: true` if output is `html_document`. In both cases, it is critical to also commit and push everything inside `foo_files`. Now people can visit and consume your work like any other webpage.

This is (sort of) another example of keeping things machine- and human-readable, which is bliss. By making `foo.Rmd` available, others can see and run your __actual code__. By sharing `foo.md` and/or `foo.html`, others can casually browse your end product and decide if they even want to bother.

### HTML on GitHub

HTML files, such as `foo.html`, are not immediately useful on GitHub (though your local versions are easily viewable). Visit one and you'll see the raw HTML. Yuck. But there are ways to get a preview: such as <http://htmlpreview.github.io>. Expect much pain with HTML files inside private repos (hence the recommendations above to emphasize markdown). When it becomes vital for the whole world to see proper HTML in its full glory, it's time to use a more sophisticated web publishing strategy.

I have more [general ideas](#workflows-browsability) about how to make a GitHub repo function as a website.

### Troubleshooting {#rmd-troubleshooting}

__Make sure RStudio and the `rmarkdown` package (and its dependencies) are up-to-date.__ In case of catastrophic failure to render the boilerplate R Markdown document, consider that your software may be too old. Details on the system used to render this document and how to check your setup:

  * rmarkdown version 2.6. Use `packageVersion("rmarkdown")` to check yours.
  * R version 4.0.3 (2020-10-10). Use `R.version.string` to check yours.
  * RStudio IDE 1.2.1555. Use *RStudio > About RStudio* or `RStudio.Version()$version` to check yours.

__Get rid of your `.Rprofile`__, at least temporarily. I have found that a "mature" `.Rprofile` that has accumulated haphazardly over the years can cause trouble. Specifically, if you've got anything in there relating to `knitr`, `markdown`, `rmarkdown` and RStudio itself, it may be preventing the installation or usage of the most recent goodies. Comment the whole file out or rename it something else and relaunch or even re-install RStudio.

__"I have ignored your advice and dumped a bunch of code in at once. Now my Rmd does not render."__ If you can't figure out what's wrong by reading the error messages, pick one:

  * Back out of these changes, get back to a functional state (possibly with no code), and restore them gradually. Run your code interactively to make sure it works. Render the entire document frequently. Commit after each successful addition! When you re-introduce the broken code, now it will be part of a small change and the root problem will be much easier to pinpoint and fix.
  * Tell knitr to soldier on, even in the presence of errors. Some problems are easier to diagnose if you can execute specific R statements during rendering and leave more evidence behind for forensic examination.
    - Insert this chunk near the top of your `.Rmd` document:
<pre><code>

</code></pre>
    - If it's undesirable to globally accept errors, you can still do this for a specific chunk like so:
<pre><code>

```r
## your sketchy code goes here ;)
```
</code></pre>
  * Adapt the ["git bisect" strategy](http://webchick.net/node/99):
    - Put `knitr::knit_exit()` somewhere early in your `.Rmd` document, either in inline R code or in a chunk. Keep moving it earlier until things work. Now move it down in the document. Eventually you'll be able to narrow down the location of your broken code well enough to find the line(s) and fix it.

__Check your working directory.__ It's going to break your heart as you learn how often your mistakes are really mundane and basic. Ask me how I know. When things go wrong consider:

  * What is the working directory?
  * Is that file I want to read/write actually where I think it is?

Drop these commands into R chunks to check the above:

  * `getwd()` will display working directory at __run time__. If you monkeyed around with working directory with, e.g., the mouse, maybe it's set to one place for your interactive development and another when "Knit HTML" takes over?
  * `list.files()` will list the files in working directory. Is the file you want even there?

__Don't try to change working directory within an R Markdown document__. Just don't. See [knitr FAQ #5](https://yihui.name/knitr/faq/). That is all.

__Don't be in a hurry to create a complicated sub-directory structure.__ RStudio/`knitr`/`rmarkdown` (which bring you the "Knit HTML" button) are rather opinionated about the working directory being set to the `.Rmd` file's location and about all files living together in one big happy directory. This can all be worked around. For example, I [recommend the here package](https://github.com/jennybc/here_here#readme) for building file paths, once you require sub-directories. But don't do this until you really need it.


## Render an R script {#r-test-drive}

An under-appreciated fact is that much of what you can do with R Markdown, you
can also do with an R script.

If you're in analysis mode and want a report as a side effect, write an R
script. If you're writing a report with a lot of R code in it, write Rmd. In
either case, render to markdown and/or HTML to communicate with other human
beings.

  * In R markdown, prose is top-level and code is tucked into chunks.
  * In R scripts, code is top-level and prose is tucked into comments. You will
    use `#'` to request that certain comments appear as top-level prose in the
    rendered output.

You will continue to specify things like the output format via YAML at the top
of the file. This will need to be commented with `#'`.

### Morph R Markdown into a renderable R script

Get yourself a working R Markdown file, such as the one you made in your 
[Rmd test drive](#rmd-test-drive). Or use the boilerplate Rmd document RStudio
makes with *File > New File > R Markdown ...*.

Save the file as `foo.R`, as opposed to `foo.Rmd`. Yes, for a brief moment, you
will have R Markdown saved as an R script, but that won't be true for long.

Transform the Rmd to R:

  * Anything that's not R code? Like the YAML and the English prose? Protect it
    with roxygen-style comments: start each line with `#'`.
  * Anything that's R code? Let it exist "as is" as top-level code. That means
    you'll need to change the syntax of R chunk headers like so:
  
    Before: ` ```{r setup, include = FALSE}`  
    After: `#+ r setup, include = FALSE`

    Replace the leading backticks and opening curly brace with `#+`.  
    Delete the trailing curly brace.  
    Delete the 3 backticks that end each chunk.

Render the R script through one of these methods:

  * Click on the "notebook" icon in RStudio to "Compile Report".
  * In RStudio, do *File > Knit Document*.
  * In R, do `rmarkdown::render("foo.R")`.

You'll get a markdown and/or HTML report, just as with R Markdown.

If you're having trouble making all the necessary changes and you're frustrated,
see below for an example you can copy and paste.

All the workflow tips from the [Rmd test drive](#rmd-test-drive) apply here:
when you script an analysis, render it to markdown, commit the `.R`, the `.md`,
any associated figures, and push to GitHub. Collaborators can see your code but
also browse the result without running it. This makes the current state of your
analysis accessible to someone who does not even run R or who wants to take a
quick look at things from a cell phone or while on vacation.

### Write a render-ready R script

Instead of morphing an R Markdown file, let's create a render-ready R script directly.

Create a new R script and copy/paste this code into it.







```r
#' Here's some prose in a very special comment. Let's summarize the built-in
#' dataset `VADeaths`.
## here is a regular code comment, that will remain as such
summary(VADeaths)

#' Here's some more prose. I can use usual markdown syntax to make things
#' **bold** or *italics*. Let's use an example from the `dotchart()` help to
#' make a Cleveland dot plot from the `VADeaths` data. I even bother to name
#' this chunk, so the resulting PNG has a decent name.
#+ dotchart
dotchart(VADeaths, main = "Death Rates in Virginia - 1940")
```

Render the R script through one of these methods:

  * Click on the "notebook" icon in RStudio to "Compile Report".
  * In RStudio, do *File > Knit Document*.
  * In R, do `rmarkdown::render("YOURSCRIPT.R")`.

Revel in your attractive looking report with almost zero effort! Seriously, all
you had to do was think about when to use special comments `#'` in order to
promote that to nicely rendered text.

Drawing on the workflow tips in [Rmd test drive](#rmd-test-drive), let's add
some YAML frontmatter, properly commented with `#'`, and request the
`github_document`. Here's the whole script again:




```r
#' ---
#' title: "R scripts can be rendered!"
#' author: "Jenny Bryan"
#' date: "April 1, 2014"
#' output: github_document
#' ---
#'
#' Here's some prose in a very special comment. Let's summarize the built-in
#' dataset `VADeaths`.
## here is a regular code comment, that will remain as such
summary(VADeaths)

#' Here's some more prose. I can use usual markdown syntax to make things
#' **bold** or *italics*. Let's use an example from the `dotchart()` help to
#' make a Cleveland dot plot from the `VADeaths` data. I even bother to name
#' this chunk, so the resulting PNG has a decent name.
#+ dotchart
dotchart(VADeaths, main = "Death Rates in Virginia - 1940")
```

Behind the scenes here we have used `rmarkdown::render()` to render this script
and you can go
[visit it on GitHub](https://github.com/jennybc/happy-git-with-r/blob/master/render-r-script-demo.md).


