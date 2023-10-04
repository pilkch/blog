---
author: Chris Pilkington
tags:
- linux
date: "2009-04-09T21:18:51Z"
id: 132
title: '"Error: glXCreateContext failed" After Updating Video Drivers'
---

After updating video drivers I couldn’t run 3d applications, for example glxinfo:
```bash
Error: glXCreateContext failed
```

The following needs to be present in the xorg.conf file:

```bash
Section "Files"
ModulePath "/usr/lib64/xorg/modules/extensions/nvidia"
ModulePath "/usr/lib64/xorg/modules"
EndSection
```