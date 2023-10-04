---
author: Chris Pilkington
date: "2021-01-11T22:06:07Z"
id: 499
tags:
- games
- android
- bedrock
- geysermc
- ios
- java
- minecraft
- xbox 360
- xbox one
title: Minecraft Server Cross Platform Compatibility
---

![Minecraft cross platform compatibility chart](/blog/wp-content/uploads/2021/01/minecraft-server-compatibility.svg)  
Note: The legacy consoles essentially cannot connect outside their own platform

### References

- [https://www.reddit.com/r/Minecraft/comments/crlnzp/what\_versions\_of\_minecraft\_are\_crosscompatible/](https://www.reddit.com/r/Minecraft/comments/crlnzp/what_versions_of_minecraft_are_crosscompatible/)
- <https://www.minecraft.net/en-us/store/minecraft-xbox-360>
- [https://minecraft.gamepedia.com/Xbox\_360\_Edition](https://minecraft.gamepedia.com/Xbox_360_Edition)
- <https://github.com/GeyserMC/Geyser>

With GeyserMC and the Java and Bedrock editions there seems to be quite good cross platform compatibility, but alas, I was hoping to connect Xbox 360 to a Java or Bedrock server which I do not think is possible.

#### Protocol

> "The programming language and game engine have little to do with incompatibilities; rather, it is because of differences in various data formats like IDs; for example, in the PC edition each type of wooden fence uses its own block ID*, while in PE they use data values so only one ID is used (the same as oak fences in PC). More significant differences may lie in things like mob AI and mechanics like combat and items that are missing (e.g. PE does not have shields and swords presumably still block).

> *FWIW, these were added by Jeb, not Notch – they are still making poor design decisions to this day, including things like using 16 block IDs for Shulker boxes instead of just 1 (they are already tile entities so they could have just added a color tag, as with beds), or using excessive encapsulation like using an object for x,y,z coordinates."  
<https://www.minecraftforum.net/forums/minecraft-java-edition/suggestions/2842427-could-minecraft-java-get-cross-play>

#### Pocket Edition Protocol

MCPE uses Raknet protocol

[https://wiki.vg/Raknet\_Protocol#Packets](https://wiki.vg/Raknet_Protocol#Packets)  
I've seen a string like this in tcpdumps of packets between an Android tablet and a Linux Bedrock server:
```bash
MCPE;Dedicated Server;390;1.14.60;0;10;13253860892328930865;Bedrock level;Survival;1;19132;19133;
```

#### Xbox 360 Version

Version: TU74

> "The gameplay was first released largely intact from Java Edition Beta 1.6.6"  
[https://minecraft.fandom.com/wiki/Minecraft:\_Xbox\_360\_Edition](https://minecraft.fandom.com/wiki/Minecraft:_Xbox_360_Edition)

I did some TCP dumps to see if the Xbox 360 was advertising its Minecraft server to the local network but didn’t notice anything.
