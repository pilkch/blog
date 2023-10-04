---
author: Chris Pilkington
date: "2012-03-17T17:59:12Z"
id: 340
tags:
- pimp my code
- c++
- dev
title: Pimp My Code Part 2
---

[![Xhibit](/blog/wp-content/uploads/2012/03/20498288.jpg "Xhibit")](http://en.wikipedia.org/wiki/Pimp_My_Ride)

```cpp
char szPassword[255];
GenerateRandomPassword(szPassword, 16);
char szText[255];
sprintf(szText, "User: %s, ID: %d, Password: %s", szUser, int(userid++), szPassword);
```

Don't increment and use a variable on the same line. We know, you’re very tricky, you saved a line. You also made sure that beginners to C++ don’t know what the result will be. [Keep it simple stupid](https://en.wikipedia.org/wiki/KISS_principle). Create the simplest most readable code possible, it makes skimming over code and debugging code much easier. Fixed length arrays are very prone to buffer overruns, in this example szPassword is probably only 8 characters long after calling GenerateRandomPassword, but szUser could be any length and could definitely overrun 255 characters. The best way to mitigate this problem is to use a real string class such as `std::string`. We can also avoid using `sprintf` by using a type safe string writing class, `std::ostringstream`. Code using `std::ostringstream` is also slightly more human readable.

```cpp
userid++;
const std::string sPassword = GenerateRandomPassword(16);
std::ostringstream oText;
oText<<"User: "<<sUser<<", ID: "<<userid<<", Password: "<<sPassword;
const std::string sText = oText.str();
```

There, type safe, buffer overflow safe, future proof and slightly more readable, what's not to like?
