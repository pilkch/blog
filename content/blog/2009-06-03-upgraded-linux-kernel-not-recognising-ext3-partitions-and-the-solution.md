---
author: Chris Pilkington
date: "2009-06-03T00:31:14Z"
id: 83
tags:
- linux
- oh noes
title: Upgraded Linux Kernel not recognising ext3 partitions and the solution
---

```bash
Unable to access resume device (/dev/dm-1)
mount: error mounting /dev/root on /sysroot as ext3: No such file or directory
```

Being a Linux noob, I found [this solution](http://forums.fedoraforum.org/showthread.php?t=216396)

Create [mkinitrd.new](https://bugzilla.redhat.com/attachment.cgi?id=330620)

```bash
chmod +x mkinitrd.new
su
cd /boot
sudo ./mkinitrd.new -f initrd-2.6.27.24-170.2.68.fc10.x86_64.img 2.6.27.24-170.2.68.fc10.x86_64
```
