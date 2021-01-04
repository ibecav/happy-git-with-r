# Useful Git patterns for real life {#workflows-intro}

Git patterns that come up frequently in real work:

  * Commit early and often. Push less often. [The Repeated Amend](#repeated-amend).
  * [Help, my push was rejected!](#push-rejected)
  * [Integrating remote and local work](#pull-tricky). Probably so you can push again.
  * Burn it all down.
  * Time travel:
    - ["I just need to see the past".](#time-travel-see-past) Browse and search on GitHub.
    - "I need to visit the past". Create a checkout a branch.
    - "I want to return to the past". `git revert`, `git reset`
    - "I had a great cookie last October". `git cherry pick`, `git checkout REF -- path`

Play well with others:

  * [Fork and clone](#fork-and-clone).
  * [Get upstream changes for a fork](#upstream-changes).
  * Disposable fork.
  * [Make your repo rewarding to browse on GitHub](#workflows-browsability).
  * [Explore and extend a pull request](#pr-extend)

## The Repeated Amend {#repeated-amend}

One of the principal joys of version control is the freedom to experiment
without fear. If you make a mess of things, you can always go back to a happier
version of your project. We describe several methods of such time travel in
*link to come*. But you must have a good commit to fall back to!

### Rock climbing analogy

<div class="figure">
  <blockquote>
Using a Git commit is like using anchors and other protection when climbing. If
you're crossing a dangerous rock face you want to make sure you've used
protection to catch you if you fall. Commits play a similar role: if you make a
mistake, you can't fall past the previous commit. Coding without commits is like
free-climbing: you can travel much faster in the short-term, but in the
long-term the chances of catastrophic failure are high! Like rock climbing
protection, you want to be judicious in your use of commits. Committing too
frequently will slow your progress; use more commits when you're in uncertain or
dangerous territory. Commits are also helpful to others, because they show your
journey, not just the destination.
  </blockquote>
  <p class="caption">
  <a href="http://r-pkgs.had.co.nz/git.html#git-commit">R Packages, Hadley Wickham</a> (@r-pkgs-book)</p>
</div>

Let's talk about this:

> use more commits when you're in uncertain or dangerous territory

When I'm doing something tricky, I often proceed towards my goal in small
increments, checking that everything still works along the way. Yes it works?
Make a commit. This is my new worst case scenario. Keep going.

What's not to love?

This can lead to an awful lot of tiny commits. This is absolutely fine and
nothing to be ashamed of. But one day you may start to care about the utility
and aesthetics of your Git history.

The Repeated Amend is a pattern where, instead of cluttering your history with
lots of tiny commits, you build up a "good" commit gradually, by amending.

*Yes, there are other ways to do this, e.g. via squashing and interactive
rebase, but I think amending is the best way to get started.*

### Workflow sketch

#### Initial condition

Start with your project in a functional state:

  * R package? Run your tests or `R CMD check`.
  * Data analysis? Re-run your script or re-render your `.Rmd` with the new chunk.
  * Website or book? Make sure the project still compiles.
  * You get the idea.

Make sure your "working tree is clean" and you are synced up with your GitHub
remote. `git status` should show something like:

``` bash
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

#### Get to work

Imagine we start at commit C, with previous commit B and, before that, A:

``` bash
... -- A -- B -- C
```

Make a small step towards your goal. Re-check that your project "works".

Stage those changes and make a commit with the message "WIP", meaning "work in
progress". Do this in RStudio or in the shell (Appendix \@ref(shell)):

``` bash
git commit -m "WIP"
```

The message can be anything, but "WIP" is a common convention. If you use it,
whenever you return to a project where the most recent commit message is "WIP",
you'll know that you were probably in the middle of something. If you push a
"WIP" commit, on purpose or by mistake, it signals to other people that more
commits might be coming.

Your history now looks like this:

``` bash
A -- B -- C -- WIP*
```

**Don't push!** The `*` above signifies a commit that exists only in your local
repo, not (yet) on GitHub.

Do a bit more work. Re-check that your project is still in a functional state.
Commit again but this time **amend** your previous commit. RStudio offers a
check box for "Amend previous commit" or in the shell:

``` bash
git commit --amend --no-edit
```

The `--no-edit` part retains the current commit message of "WIP".

**Don't push!**  Your history now looks like this:

``` bash
A -- B -- C -- WIP*
```

but the changes associated with the `WIP*` commit now represent your last two
commits, i.e. all the accumulated changes since state C.

Keep going like this.

Let's say you've finally achieved your goal. One last time, check that your
project is functional and in a state you're willing to share with others.

Commit, amending again, but with a real commit message this time. Think of this
as commit D. Push. Do this in RStudio or the shell:

``` bash
git commit --amend -m "Implement awesome feature; closes #43"
git push
```

Your history -- and that on GitHub -- look like this:

``` bash
A -- B -- C -- D
```

As far as the world knows, you implemented the feature in one fell swoop. But
you got to work on the task incrementally, with the peace of mind that you could
never truly break things.

### What if I need to fall back?

Imagine you're in the middle of a Repeated Amend workflow:

``` bash
A -- B -- C -- WIP*
```

and you make some changes that break your project, e.g. tests start failing.
These bad changes are not yet committed, but they are saved. You want to fall
back to the last good state, represented by `WIP*`.

In Git lingo, you want to do a **hard reset** to the `WIP*` state. With the
command line:

``` bash
git reset --hard
```

which is implicitly the same as

``` bash
git reset --hard HEAD
```

which says: "reset my files to their state at the most recent commit".

This is also possible in RStudio. Click on "Diff" or "Commit". Select a file
with changes you do not want. Use "Discard All" to discard all changes in that
file. Use "Discard chunk" to discard changes in that file, selectively. Repeat
this procedure for each affected file until you are back to an acceptable state.
Carry on.

If you committed a bad state, go to *link to come* for more reset scenarios.

### Why don't we push intermediate progress?

Amending a commit is an example of what's called "rewriting Git history".

Rewriting history that has already been pushed to GitHub -- and therefore
potentially pulled by someone else -- is a controversial practice. Like most
controversial practices, lots of people still indulge in it, as do I.

But there is the very real possibility that you create headaches for yourself
and others, so in Happy Git we must recommend that you abstain. Once you've
pushed something, consider it written in stone and move on.

### Um, what if I did push?

I told you not to!

But OK here we are.

Let's imagine you pushed this state to GitHub by mistake:

``` bash
A -- B -- C -- WIP (85bf30a)
```

and proceeded to `git commit --amend` again locally, leading to this state:

``` bash
A -- B -- C -- WIP* (6e884e6)
```

I'm deliberately showing two histories that sort of look the same, in terms of
commit messages. But the last SHA reveals they are actually different.

You are in a pickle now, as you can't do a simple push or pull. A push will be
rejected and a pull will probably lead to a merge that you don't want.

You have two choices:

  * Hard reset your local repo to `C` (`git reset --hard HEAD^`) and pull from
    GitHub. Do this if you have collaborators who may have pulled that state.
    GitHub and local history now show this:
    ``` bash
    A -- B -- C -- WIP (85bf30a)
    ```
  * Force push to GitHub (`git push --force`). Do this if you have no
    collaborators or you have reason to believe they have not pulled. GitHub and
    local history now show this:
    ``` bash
    A -- B -- C -- WIP* (6e884e6)
    ```

Now you are synced up again.

## Dealing with push rejection {#push-rejected}

Problem: You want to push changes to GitHub, but you are rejected like so:

``` bash
$ git push
To https://github.com/YOU/REPO.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'https://github.com/YOU/REPO.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

This means that your local Git history and that on the GitHub remote are not
compatible, i.e. they have diverged.

I suggest that you use `git status`, your [Git client](#git-client ), or visit
your GitHub remote in the browser to get more information about the situation,
i.e. to get a sense of this work that you do not have.

In the abstract, this is the state on GitHub:

```
A -- B -- C (on GitHub)
```

And this is your local state:

```
A -- B -- D (what you have)
```

You can't cause some sort of merge to happen to the GitHub copy when you push. 

Instead, you've got pull the commit `C` and somehow integrate it into your
`D`-containing history. Then you will be able to push again.

This is covered in the workflow [Pull, but you have local work](#pull-tricky).

But before you behold the full horror of that, this is a great time to reflect
on what we can learn from this situation.

### She who pushes first wins!

You may have noticed that you -- the author of `D` -- are faffing around with
Git more than the person who committed and pushed `C`, i.e. your collaborator.

There is a lesson to be learned here!

If you had pushed `D` first, you'd be relaxing and they'd be figuring out how to
integrate `C` into their history in order to push. So push your work often.
Don't go dark and work "offline" for long stretches of time.

Obviously, you should push work to `master` because it's "ready" to share (or at
least "ready enough"), not to avoid Git merges.

There is a truly legitimate point here: It is better for the overall health of a
project to be committing, pushing, and integrating more often, not less. This
does not eliminate the need to integrate different lines of work, but it makes
each integration smaller, less burdensome, and less prone to error.

### Stay in touch

Another take away is this: the sooner you know about `C`, the better. Pull (or
fetch) often.

Let's think about your commit `D`. Maybe it was built up over a couple of days
via the [Repeated Amend pattern](#repeated-amend). Maybe `C` was sitting there
on GitHub the whole time or appeared very early in your process.

Consider that it might be easier to integrate `C` into your work `D` sooner
rather than later. Sometimes this is not true, but more often it is.

In general, it pays off to be proactively aware of what others are doing (e.g.
to pull or fetch often) than to always be in reactive mode, learning about your
collaborator's work only when your push is rejected.

### Use branches

Finally, your early experiences collaborating with others and yourself in
`master` will give you a visceral understanding of why most Git users eventually
start to use [branches](#git-branches).

Branches afford explicit workflows for integrating different lines of work on
your own terms. This is much nicer than trying to do a tricky merge or rebase in
a frustrated panic, because you need to push your work to GitHub at the end of
the day.


