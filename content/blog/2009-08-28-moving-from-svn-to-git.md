---
author: Chris Pilkington
date: "2009-08-28T09:00:21Z"
id: 171
tags:
- tutorial
- linux
title: Moving from SVN to GIT
---

So I have a [few projects](http://sourceforge.net/users/pilkch) on [SourceForge](http://www.sourceforge.net/), but they’re all hosted via [SVN](http://en.wikipedia.org/wiki/Subversion_%28software%29). With [all](http://en.wikipedia.org/wiki/Mercurial_%28software%29) [this](http://en.wikipedia.org/wiki/Bazaar_%28software%29) [distributed](http://en.wikipedia.org/wiki/Git_%28software%29) version control going on I thought I would like to get in on the action. I thought about moving to github, but what happens in 5 or 10 years when I want to move on to another [revision control software](http://en.wikipedia.org/wiki/Comparison_of_revision_control_software)? The name has a limited life expectancy. Anyway so I wanted to switch so I researched alot, [this](http://www.simplisticcomplexity.com/2008/03/05/cleanly-migrate-your-subversion-repository-to-a-git-repository/) is the best information I found and this blog entry is basically a rehash specific to SourceForge (Because I didn’t find any good SourceForge specific information).

**Note: For this tutorial you will want to change all occurrences of USERNAME to your user name for example “pilkch”, PROJECTNAME to your project name for example “breathe” and YOURFULLNAME to your full name for example “Chris Pilkington”.**

First of all we need to download git and git-svn:

```bash
sudo yum install git git-svn
```

Now we are going to create our repo directory for holding our repositories:

```bash
cd ~
mkdir repo
```

Create a users.txt file to map our subversion users to git users:

users.txt

```bash
USERNAME = YOURFULLNAME <USERNAME@PROJECTNAME.git.sourceforge.net>
```

As the other article says, we basically check out a svn directory as a git repository:

```bash
cd repo
mkdir PROJECTNAME_from_svn
cd PROJECTNAME_from_svn
git svn init http://PROJECTNAME.svn.sourceforge.net/svnroot/PROJECTNAME/PROJECTNAME --no-metadata
git config svn.authorsfile ../users.txt
git svn fetch
```

Check that worked (Just read the last few changes to make sure svn history is present, you can hit spacebar to scroll back a page of history or two just to make sure):

```bash
git log
```

From now on we can use git commands, first of all want to create a copy of the git-svn repository:

```bash
cd ..
git clone PROJECTNAME_from_svn PROJECTNAME
```

PROJECTNAME/ now contains our “clean” repository and PROJECTNAME\_from\_svn can be deleted if you like. We now just need to add and push our local repository to the remote location:

```bash
cd PROJECTNAME
git config user.name "YOURFULLNAME"
git config user.email "USERNAME@users.sourceforge.net"
git remote rm origin # This may not be necessary for you
git remote add origin ssh://USERNAME@PROJECTNAME.git.sourceforge.net/gitroot/PROJECTNAME/PROJECTNAME
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
git push origin master
```

Now to check that this is working you can browse to the git page of your SourceForge project and there should be data in your repository. And we can clone our repository back again to check that everything is working.

```bash
git clone ssh://USERNAME@PROJECTNAME.git.sourceforge.net/gitroot/PROJECTNAME/PROJECTNAME
```

You may also want to ignore certain types of files, place a file called .gitignore in the root directory of your project and fill it with the patterns you want ignored:

.gitignore

```text
.DS_Store
.svn
._*
~$*
.*.swp
Thumbs.db
```

Now when we want to update we can do:

```bash
git commit -a -m "This is my commit message." # All changes to the local repository need to be committed before we try merging new changes
git pull # Grab any changes from the main repository
```

Committing is slightly different:

```bash
git add .gitignore # For example we might want to add our new .gitignore file
git commit -a -m "This is my commit message." # Note: Your commit has now only been staged, it is not in the main repository yet
git push # Now it is pushed into the main repository
```

The last step is to remove your svn repository which for SourceForge is as simple as unchecking a checkbox on the Admin-&gt;Features page.
