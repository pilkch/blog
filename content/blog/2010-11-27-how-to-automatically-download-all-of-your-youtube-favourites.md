---
author: Chris Pilkington
date: "2010-11-27T18:04:17Z"
id: 254
tags:
- bash
- tutorial
title: How To Automatically Download All of Your YouTube Favourites
---

FireFox add-ons such as [1-Click YouTube Video Download](http://www.clickyoutubedownload.com/) are good but one must visit every video and manually save it. I have a lot of favourites and I wanted to back them up with as little effort as possible. Here is how.

You will need [youtube-dl](http://rg3.github.com/youtube-dl/download.html). It is available via yum/apt-get however the version provided may be quite old (In Fedora 14 it did not support -playlist-start and -playlist-end).

Create a new playlist and add all the videos from your favourites (Note: A playlist can only contain 200 videos if you have more than than this you will have to make multiple playlists and repeat this process for each one).

Click on "Play All". Copy the URL from the address bar for the first video when it tries to play (You only need this bit: "http:\/\/www.youtube.com\/view\_play\_list?p=AE198A14013A3005").

Now tell youtube-dl to download the videos in the playlist:

```bash
python ./youtube-dl.py --title --ignore-errors --playlist-start=1 --playlist-end=200 http://www.youtube.com/view_play_list?p=AE198A14013A3005
```

If you had more than 200 videos repeat this process for the ones that didn’t fit in the playlist.  
This should work for other people’s playlists too.  
You might want to make a note of the latest video in your favourites so that the next time you can backup only the new videos.  
This process still requires some user interaction, if you find an even easier way where I can just say, “This is my user name, make it happen”, I’d love to know about it.
