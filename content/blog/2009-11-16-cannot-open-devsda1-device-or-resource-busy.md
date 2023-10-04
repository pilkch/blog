---
author: Chris Pilkington
date: "2009-11-16T22:23:19Z"
id: 223
tags:
- linux
- fedora
- tutorial
- dmraid
- grub
title: 'Cannot open /dev/sda1: Device or resource busy'
---

After an update (Upgrade?) a while ago I couldn’t boot into Fedora, it had the text mode bar graph and after getting to 100% it failed with this error message:

```bash
Cannot open /dev/sda1: Device or resource busy
```

It turned out that this was a dmraid problem. It would appear that something changed when updating and added or enabled dmraid. So I had to find a way to remove or disable it, the simplest solution I found that worked was disabling it via the arguments to the kernel in GRUB.

Edit menu.lst (Or grub.conf, my menu.lst is a symbolic link to grub.conf)

```bash
su
gedit /boot/grub/menu.lst
```

Find the entry that you are currently booting into and add “nodmraid” to the end of the “kernel” line:

```bash
	kernel /vmlinuz-2.6.31.6-166.fc12.x86_64 ro root=UUID=7129c2cc-03c5-4b7a-8472-bb9d314446b3  LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rhgb quiet nodmraid
```

I also like to add a timeout and remove hiding of the menu (This is in the general entry at the top of the file):

```bash
timeout=10
#hiddenmenu
```

My final menu.lst/grub.conf file looks like this:

```bash
default=0
timeout=10
splashimage=(hd0,1)/grub/splash.xpm.gz
#hiddenmenu
title Fedora (2.6.31.6-166.fc12.x86_64)
	root (hd0,1)
	kernel /vmlinuz-2.6.31.6-166.fc12.x86_64 ro root=UUID=7129c2cc-03c5-4b7a-8472-bb9d314446b3  LANG=en_US.UTF-8 SYSFONT=latarcyrheb-sun16 KEYBOARDTYPE=pc KEYTABLE=us rhgb quiet
	initrd /initramfs-2.6.31.6-166.fc12.x86_64.img
```
