---
author: Chris Pilkington
date: "2011-12-22T22:06:07Z"
id: 328
tags:
- pimp my code
- c++
- dev
title: Pimp My Code Part 1 Redux
---

[![Xhibit](/blog/wp-content/uploads/2011/12/20498215.jpg "Xhibit")](http://en.wikipedia.org/wiki/Pimp_My_Ride)

Not exactly a redux, but very similar to [last time](/blog/2011/12/17/pimp-my-code-part-1/ "Pimp My Code Part 1"):

```cpp
bIsNotEmpty = false;
if (vNests.GetSize() != 0) {
  if (vNests[0]->vEggs.GetSize() != 0) bIsNotEmpty = true;
}
```

First of all we don’t actually care about the size, we just care that we have (Or don’t have) a nest with eggs in it. Depending on the container GetSize may or may not be a variable look up. IsEmpty is always a variable lookup:

```cpp
bIsNotEmpty = false;
if (!vNests.IsEmpty()) {
  if (!vNests[0]->vEggs.IsEmpty()) bIsNotEmpty = true;
}
```

We can combine this into a single line:

```cpp
bIsNotEmpty = (!vNests.IsEmpty() && !vNests[0]->vEggs.IsEmpty());
```

I would use more descriptive variable naming change my logic to use bIsEmpty/!bIsEmpty. Using bIsNot variables is often confusing and leads to harder to read code:

```cpp
bIsNestWithEggs = (!vNests.IsEmpty() && !vNests[0]->vEggs.IsEmpty());
bIsEmpty = !bIsNestWithEggs;
// Use bIsEmpty and !bIsEmpty from now on
```