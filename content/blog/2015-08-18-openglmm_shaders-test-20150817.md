---
author: Chris Pilkington
date: "2015-08-18T00:54:48Z"
id: 434
tags:
- gamedev
- opengl
- openglmm
- openglmm_shaders
title: openglmm_shaders Test 20150817
---

Here is a video demo of my OpenGL 3.3 library libopenglmm.  
[Source](https://github.com/pilkch/tests/)

{{< youtube zrItSzA40WE >}}

Materials:  
- Lambert shading (Mirror’s Edge style)  
- Fog  
- Cube mapping  
- Multitexturing  
- Normal mapping  
- Car paint (Slighty broken, I think a texture look up is incorrect)  
- Glass mixed with dirty metal texture (Similar to an old rusty/broken mirror)  
- Cel shading  
- Smoke particle system with lambert lighting with 4 normals that very roughly approximate a sphere (I think something is wrong with the depth texture look up)

Post render effects:  
- Sepia  
- Teal and orange  
- Noir  
- Matrix  
- HDR (It is cheesy and over done, but you get the idea, it would normally be a lot more tame, either brought back or blending less of the HDR textures in at the end)  
- Colour blind simulation (3 modes are possible, only one is shown)
