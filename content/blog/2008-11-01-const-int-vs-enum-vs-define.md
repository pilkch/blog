---
author: Chris Pilkington
tags:
- c++
date: "2008-11-01T14:02:56Z"
id: 12
title: 'const int vs. enum vs. define'
---

Example A:

```cpp
int GetValue0()
{
  return 10;
}

int GetValue1()
{
  return 10 + 10;
}

int GetValue2()
{
  return 10 * 10;
}
```

So if all of the values 10 represent a common [magic number](http://en.wikipedia.org/wiki/Magic_number_(programming)) then you are going to want to extract that value to one location instead of the 5 that it is in at the moment. How do we do this?

Say we call the value `MAGIC_NUMBER` (Of course, in a real life situation you would use a better name than this, wouldn’t you? Something like `PI`, `GST_PERCENTAGE`, `NUMBER_OF_CLIENTS`, etc.) we would then have this code.

Example B:

```cpp
int GetValue0()
{
  return MAGIC_NUMBER;
}

int GetValue1()
{
  return MAGIC_NUMBER + MAGIC_NUMBER;
}

int GetValue2()
{
  return MAGIC_NUMBER * MAGIC_NUMBER;
}
```

Great. The problem now is, how do we tell our program about `MAGIC_NUMBER`?

If you originally started programming C then your first instinct may be to use:

```cpp
#define MAGIC_NUMBER 10
```

The main problem here is that the compiler may not realise that all of the places you use `MAGIC_NUMBER` are linked so it may not realise that it can factor it out. The other problem with this method is the lack of type safety. You can use MAGIC\_NUMBER with sign/unsigned ints, char, bool etc. The compiler may not warn you about converting between these types. For an int this isn’t really a problem, but `const float PI = 3.14...f` should give you a warning when you try to initialise an int to it. This is good news as it requires you to cast if you really want to do it, which then shows other programmers than you have actually thought about what you are doing and what is happening to the value as it passes through each variable.

You might be tempted to use:

```cpp
int MAGIC_NUMBER = 10;
```

This is much better as it adds type safety, however you can do even better than that,

```cpp
const int MAGIC_NUMBER = 10;
```

This way it isn’t “just” a global variable, when you declare it as `const` you are telling the compiler that it will never change in value which means that it can make all sorts of assumptions about how it will be used. Your compiler may or may not factor out/in this value, it may or may not insert `10 + 10` and `10 * 10` into those functions for you at compile time. Using a const int means that the compiler gets the choice of using either the value directly or using a variable containing that value, and I trust the compiler more than myself to make that decision. Because it knows the value of `MAGIC_NUMBER` at compile time and knows that it will never change at runtime it can actually do the calculation and insert that value instead.

```cpp
int GetValue0()
{
  return 10;
}

int GetValue1()
{
  return 20;
}

int GetValue2()
{
  return 100;
}
```

The other magic number container is enum. It varies slightly to const int as it is more for collections of values where you want to identify something by what type it is.

```cpp
enum RESULT
{
  RESULT_FILE_DOWNLOADED,
  RESULT_CONNECTION_FAILED, 
  RESULT_FILE_NOT_FOUND,
  RESULT_DISCONNECTED
};

RESULT DownloadFile(const std::string& url)
{
  // Pseudocode
  if (could not connect) return RESULT_CONNECTION_FAILED;
  if (file not found) return RESULT_FILE_NOT_FOUND; 

  if (disconnected) return RESULT_DICONNECTED;

  return RESULT_FILE_DOWNLOADED;
}
```

In this way we can get rid of magic numbers and (In C++0x at least with [enum class](http://en.wikipedia.org/wiki/C%2B%2B0x#Strongly_typed_enumerations)) get some type safety, your compiler will hopefully complain if you try and return an integer instead of a `RESULT`.
