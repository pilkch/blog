---
author: Chris Pilkington
date: "2011-12-15T07:46:15Z"
id: 220
tags:
- linux
- photography
- fedora
- pef
- png
- tutorial
title: Converting Pentax PEF Files to PNG
---

[Ufraw](http://en.wikipedia.org/wiki/Ufraw) is a fantastic utility to convert raw camera formats. You can install it via (And you may as well get the plugin for [gimp](http://en.wikipedia.org/wiki/GIMP) while you are at it):

```bash
sudo yum install ufraw ufraw-gimp
OR
sudo apt-get install ufraw gimp-ufraw
```

There is a great tutorial on using ufraw from a bash script [here](http://jcornuz.wordpress.com/2007/10/10/workflow-3-quick-raw-converting-batch/), my only recommendation is converting to [PNG](http://en.wikipedia.org/wiki/Portable_Network_Graphics) but it is entirely up to personal preference.

PNG version:  
pef2png.sh

```bash
#!/bin/bash

if [ ! -d ./processed_images ]; then mkdir ./processed_images; fi;

# processes raw files
for f in *.pef;
do
  echo "Processing $f"
  ufraw-batch \
    --wb=camera \
    --exposure=auto \
    --out-type=png \
    --compression=96 \
    --out-path=./processed_images \
    $f
done

cd ./processed_images

# change the image names
for i in *.png;
do
  mv "$i" "${i/.png}"_r.png;
done
for i in *.png;
do
  mv "$i" "${i/imgp/_igp}";
done
```

Usage:

```bash
# Convert all pef files in the current directory to png
./pef2png.sh
```
