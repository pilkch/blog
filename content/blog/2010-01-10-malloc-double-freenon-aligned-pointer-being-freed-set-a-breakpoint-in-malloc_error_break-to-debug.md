---
author: Chris Pilkington
date: "2010-01-10T10:00:22Z"
id: 227
tags:
- linux
- tutorial
- c++
title: malloc double free/non- aligned pointer being freed set a breakpoint in malloc_error_break
  to debug
---

```bash
malloc: *** error for object 0x3874a0: double free
***set a breakpoint in malloc_error_break to debug

malloc: *** error for object 0x18a138: Non- aligned pointer being freed
*** set a breakpoint in malloc_error_break to debug
```

So basically something in your code is screwing around with memory.

Either releasing something that has already been released:

```cpp
int* x = new x[10];
delete [] x;
delete [] x;
```

Or releasing something that is not pointing to the start of an allocated block of memory:

```cpp
int* x = new int[10];
x++;
delete [] x;
```

The error message isn’t very clear if you have no experience with [GDB](http://en.wikipedia.org/wiki/GNU_Debugger). GDB is a debugger for your binaries. It allows you to set break points at the start of a function and any time that function is called your application will pause and allow you to debug in GDB. We can then get valuable information back by executing commands to get the backtrace, registers state and disassembly. The advantage of using GDB over [Xcode](http://en.wikipedia.org/wiki/Xcode)/[KDevelop](http://en.wikipedia.org/wiki/KDevelop) is being able to break into any function, not just functions in your source code. Anyway, this is how I got the backtrace to find out where in my sourcecode I was making a mistake:

```bash
gdb
file myapplication
break malloc_error_break
run
backtrace
```

Now whenever a double free or non- aligned pointer is freed it will break into gdb and we can type in “backtrace” and work out what our code did to trigger this.