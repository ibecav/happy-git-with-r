# Why Git? Why GitHub? {#big-picture}

Why do we need hosted version control?

## Why Git?

[Git](http://git-scm.com) is a __version control system__. Its original purpose
was to help groups of developers work collaboratively on big software projects.
Git manages the evolution of a set of files -- called a __repository__ -- in a
sane, highly structured way. If you have no idea what I'm talking about, think
of it as the "Track Changes" features from Microsoft Word on steroids.

Git has been re-purposed by the data science community and many others. In
addition to using it for source code, we use it to manage the motley collection
of files that make up typical data analytics projects, which often consist of
data, figures, reports, and, yes, source code.  This book like object benefits
from Git.

A solo data analyst, working on a single computer, will benefit from adopting
version control. But not nearly enough to justify the __pain__ of installation
and workflow upheaval. There are much easier ways to get versioned back ups of
your files, if that's all you're worried about.

In my opinion, **for new users**, the pros of Git only outweigh the cons when
you factor in the overhead of communicating and collaborating with other people.
Who among us does not need to do that? Your life is much easier if this is baked
into your workflow, as opposed to being a separate process that you dread or
neglect.

## Why GitHub?

This is where hosting services like [GitHub](https://github.com) come in. They
provide a home for our project on the internet. If you have no idea what I'm
talking about, think of it as OneDrive but much, much better. The remote host
acts as a distribution channel or clearinghouse for our Git-managed project. It
allows the whole team to see stuff, sync up , and perhaps even make changes.
GitHub has a well-designed web-based interface.

Even for private solo projects, it's a good idea to push your work to a remote
location for peace of mind. Why? Because it's fairly easy to screw up your local
Git repository, especially when you're new at this. The good news is that often
only the Git infrastructure is borked up. Your files are just fine! Which makes
your Git pickle all the more frustrating. There are official Git solutions to
these problems, but they might require expertise and patience you can't access
at 3a.m. If you've recently pushed your work to GitHub, it's easy to grab a
fresh copy, patch things up with the changes that only exist locally, and get on
with your life.

Don't get too caught up on public versus private at this point. Just get started
and figure out how Git/GitHub is going to work for us!

## Is it going to hurt?

**Yes**.

You have to install Git, get local Git talking to GitHub, and make sure RStudio
can talk to local Git (and, therefore, GitHub). This is one-time or at worst a
once-per-computer pain.

For new or existing projects, you will:

  * Dedicate a directory (a.k.a "folder") to it by making it an RStudio 
    Project.
  * This will in turn automagically make it a Git repository.
  * Go about your usual business. But instead of only *saving* individual files,
    periodically you make a **commit**, which takes a multi-file snapshot of the
    entire project.
  * Have you ever versioned a file 
    [by adding your initials or the date](http://www.phdcomics.com/comics/archive.php?comicid=1531)? 
    That is effectively a **commit**, albeit only for a single file: it is a version
    that is significant to you and that you might want to inspect or revert to
    later.
  * Push commits to GitHub periodically. This is like sharing a document with
    colleagues on OneDrive or in Teams or sending it out as an email attachment.
    It signals you're ready to make your work visible to others and invite
    comment or edits.
  
This is a change to your normal, daily workflow. It feels weird at first but
quickly becomes second nature.

The rest of this site is dedicated to walking you through the necessary setup
and working with our Git project(s).

## What is the payoff?

**Involvement**: Even if you never plan on writing a line of code, you can
easily get the code **we all use** from GitHub. If you don't use Git, you can
still browse the project on GitHub like a normal website and even grab
everything by downloading a zip archive. If you care deeply about our final
project, or just have ideas on ways to make things better you can benefit from
GitHub. You can watch the repository to get notified of major activity. You can
request features or point out bugs and send them to others.

**Collaboration**: If you need to collaborate on or learn about code
development, then you should use Git. Use GitHub as your clearinghouse:
individuals work independently, then send work back to GitHub for reconciliation
and transmission to the rest of the team. The advantage of Git/GitHub is
highlighted by comparing these two ways of collaborating on a document:

  * **Edit, save, attach.** In this workflow, everyone has one (or more!) copies
    of the each document and they circulate via email attachment or Team's chat.
    Which one is "master"? Is it even possible to say? How do different versions
    relate to each other? How should versions be reconciled? If you want to see
    the current best version, how do you get it? All of this usually gets sorted
    out by social contract and a fairly manual process.
  * **Git/GitHub** In this workflow, there is only one master copy of the
    document and it lives in the cloud. Anyone can access the most recent
    version on demand. Anyone can edit or comment or propose a change and this
    is immediately available to everyone else. Anyone can see who's been editing
    the document and, if disaster strikes, can revert to a previous version. A
    great deal of ambiguity and annoying reconciliation work has been designed
    away.

## Who can do what?

We have a private repository and it is invisible to the world. Only we can grant
read, write (push), or admin access to others.

## Special features of GitHub

In addition to a well-designed user interface, GitHub offers two especially
important features:

  * **Issues.** It's a list of things ... bugs, feature requests, to dos,
    whatever.
    - Issues are tightly integrated with email and therefore allow you to
      copy/embed important conversations in the associated repo.
    - Issues can be assigned to people (e.g., to dos) and tagged ("bug" or
      "progress-report").
    - Issues are tightly integrated with commits and therefore allow you to
      record *that the changes in this commit solve that problem which was
      discussed in that issue*.
    - As a new user of GitHub, one of the most productive things you can do is
      to use GitHub issues to provide a clear bug report or feature request for
      our code.
 * **Pull requests.** Git allows a project to have multiple, independent
   branches of development, with the notion that some should eventually be
   merged back into the main development branch. These are technical Git terms
   but hopefully also make sense on their own. A pull request is a formal
   proposal that says: "Here are some changes I would like to make." It might be
   linked to a specific issue: "Related to #14." or "Fixes #56". GitHub
   facilitates and preserves the discussion of the proposal, holistically and
   line-by-line.

## What's special about using R with Git and GitHub?

  * Read about searching within GitHub [here](#search).
  * Specific workflows make it rewarding to share source code, rendered reports,
    and entire projects. Read more about [R Markdown](#rmd-test-drive), [R
    scripts](#r-test-drive), and [R-heavy projects](#repo-browsability).
  * Git- and GitHub-related features of the 
    [RStudio IDE](https://www.rstudio.com/products/rstudio-desktop/). This is covered
    throughout.
