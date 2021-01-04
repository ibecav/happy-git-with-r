# Installation -- Half the battle {#install-intro}

Getting all the necessary software installed, configured, and playing nicely
together is honestly half the battle when first adopting Git. Brace yourself for
some pain. The upside is that you can give yourself a pat on the back once you
get through this. And you __WILL__ get through this.

If you have some new problem and, especially, the corresponding solution, 
[we'd love to hear from you!](https://github.com/ibecav/happy-git-with-r). 
Our installation instructions are brand new, bear with us it's the hardest
part.

## Register an account with GitHub. It's free!

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

## Install or upgrade R and RStudio



1. Install a pre-compiled binary of R for your OS from here:  
    <https://cloud.r-project.org>  
    Already have R installed? **Hold on: This is a great time to make sure your R installation is current.** Check your current version like so:
    
    ```r
    R.version.string
    #> [1] "R version 4.0.3 (2020-10-10)"
    ```
1. Install RStudio Desktop.  
   Already have RStudio? **Hold on: This is a great time to upgrade to the latest version.** Download it here:  
    <https://www.rstudio.com/products/rstudio/download/>
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
