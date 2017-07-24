# Contributing to Dotfiles

:+1::tada: First off, thanks for taking the time to contribute! :tada::+1:

## Introduction

It's your presence in the community that makes this such a wonderful tool.

Please take a few moments to review this document to make the contribution
process easy and effective for everyone involved.

Following these guidelines helps to communicate that you respect the time of the
developers managing and developing this open source project. In return, they
should reciprocate that respect in addressing your issue, assessing changes, and
helping you finalize your pull requests.

As with all parts of this project, contributing to Dotfiles is governed by the [Code
of Conduct](/CODE_OF_CONDUCT.md).

#### Table of Contents

[Introduction](#introduction)

 * [I just have a question!](#question)
 * [Desired Contributions](#desired-contributions)
 * [UnDesired Contributions](#undesired-contributions)

[First Contribution](#first-contribution)

[Getting Started](#getting-started)

 * [New Features](#adding-new-features)
 * [Pull Requests](#submitting-a-pr)
 * [Squashing Bugs](#bugfixes)
 * [Testing](#testing)

[Reporting Bugs](#report-bugs)

 * [Security Issues?](#security)
 * [Other Bug Reports](#bug-reports)

[Feature Requests](#feature-requests)

 * [Suggesting a New Feature](#suggesting-a-feature)

[Code Review](#code-review)

[Community](#community)

[Style](#style)

 * [Code](#code)
 * [Git Commit Messages](#git-commits)
 * [GitHub Labels](#labels)

[Thank You!](#thanks)

### Question!

Please don't use the Issue tracker for support questions! Use
[gitter](https://gitter.im/benknoble-Dotfiles) instead. StackOverflow and
Vi(m).StackExchange are good places to ask general questions about Homebrew, Vim
(and it's plugins), Bash, and other coding goodies.

### Desired Contributions

Contributions to Dotfiles tend to be relatively open: improving documentation
(both in and out of code), fixing bugs, and even adding new features are all
desired! So too are blogging about the project, submitting bug reports and
feature request, and *discussing* the project on GitHub or elsewhere. Don't
hesitate to get involved!

### UNDesired Contributions

Please don't use the Issue tracker for support questions! Use
[gitter](https://gitter.im/benknoble-Dotfiles) instead. StackOverflow and
Vi(m).StackExchange are good places to ask general questions about Homebrew, Vim
(and it's plugins), Bash, and other coding goodies.

Think carefully about the code you want to add:

 * Is it a *massive* chunk of Vim script that adds whole new features to Vim,
   going beyond just customizing small pieces?
   * Consider writing a plugin! (Maybe it'll get added!)
 * Does it go beyond the readability of a simple shell script and into project
   or even application territory?
   * Consider starting your own open source project! (Maybe it'll get added!)
 * Is it an application, script, executable, &c., already easily to install via
   Brew (i.e., is it a formula)?
   * Add to the Brewfile! (Requires Version 1.1, and Issue #32)
 * Does it overwrite settings already discussed/set by one program?
 * Does it change or break the way a current feature works?
   * Discuss it in an issue first!

## First Contribution

Confused about where to start? Browse the code and the issues. See if one looks
simple to add, or if you have ideas about where it might go. Ask questions!
Someone can point you in the direction to get started adding to the project.

 * Working on PRs? Check [this](http://makeapullrequest.com/) out.
 * First timer? Don't worry. [We were all there.](http://www.firsttimersonly.com/)
 * Still wondering about Open Source Projects? [GitHub's got you
   covered.](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

At this point, you're ready to make your changes! Feel free to ask for help;
everyone is a beginner at first. :smile_cat:

## Getting Started

The Dotfiles source is structure in a particular way, with groups of related
files put together as much as possible. Read the code and the way it's setup, or
even better install and use them--get familiar with how things work, where
they're located, and what is easily changeable.

Ready to contribute? Ideas about a bugfix, feature request, &c.? Here's what you
need to know:

 * No CLA or any other legal stuff required. This is for simplicity. If you want
   to contribute something you want to maintain full ownership of, create your
   own Open Source project and recommend it to me. (Or fork the project. But you
   probably already did that, didn't you?)
 * Testing is not automated or easy, currently, but PLEASE do it as much as
   possible! It's easier to fix damage before merging than after.
 * Everything you need is right here on GitHub.

### Adding New Features

1. Make sure the feature has an open feature request via the Issue tracker.
2. Fork the project, and begin working on a topic branch.
3. When ready, submit a PR.

### Submitting a PR

1. Make sure the PR has an open issue. PRs without related Issues will be
   (kindly) closed. They can be reopened once the contribution has been
   discussed in an Issue and referenced.
2. Test test test! See the section on [Testing](#testing) for more detail.
3. Fill out the PR template, be available for feedback, and stay involved!

### Bugfixes

Because we have no legal process, submitting simple and large changes that you
don't wish to retain ownership of are handled the same way. That means that, for
bugfixes, spelling mistakes, &c., you follow the same steps in [Adding New
Features](#adding-new-features) and [Submitting a PR](#submitting-a-pr).

### Testing

Because we don't have a powerful testing system set up, the best way for you to
test is on your local machine. Include any testing you've done in your PR, that
way we know how it works and how we can test it.

Ideas:

 * Test interaction with other Vim plugins, bash scripts, &c.
 * See what happens if you are on a version of the repo *before* this change,
   and update to it--does anything break?
   * You can simulate this by merging the feature into master with `--no-ff`,
     going back a few commits, and try merging up to master again. If that
     works, reset master
 * See what happens on a fresh install with your feature
   * Remove your local copy, clone your fork (you did fork, right?) from the
     feature branch, and install. Did anything break?

If you have the resources, keeping a separate full user account for this might
make sense.

## Report Bugs

### Security

If you find a security vulnerability, do NOT open an issue. Email
ben.knoble@gmail.com instead. In order to determine whether you are dealing with
a security issue, ask yourself these two questions:

 * Can I access something that's not mine, or something I shouldn't have access
   to?
 * Can I disable something for other people?

If the answer to either of those two questions are "yes", then you're probably
dealing with a security issue. Note that even if you answer "no" to both
questions, you may still be dealing with a security issue, so if you're unsure,
just email ben.knoble@gmail.com.

### Bug Reports

Check for duplicates by searching the repo!

Use the Issues tracker on GitHub located
[here](https://github.com/benknoble/Dotfiles/issues). Make sure you fill out the
template provided--poorly formatted issues cause more stress and take longer to
deal with. If you fill out the template and provide all the relevant
information, you've done a good job.

## Feature Requests

Keep two things in mind: Dotfiles is not a Vim plugin or application (yet...).
What *is* it? A collection of configuration files for Bash and Vim, as well as
Git, and a repo to make setting up a new machine (or sharing a setup) easy. That
last part covers the list of Brew formulae and the install/setup scripts.
Consider whether your feature fits into that philosophy. If you're not sure,
ask!

### Suggesting a Feature

Check for duplicates by searching the repo!

Open an [Issue](https://github.com/benknoble/Dotfiles/issues). Be as descriptive
as you can with the feature, and scope it. Is it a large change, or a small
tweak to behavior?

Next, be ready for some discussion. Project maintainers will likely have
questions, and they might even debate. Remember, it is up to *you* to convince
us that this feature is worth it's time.

Hopefully, the feature request will get approved and you can start work on it.
If not, it might need further refinement or discussion. Ultimately, if it is
determined that such a feature goes against the philosophy of Dotfiles, it will
be closed.

## Code Review

Once a PR has been submitted, project maintainers will review it for style and
correctness. Any documentation on this provided in the PR will go a long way. If
the maintainers accept the proposed changes, your PR will be merged.

If not, they will request changes and continue to collaborate with you.

## Community

Chat with us on [gitter](https://gitter.im/benknoble-Dotfiles)!

## Style

### Code

Try to follow the conventions established by pre-existing code. Most indents are
4 spaces (except Vim: 2). Document heavily using comments.

### Git Commits

 * Header (first line) no longer than 78 chars
 * Use present imperative tense ("Add feature" not "Adds feature" or "Added
   feature")
 * Reference issues or PRs liberally after the first line BUT
   * If there's room, consider using "[Refs #x,#y] Header text"
 * For anything not trivial, include a detailed description of what changed,
   why, &c.
 * Read
   [this](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).
   Seriously. It's important.

### Labels

Dotfiles uses a number of Issue/PR labels to help keep track of things. They are
as follows:

**Status**

```
bug:                      file a bug report

documentation:            document something, or indicate that it's missing

feature-request:          discuss a feature request
```

**Topics**

These are those blue tags (color #1d76db, if you're interested). They simply
indicate that a feature or bug is part of a topic like bash, vim, or git and
should likely be developed on that topic branch.

**Meta**

```
duplicate:                covered somewhere else

github:                   related to github (templates, wikis, &c.)

help-wanted:              not going to be reached immediately, good point for
contributors to jump in

invalid:                  against core philosophy, or simply unrelated

question:                 this is a question and doesn't belong here

wontfix:                  the bug/feature is by design and won't be changed
```

## Thanks!

Thank you for deciding to contribute to Dotfiles! Your support of this community
is appreciated.

Should your contribution prove to be merged in, your name and github info, along with any
relevant changes, fixes, and work, will be added to
[docs/humans.txt](/docs/humans.txt). Make my life easier consider including that
in your PR.

Thanks, David Knoble, Dotfiles creator.
