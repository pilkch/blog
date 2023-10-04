---
author: Chris Pilkington
date: "2009-08-27T10:45:12Z"
id: 176
tags:
- tutorial
- linux
title: Symbols/Characters Returned by ls -l
---

```bash
$ ls -l
total 24
drwxrwxr-x   ...   thisisadirectory
-rw-rw-r--   ...   thisisafile
lrwxrwxrwx.  ...   thisisalink -> /media/data
```

We [know what the rwx fields are](http://www.freeos.com/articles/3127/) but what about d, - and l? Ok, those are pretty obvious too, [here](http://www.comptechdoc.org/os/linux/usersguide/linux_ugfilesp.html) is a list of the more obscure ones because I always forget.

**d** Directory.  
**l** Symbolic link.  
**-** Regular file.

**b** Block buffered device special file.  
**c** Character unbuffered device special file.  
**s** Socket link.  
**p** FIFO pipe.  
**.** indicates a file with an SELinux security context, but no other alternate access method.

**s** setuid – This is only found in the execute field.  

If there is a "-" in a particular location, there is no permission. This may be found in any field whether read, write, or execute field.

The file permissions bits include an execute permission bit for file owner, group and other. When the execute bit for the owner is set to "s" the set user ID bit is set.  
This causes any persons or processes that run the file to have access to system resources as though they are the owner of the file. When the execute bit for the group is set to "s",  
the set group ID bit is set and the user running the program is given access based on access permission for the group the file belongs to.
