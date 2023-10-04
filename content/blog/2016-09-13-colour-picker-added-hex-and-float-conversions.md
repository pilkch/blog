---
author: Chris Pilkington
tags:
- colour picker
- release
date: "2016-09-13T00:22:08Z"
id: 445
title: Colour Picker Added Hex and Float Conversions
---

![Colour picker hex and float entry.](/blog/wp-content/uploads/2016/09/colour-picker-hex-float.png)  
Colour picker hex and float entry.  

- The colour pickers I see never have conversions from RGB uint8\_t (255, 255, 255) to RGB float (1.0f, 1.0f, 1.0f), so I added it to mine.  
- HSL, HSV and YUV are also shown.  
- There is one [bug](https://github.com/pilkch/colourpicker/issues/2) when typing in a text colour if no single RGB component dominates then the colour palette look up fails, picking full white.  
- It’s in JavaScript, so as usual I am surprised by how quickly and relatively easy this was to implement. The biggest issues I had were not knowing how JavaScript converts strings to and from numbers.

[Try It](/projects/colourpicker/)  
[Source](https://github.com/pilkch/colourpicker)