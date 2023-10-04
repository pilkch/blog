---
author: Chris Pilkington
tags:
- c++
- gamedev
- linux
date: "2009-02-25T09:17:01Z"
id: 121
title: Yearly Update :)
---

[![Sudoku Work in Progress](/blog/wp-content/uploads/2009/02/sudoku090225.png)
Skysytem background, testing wireframe grid, TombRaider MD3 model, testing material boxes, particle systems, frames per second messages, pegs, shocks, all the necessary elements of a Sudoku game.

It’s been a while, I have like 20 draft entries in [WordPress](http://www.wordpress.org/) ranging from 1 paragraph comments up to 10 paragraph full on entries that still need that final once over and edit before going live. Actually it might be cool if there was (There probably is) a plugin so that people could optionally go to a page on my blog where they can see everything that hasn’t been published yet, like tagged with “draft” or something and comment on which ones I should flesh out and which ones I should ditch before they are even finished.

Anyway, so I have been working (Getting side tracked while working on) my [Sudoku](http://en.wikipedia.org/wiki/Sudoku) game.

Basically in Sudoku mode you get to select a number from the “palette” at the top and then click on all the places you want it on the board. The solver I have coded up can solve about 80% of Sudoku boards with “human solvable” methods and the remaining 20% can be solved with a combination of human solvable and then resorting to brute force for anything it can’t find. A valid board should not need brute forcing which means that I need to implement more rules for my human solving methods first. I should be doing something like this:

```cpp
if (solve_human_methods()) ... solved
else ...this board is invalid as it could not possibly be solved by a human without resorting to brute force
```

However I haven’t implemented all human methods of solving yet, only about 4 or 5 simple ones, actually probably less, there are about 2 or 3 real rules and then 4 or 5 extrapolated rules that are just combinations of the first ones.

Anyway, in First Person mode there is flying around (No clip mode) as well as moving Lara Croft around (Optionally other MD3 models) with sort of appropriate animations based on velocity (But not facing direction yet). One thing I have noticed is that half of the MD3 models I download have different file naming conventions, so at some stage I want to break out some Quake 3 action and see what file names it uses and use that as my standard.

Why all this other stuff in a Sudoku game? Whichever game I am working at the time becomes my test bed application for whatever I feel like implementing when bored. I really need to make a dedicated test bed that does nothing else but demonstrate stuff. I’ve also split my game engine into [Spitfire](http://breathe.git.sourceforge.net/git/gitweb.cgi?p=breathe/breathe;a=tree;f=include/spitfire;hb=HEAD) and [Breathe](http://breathe.git.sourceforge.net/git/gitweb.cgi?p=breathe/breathe;a=tree;f=include/breathe;hb=HEAD) portions, which splits the library into two halves, the generic tools for any application (string, math, xml, md5 hashes etc.) and game specific features ([OpenGL](http://www.opengl.org) rendering, audio, physics, MD3 animation, etc.) respectively.
