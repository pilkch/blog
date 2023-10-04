---
author: Chris Pilkington
date: "2008-12-15T16:10:02Z"
id: 36
tags:
- c++
- linux
- tutorial
- x86_64
title: x86_64 Linux C/C++ Test
---

I use:
- [gcc](http://gcc.gnu.org/)  
- [cmake](http://www.cmake.org/)  
- [KDevelop](http://www.kdevelop.org/)  
- [RapidSVN](http://rapidsvn.tigris.org/)  
- [Meld](http://meld.sourceforge.net/)

However, don’t go the websites, all of these are available in the (Default?) repositories, so you can either install them via [yum](http://en.wikipedia.org/wiki/Yellow_dog_Updater,_Modified), [PackageKit](http://en.wikipedia.org/wiki/PackageKit) or apt-get. Also note: RapidSVN and Meld are only needed if you want to use SVN. Even KDevelop is not required if you have another text editor that you prefer such as gedit/vi/emacs. If you want to create your provide your own make file then you don’t need cmake either.

Anyway, so a simple application that just tests that you can do a 64 bit compile is pretty straight forward.  
1. Create a main.cpp file with a `int main(int argc, char* argv[]);` in it:
```cpp
#include <iostream>
 
int main(int argc, char* argv[])
{
  int *int_ptr;
  void *void_ptr;
  int (*funct_ptr)(void);
 
  std::cout<<"sizeof(char):        "<<sizeof(char)<<" bytes"<<std::endl;
  std::cout<<"sizeof(short):       "<<sizeof(short)<<" bytes"<<std::endl;
  std::cout<<"sizeof(int):         "<<sizeof(int)<<" bytes"<<std::endl;
  std::cout<<"sizeof(long):        "<<sizeof(long)<<" bytes"<<std::endl;
  std::cout<<"sizeof(long long):   "<<sizeof(long long)<<" bytes"<<std::endl;
  std::cout<<"------------------------------"<<std::endl;
  std::cout<<"sizeof(float):       "<<sizeof(float)<<" bytes"<<std::endl;
  std::cout<<"sizeof(double):      "<<sizeof(double)<<" bytes"<<std::endl;
  std::cout<<"sizeof(long double): "<<sizeof(long double)<<" bytes"<<std::endl;
  std::cout<<"------------------------------"<<std::endl;
  std::cout<<"sizeof(*int):        "<<sizeof(int_ptr)<<" bytes"<<std::endl;
  std::cout<<"sizeof(*void):       "<<sizeof(void_ptr)<<" bytes"<<std::endl;
  std::cout<<"sizeof(*function):   "<<sizeof(funct_ptr)<<" bytes"<<std::endl;
  std::cout<<"------------------------------"<<std::endl;
  std::cout<<"Architecture:        "<<sizeof(void_ptr)<<" bit"<<std::endl;
 
  return 0;
}
```
2. Create a CMakeLists.txt that includes your main.cpp:
```cmake
# Set the minimum cmake version
cmake_minimum_required (VERSION 2.6)

# Set the project name
project (size_test)

# Add executable called "size_test" that is built from the source file
# "main.cpp". The extensions are automatically found.
add_executable (size_test main.cpp)
```
3. cd to the directory of your CMakeLists.txt and run `cmake .` and then `make`
4. `./size_test` output:
```bash
sizeof(char):        1 bytes
sizeof(short):       2 bytes
sizeof(int):         4 bytes
sizeof(long):        8 bytes
sizeof(long long):   8 bytes
------------------------------
sizeof(float):       4 bytes
sizeof(double):      8 bytes
sizeof(long double): 16 bytes
------------------------------
sizeof(*int):        8 bytes
sizeof(*void):       8 bytes
sizeof(*function):   8 bytes
------------------------------
Architecture:        64 bit
```

As you can see this is specific to x86_64.  The beauty of gcc is that by default it compiles to the architecture it is being run on.  I had previously thought that it would be a world of pain, making sure that my compiler built the right executable code and linked in the correct libaries.  I know this project doesn't use any special libraries, but (because of cmake?) the process is exactly the same as using cmake under 32 bit to make 32 bit executables.  You just make sure that they are there using Find*.cmake and then add them to the link step:
```cmake
SET(LIBRARIES
  ALUT
  OpenAL
  GLU
  SDL
  SDL_image
  SDL_net
  SDL_ttf
)
# Some of the libraries have different names than their Find*.cmake name
SET(LIBRARIES_LINKED
  alut
  openal
  GLU
  SDL
  SDL_image
  SDL_net
  SDL_ttf
)
FOREACH(LIBRARY_FILE ${LIBRARIES})
  Find_Package(${LIBRARY_FILE} REQUIRED)
ENDFOREACH(LIBRARY_FILE)

# Link our libraries into our executable
TARGET_LINK_LIBRARIES(${PROJECT_NAME} ${LIBRARIES_LINKED})
```

Note that we don't actually have to specify the architecture for each package or even the whole executable.  This is taken care of by cmake.  Anyway, it is not some mysterious black magic, it is exactly the same as you've always been doing.  Cross compiling is slightly different, but basically you would just specify -m32 and make sure that you link against the 32 bit libraries instead.  If I actually bother creating another 32 bit executable in my life I'll make sure that I document right here exactly how to do a cross compile from 64 bit.  

The advantages of [64 bit](http://en.wikipedia.org/wiki/X86-64) are mmm, not so great unless you deal with really big files/memory ie. more than 4 GB.  Perhaps more practical are the extra and upgraded to 64 bit registers so you may see an increase in speed or [parallelisation](http://en.wikipedia.org/wiki/Automatic_parallelization) of 64 bit operations, for example a game may want to use 64 bit colours (ie. 4x 16 bit floats instead of 4x 8 bit ints to represent an [rgba pixel](http://en.wikipedia.org/wiki/RGBA_color_space).

### Things to watch out for:

- int is still 32 bit!  If I were implementing the x86_64 version of C++ standard/gcc/in a perfect world this would have been changed to 64 bit, ie. "int" would be your native int size, it's logical, it makes sense.  However, I do understand that this would have broken a lot of code.  The problem is, if int != architecture bits, then why have it at all, why not drop it from the standard and just have int32_t and int64_t and be done with it.  Then if a program chooses it can have:
```cpp
typedef int32_t int;
```
or
```cpp
typedef int64_t int;
```
as it sees fit.  Anyway.
- Pointers are now 64 bit!  So you can use them with size_t but cannot use them with int
- Under linux x86_64 gcc `sizeof(int*) == sizeof(function*)`, however, this is not guaranteed anywhere.  It may change on a certain platform/compiler.  Don't do stuff like this:
```cpp
int address = &originalvariable;
```
- gcc should warn you (you may need to [turn on these warnings](http://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html) `-Wformat -Wconversion`).
- All in all, if you have been writing standard code and using make/cmake it should be relatively pain free to upgrade to 64 bit.
