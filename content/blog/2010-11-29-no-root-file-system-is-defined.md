---
author: Chris Pilkington
date: "2010-11-29T09:55:36Z"
id: 257
tags:
- linux
- mythbuntu
- tutorial
- ubuntu
- dmraid
title: No root file system is defined
---

On the weekend I was installing the new version of [Mythbuntu](http://www.mythbuntu.org) (More interesting screenshots [here](http://www.mythtv.org/wiki/Screenshots)) and I had a weird error, “No root file system is defined”. At first I thought it must have been something to do with failing to recognise the existing partitions or possibly they were corrupt. “fdisk -l” worked, returning sda, sda1-sda4, which was correct however “mount” would always fail. It turned out that it was just our old friend [dmraid](/blog/2009/11/16/cannot-open-devsda1-device-or-resource-busy/) was breaking in new and unexpected ways.

Here is how I worked around it:
- Boot into live CD mode  
- Remove dmraid via Package Manager  
- Run Install Mythbuntu from the desktop shortcut

On multiple distributions and motherboards I consistently have problems with dmraid not finding/incorrectly identifying partitions/drives. I’m not the only one with these problems. I’m sure I am having these problems because I have raid hardware but am not using raid. Surely raid is an advanced enough feature that people *with* raid should be expected to know to install/add it? Perhaps the install could be attempted without raid support and the installer can say “Do you use raid?” or “Are these devices correct?” and at this point the installation restarts/redetects with dmraid enabled.
