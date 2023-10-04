---
author: Chris Pilkington
date: "2009-06-04T00:14:28Z"
id: 140
tags:
- c++
- carbon
title: AHGotoPage Doesn't Work Argh!
---

It looks like [AHGotoPage](http://developer.apple.com/documentation/Carbon/Reference/Apple_Help/Reference/reference.html#//apple_ref/doc/uid/TP30000169-CH1g-F16335) is broken with Mac OS X 10.5.7 and later (It was also broken on 10.3.9 and earlier). Probably the easiest way around this for the moment is to open your help documentation in a web browser using [LSOpenCFURLRef](http://developer.apple.com/documentation/Carbon/Reference/LaunchServicesReference/Reference/reference.html#//apple_ref/c/func/LSOpenCFURLRef) instead. Hope this helps someone.
