# Installation -- Half the battle {#install-intro}

Getting all the necessary software installed, configured, and playing nicely
together is honestly half the battle when first adopting Git. Brace yourself for
some pain. The upside is that you can give yourself a pat on the back once you
get through this. And you __WILL__ get through this.

If you have some new problem and, especially, the corresponding solution, 
[we'd love to hear from you!](https://github.com/ibecav/happy-git-with-r). 
Our installation instructions are brand new, bear with us it's the hardest
part.

## Register an account with GitHub. It's free! {#github-acct}

  * <https://github.com>
  
Yes this applies to you! Even if you're the least geeky person in the group and
will never ever in a million years write a line of code **do this**.

**Registration Advice**

You change a lot of settings in the future, so don't fret about any of that now.
**Except your username. You might want to give that some thought.**

A few tips, which sadly may contradict each other:

  * Use an email address you actually monitor and follow. The 
    most likely address is your ct.gov address unless you're
    already a GitHub user in which case you can stick with that.
  * Incorporate at least part of your actual name! People like to know who
    they're dealing with. Also makes your username easier for people to guess or
    remember.
  * Feel free to reuse your username from other contexts, e.g., Twitter or Slack.

You can change your username later, but better to get this right the first time.

  * <https://help.github.com/articles/changing-your-github-username/>
  * <https://help.github.com/articles/what-happens-when-i-change-my-username/>

Go ahead and register your account **NOW**. If you haven't already gotten an
email invitation from us let Deepti or Chuck know. Since I work is not publicly
viewable the invite is clutch.

## Install or upgrade R and RStudio {#install-r-rstudio}



1. Install a pre-compiled binary of R for your OS from here:  
    <https://cloud.r-project.org>  
    
![Screenshot showing CRAN download](img/cran_screenshot.png)

Already have R installed? **Hold on: This is a great time to make sure your R installation is current.** Check your current version like so:


```r
    R.version.string
#> [1] "R version 4.0.3 (2020-10-10)"
```

1. Install RStudio Desktop. Already have RStudio? **Hold on: This is a great
   time to upgrade to the latest version.** Download it here:
    <https://www.rstudio.com/products/rstudio/download/> you can check
    version numbers with "About RStudio".
    
![Screenshot showing RStudio download](img/rstudio_versions.png)
    
1. Update your R packages:

From RStudio with `Packages -> Update` or from the console with:

    
    ```r
    update.packages(ask = FALSE, checkBuilt = TRUE)
    ```

**Get current, people.** You don't want to adopt new things on day one. But at
some point, running old versions of software adds unnecessary difficulty.

Is your R version "old"? R had a *major* version change in April 2020, with the
release of 4.0.0. It is a good idea to be on the current major version, meaning
4 "dot" something at this point, especially if you want to get the most out of your
work.

Each major version is followed by several years of smaller releases (minor and
patch releases). You can be more relaxed about upgrading minor versions, but you
still want to stay reasonably current. As the 4.something series unfolds, I
advise that you never fall more than 1 minor version behind.  As of December
2020 the current version of R is version 4.0.3 (2020-10-10).

It's probably OK if you are still on 4.0.0, but eventually you will
start to suffer. In particular, you can no longer install pre-built binary
add-on packages from CRAN.

Is your RStudio "old"? Unless you have a specific reason to prefer the released
version, try the Preview. RStudio is fairly conservative with official releases,
so the Preview version is used by many people for their daily work. This allows
you to enjoy the latest goodies much sooner. The Preview version updates much
more frequently (and in smaller increments) than the released version. This is
something you might update once every month or so.

## Install Git

You need Git, so RStudio can use it and so you can use it at the command line
(maybe).

If there's any chance it's installed already, verify that, rejoice, and skip
this step.

Otherwise, find installation instructions below for your operating system.




### Git already installed?

Go to the shell (Appendix \@ref(shell)). Enter `which git` to request the path
to your Git executable:


```bash
which git
#> /usr/bin/git
```

and `git --version` to see its version:
 

```bash
git --version
#> git version 2.24.3 (Apple Git-128)
```

If you are successful, that's great! You have Git already. No need to install!
Move on.

If, instead, you see something more like `git: command not found`, keep
reading.

macOS users might get an immediate offer to install command line developer
tools. Yes, you should accept! Click "Install" and read more below.

### Windows  {#install-git-windows}

Install [Git for Windows](https://git-for-windows.github.io/), also known as
`msysgit` or "Git Bash", to get Git in addition to some other useful tools, such
as the Bash shell. Yes, all those names are totally confusing, but you might
encounter them elsewhere and I want you to be well-informed.

![Screenshot showing Git download](img/git_install_small.png)

We like this because Git for Windows leaves the Git executable in a conventional
location, which will help you and other programs, e.g. RStudio, find it and use
it. This also supports a transition to more expert use, because the "Git Bash"
shell will be useful as you venture outside of R/RStudio.

  * **NOTE:** When asked about "Adjusting your PATH environment", make sure to
    select "Git from the command line and also from 3rd-party software".
    Otherwise, we believe it is good to accept the defaults.
  * Note that RStudio for Windows prefers for Git to be installed below
    `C:/Program Files` and this appears to be the default. This implies, for
    example, that the Git executable on my Windows system is found at
    `C:/Program Files/Git/bin/git.exe`. Unless you have specific reasons to
    otherwise, follow this convention.

This also leaves you with a Git client, though not a very good one. So check out
Git clients we recommend (chapter \@ref(git-client)).

FYI, this appears to be equivalent to what you would download from here: <https://git-scm.com/download/>.

### macOS

**Option 1** (*highly recommended*): Install the Xcode command line tools (**not all of Xcode**), which includes Git.

Go to the shell and enter one of these commands to elicit an offer to install
developer command line tools:

``` bash
git --version
git config
```

Accept the offer! Click on "Install".

Here's another way to request this installation, more directly:

``` bash
xcode-select --install
```

We just happen to find this Git-based trigger apropos.

Note also that, after upgrading macOS, you might need to re-do the above and/or
re-agree to the Xcode license agreement. We have seen this cause the RStudio Git
pane to disappear on a system where it was previously working. Use commands like
those above to tickle Xcode into prompting you for what it needs, then restart
RStudio.

**Option 2** : If you anticipate getting heavily into scientific computing,
you're going to be installing and updating lots of software. You should check
out [Homebrew](http://brew.sh), "the missing package manager for OS X". Among
many other things, it can install Git for you. Once you have Homebrew installed,
do this in the shell:

```
brew install git
```

## Introduce yourself to Git {#hello-git}

In the shell (Appendix \@ref(shell)):

``` bash
git config --global user.name 'Jane Doe'
git config --global user.email 'jane@example.com'
git config --global --list
```

substituting your name and **the email associated with your GitHub account**.

![Screenshot showing Git download](img/update_names.png)

The [usethis package](https://usethis.r-lib.org) offers an alternative approach.
You can set your Git user name and email from within R:


```r
## install if needed (do this exactly once):
## install.packages("usethis")

library(usethis)
use_git_config(user.name = "Jane Doe", user.email = "jane@example.org")
```

**More about `git config`**

An easy way to get into a shell from RStudio is *Tools > Terminal* or *Tools >
Shell*. More about the shell in the Appendix \@ref(shell).

Special Windows gotchas: If you are struggling on Windows, consider there are
different types of shell and you might be in the wrong one. You want to be in a
"Git Bash" shell, as opposed to Power Shell or the legacy `cmd.exe` command
prompt. Read more in [the Appendix](#windows-shell-hell). This might also be a
reason to do this configuration via the usethis package in R.

What user name should you give to Git? This does not have to be your GitHub user
name, although it can be. Another good option is your actual first name and last
name. If you commit from different machines, sometimes people work that info
into the user name. Your commits will be labelled with this user name, so make
it informative to potential collaborators and future you.

What email should you give to Git? This __must__ be the email associated with
your GitHub account.

These commands return nothing. You can check that Git understood what you typed
by looking at the output of `git config --global --list`.

**Configure the Git editor {#git-editor}**

Another Git option that many people eventually configure is the editor. At some
point, you will fail to give Git what it wants in terms of a commit message and
it will kick you into an editor. This can be distressing, if it's not your
editor of choice and you don't even know how to save and quit. You can enforce
your will with something along these lines:

``` bash
git config --global core.editor "emacs"
```

Substitute your preferred editor for `"emacs"` here. Software Carpentry's Git
lesson has a comprehensive listing of the exact `git config` command needed for
[many combinations of OS and editor](http://swcarpentry.github.io/git-novice/02-setup/).

## Install a Git client {#git-client}

This is optional.

Learning to use version control can be rough at first. I found the use of a GUI
– as opposed to the command line – extremely helpful when I was getting started.
I call this sort of helper application a Git client. It's really a Git(Hub)
client because it also helps you interact with GitHub or other remotes.

### What is a Git client? Why would you want one?

"Git" is really just a collection of individual commands you execute in the
shell (Appendix \@ref(shell)). This interface is not appealing for everyone.
Some may prefer to do Git operations via a client with a graphical interface.

Git and your Git client are not the same thing, just like R and RStudio are not
the same thing. A Git client and 
an [integrated development environment](https://en.wikipedia.org/wiki/Integrated_development_environment),
such as RStudio, are not necessary to use Git or R, respectively. But they make
the experience more pleasant because they reduce the amount of 
[command line bullshittery](http://www.pgbovine.net/command-line-bullshittery.htm) and provide
a richer visual representation of the current state.

RStudio offers a very basic Git client via its Git pane. I use this often for
simple operations, but you probably want another, more powerful one as well.

Fair warning: for some tasks, you must use the command line. But the more
powerful your Git client is, the less often this happens. The visual overview
given by your Git client can also be invaluable for understanding the current
state of things, even when preparing calls to command line Git.

Fantastic news: because all of the clients are just forming and executing Git
commands on your behalf, you don't have to pick one. You can literally do one
operation from the command line, do another from RStudio, and it just works.
*Very rarely, both clients
will scan the repo at the same time and you'll get an error message about
`.git/index.lock`. Try the operation again at least once before doing any
further troubleshooting.*

### No one is giving out Git Nerd merit badges

Work with Git in whatever way makes you most effective. Feel free to revisit
your approach over time or to use different approaches for different tasks. No
one can tell whether you use the command line or a GUI when they look at your
Git history or your GitHub repo.

I sometimes encounter people who feel it's "better" to use command line Git, but
for very ill-defined reasons. These people may feel like they *should* work in
the shell, even if it leads to Git-avoidance, frequent mistakes, or limiting
themselves to a small set of ~3 Git commands. This is counterproductive.

I had two false starts with Git, where I failed to get proficient enough,
quickly enough to truly incorporate version control into my daily work. I found
a visual Git client invaluable -- SourceTree, in my case. It made me willing to
use Git multiple times per day, for a sustained period of time. This helped me
build the mental model necessary for more advanced Git operations like rebasing,
cherry-picking, and resetting.

If your Git life happens on your own computer, there is no reason to deny
yourself a GUI if that's what you like. If you prefer working in the shell or if
you frequently log into a remote server, then it makes sense to prioritize
building Git skills at the command line. Do whatever works for you, but don't do
anything for the sake of purity or heroism.

### Recommended Git clients

  * [GitKraken](https://www.gitkraken.com) is a free, powerful Git(Hub) client
    that is my current favorite. It's especially exciting because it works on
    Windows, macOS, and Linux. This is great news, especially for long-suffering
    Linux users who have previously had very few options.  It also has a great 
    tutorial https://youtu.be/ub9GfRziCtU

  * GitHub offers a free Git(Hub) client, [GitHub Desktop](https://desktop.github.com/), 
    for Windows and macOS. Although we
    previously discouraged its use, GitHub's client has since gotten a thorough
    makeover that eliminates several of our concerns, so we're cautiously
    optimistic. GitHub Desktop is aimed at beginners who want the most useful
    features of Git front and center. The flipside is that it may not support
    some of the more advanced workflows exposed by the clients above. If you
    choose GitHub Desktop and it works well for you, we'd love to hear more in
    an issue, so we can continue to refine this recommendation.

