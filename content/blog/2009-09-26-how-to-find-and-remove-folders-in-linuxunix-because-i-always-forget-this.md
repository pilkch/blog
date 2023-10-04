---
author: Chris Pilkington
date: "2009-09-26T09:33:04Z"
id: 216
tags:
- linux
- tutorial
title: How to Find and Remove Folders Recursively in Linux/Unix Because I Always Forget This
---

```bash
# Recursively search for folders called .svn and delete them (Even if not empty)
find . -name .svn -type d -print | xargs rm -rf

# Recursively search for files called *~ (gedit creates these for temporarily saving to) and delete them
find . -name \*~ -print | xargs rm -rf

# Recursively search for files called *.h or *.cpp and print them
find -name '*.h' -o -name '*.cpp' -print
```
