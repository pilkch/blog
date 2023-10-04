---
author: Chris Pilkington
date: "2011-04-21T00:26:27Z"
id: 265
tags:
- git
- tutorial
title: Version Control 2.0
---

GitHub is a pleasure to work with. In 10 years I created 5 or 6 projects on SourceForge, I’ve already created 3 new projects in less than a year on GitHub because they are just so easy to setup. An early design decision for SourceForge was to make deleting projects hard. The idea was that a project should never die, just “retire” until a new maintainer comes along. I don’t think I have users of my libraries or applications let alone prospective maintainers (Actually, I have had a few emails and bug reports for GetFree and it has had quite a few downloads, but that was when it was new and exciting). I wish I could change my projects’ statuses to “unmaintained”. After 1 or 2 years of being unmaintained, if it hasn’t been adopted by another user then after a warning email it should be automatically deleted. There are no orphaned projects on SourceForge, only projects that the owner lets stagnate.

Anyway, this post isn’t about SourceForge’s flaws, it is about GitHub. Half of GitHub’s success is due to using Git. There is a very handy application which works in tandem with git, called git-svn which makes migrating from svn painless. You can setup mappings from svn users to git users, clone an svn project into a git project with full history and for those that have to use legacy svn repositories, it can even commit back to svn. Once you get your application into GitHub though you will probably want to stick with git. This is where the fun begins.

You can fork other projects in seconds, work on your own branch for a bit (Fixing bugs, implementing new functionality, etc.) and then send a pull request to have the owner merge your changes back again (And merging has been fixed in git, unlike svn, it doesn’t make me groan any more). GitHub keeps a record of where a project originated and can generate nice graphs of where projects were forked and merged, as well as statistics about which languages were used, when each developer typically commits, as well as all the basics such as bug tracking, web view of the repository, and activity logs for each project and each user.

[Join](https://github.com/) [Me](https://github.com/pilkch/)
