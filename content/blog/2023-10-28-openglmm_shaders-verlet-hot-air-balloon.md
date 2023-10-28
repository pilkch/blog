---
author: Chris Pilkington
date: "2023-10-28T10:26:27Z"
id: 547
tags:
- gamedev
- opengl
- openglmm
- openglmm_shaders
- verlet
title: openglmm_shaders Verlet Integration
---

I've been working on verlet integration lately in my OpenGL 3.3 library and libopenglmm_shaders test.  
[Source](https://github.com/pilkch/tests/)

Verlet Integration is a way of simulating some physical interactions. This is not a serious physics engine like ODE/Bullet/Box2D/etc. I'm sure verlet integration can be used for serious stuff, I've just used it as a way to get a basic fun physics simulation, focusing on speed and simple coding. There is a [famous paper on verlet integration](https://www.cs.cmu.edu/afs/cs/academic/class/15462-s13/www/lec_slides/Jakobsen.pdf) and many discussions about it online. The typical way that verlet physics is simulated in games is with particles which provide the basic shape of objects, and springs joining the particles together. The springs have a length that they try to maintain, and a stiffness. They can iteratively keep the particles a certain distance from each other. A rope segment is basically a spring with a maximum length, but no minimum length. A pin is a constraint on a particle to hold it in position. These primitives can then be used to simulate semi-rigid bodies and complex objects. Ragdolls, cloth, grass, tires, rope, hair, bridges, and even destruction can be simulated.

I've featured it in my last 3 videos. On a side note, youtube thinks my videos are Second Life and Minecraft.  

{{< youtube NcHnFuvqhxg >}}  
- Bull with verlet "bobble" head  
- Early verlet grass  
- Plus PBR rendering and a whole heap of other stuff  

{{< youtube LQHXeTFDeFs >}}  
- Verlet grass with player interaction

{{< youtube UTwsyOtwEsM >}}  
- Verlet hot air balloon

The hot air balloon is simulated with verlet integration. The basket and red balloon parts are simulated as boxes. Although the balloon is rendered as a much larger balloon, about 4 times larger than the simulated box, the physics is updated, then we work out the approximate position and orientation of the box, and render the balloon there instead. The 4 ropes connecting the basket and red balloon parts actually connect the physics particles, the rendered red balloon is a different diameter so the ropes don't quite line up. I forgot to hit the debug key to show the debug of the underlying physics box, sorry!

The basket and box are simulated with particles at each corner, linked by springs that try maintain a set length, pushing/pulling the corners into place. You can see the corners of the basket flexing slightly as the balloon goes up and down. All particles try to prevent collisions with the ground, so the basket and balloon can tip over, but not fall through the ground.

The ropes are all simulated as a line of particles joined by "rope" joints which are basically "one way" springs that only have a max length that they try to maintain. The rope gathering is not too bad, it is affected by gravity so it droops nicely, under normal forces it prevents the balloon flying off into the sky, but it does look a bit janky when it is meant to not under tension. There is no particle to particle collision, and there is no collision geometry on each face of the basket for example, so the rope just passes right through.

The particles in the boxes and ropes are affected by gravity. Lift is applied to the physics box for the balloon, so the top pulls itself up, and the ropes pull the basket up below it. In the video I am increasing and decreasing the lift so that the balloon rises and falls.


I've also got some verlet flags in there too which are "clothish" and blown around by the wind, but I don't seem to have captured them in the videos. I'll try to remember to add that to the next video.
