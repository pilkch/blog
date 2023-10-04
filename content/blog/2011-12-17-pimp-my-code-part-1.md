---
author: Chris Pilkington
date: "2011-12-17T09:41:26Z"
id: 323
tags:
- pimp my code
- c++
- dev
title: Pimp My Code Part 1
---

[![Xhibit](/blog/wp-content/uploads/2011/12/20590346.jpg "Xhibit")](http://en.wikipedia.org/wiki/Pimp_My_Ride)

```cpp
inline bool IsSpecial(const char* szValue)
{
 // Returns true if this is a special value
 if (stricmp(szValue, "MySpecialValue") == 0) {
   return true;
 }

 return false;
}
```

I see this sort of thing all the time. For boolean functions that call boolean functions the if and return statements are usually superflous, we can use the return value of `(stricmp(szValue, “MySpecialValue”) == 0)` itself:

```cpp
// Returns true if this is a special value
inline bool IsSpecial(const char* szValue)
{
 return (stricmp(szValue, "MySpecialValue") == 0);
}
```

If it were up to me I would also use a string class and keep as much of the code as possible in the string “realm” (This makes the code a lot simpler and easier to read):

```cpp
// Returns true if this is a special value
inline bool IsSpecial(const string& sValue)
{
 return (sValue == "MySpecialValue");
}
```
