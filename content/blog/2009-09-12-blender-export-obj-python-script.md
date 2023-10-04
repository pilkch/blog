---
author: Chris Pilkington
date: "2009-09-12T15:50:42Z"
id: 208
tags:
- gamedev
- blender
- obj
- python
title: Blender Export OBJ Python Script
---

First of all I’d like to state that I’m definitely a [Blender](http://www.blender.org/) n00b and I have never touched [Python](http://en.wikipedia.org/wiki/Python_%28programming_language%29) in my life.

![Baby steps, textured sphere loaded from an obj file](/blog/wp-content/uploads/2009/09/sphere.png "Sphere")
Baby steps, textured sphere loaded from an obj file

In my game engine I basically have this sort of layout:

```bash
sphere/
sphere.obj
sphere.mat
sphere.png
```

The .obj points to the .mat file which points to the .png file. So in Blender I would set the material name to “sphere” and ideally in the .obj file it would have a line like this, “usemtl sphere”, I would then get the sphere part and append “.mat” and load the material. I’m not sure if this is standard practice for Blender export scripts, but when exporting to the [obj](http://en.wikipedia.org/wiki/Obj) file [format](http://www.royriggs.com/obj.html), Blender adds the texture name to the material like so, “usemtl sphere\_sphere.png”, not cool. Anyway I thought, hey, the export script is written in Python, I wonder if I can fix this?

1. Locate the script. I read somewhere on the Blender site that scripts are in “/usr/share/blender/scripts/”. “export\_obj.py” is there, along side “export\_obj.pyc” and “export\_obj.pyo”.  
2. Edit the script:
```bash
gedit /usr/share/blender/scripts/export_obj.py
```
3. [The script](https://svn.blender.org/svnroot/bf-blender/trunk/blender/release/scripts/export_obj.py) is pretty well documented. I knew that I should search for “usemtl” as that is the only constant part of the string (Apart from “\_” which is much harder to search for). There are two in the file and we want the second one:
```python
mat_data= MTL_DICT.get(key)
	if not mat_data:
		# First add to global dict so we can export to mtl
		# Then write mtl
							
		# Make a new names from the mat and image name,
		# converting any spaces to underscores with fixName.

		# If none image dont bother adding it to the name
		if key[1] == None:
			mat_data = MTL_DICT[key] = ('%s'%fixName(key[0])), materialItems[f_mat], f_image
		else:
			mat_data = MTL_DICT[key] = ('%s_%s' % (fixName(key[0]), fixName(key[1]))), materialItems[f_mat], f_image
						
	if EXPORT_GROUP_BY_MAT:
		file.write('g %s_%s_%s\n' % (fixName(ob.name), fixName(ob.getData(1)), mat_data[0]) ) # can be mat_image or (null)

	file.write('usemtl %s\n' % mat_data[0]) # can be mat_image or (null)
```

mat\_data is a dictionary that is filled out and then written the file with “usemtl”. I replaced the offending line:
```python
mat_data = MTL_DICT[key] = ('%s_%s' % (fixName(key[0]), fixName(key[1]))), materialItems[f_mat], f_image
```

with this:
```python
mat_data = MTL_DICT[key] = ('%s'%fixName(key[0])), materialItems[f_mat], f_image
```

And then I realised that it was exactly the same as the line from the `if key[1] == None:` so you could probably remove the branch etc. if you want, I didn’t bother.

If you are exporting groups by material you may also need to edit the `if EXPORT_GROUP_BY_MAT:` branch also, again I didn’t bother. Anyway, save and you’re good to go.

4. I was worried that I would have to compile into bytecode or something for Blender to be able to use this, nope, either restart Blender or [hit “Update Menu”](http://wiki.blender.org/index.php/Extensions:Py/Scripts/Manual#Refreshing_the_List_of_Available_Scripts). Actually as it is an export script, I’m not sure you even need to do that, it probably gets reloaded when you [hit “File &gt; Export &gt; Wavefront (.obj)”](http://wiki.blender.org/index.php/Extensions:Py/Scripts/Manual/Export/wavefront_obj)?

This is the entirety of my Python knowledge, oh, I also know that whitespace is important or something, woo.

PS. I’m loving [git](http://git-scm.com/), I can’t believe I didn’t switch earlier!