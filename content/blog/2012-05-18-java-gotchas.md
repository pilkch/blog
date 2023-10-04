---
author: Chris Pilkington
tags:
- dev
- java
date: "2012-05-18T23:38:03Z"
id: 308
title: Java Gotchas
---

![Java](/blog/wp-content/uploads/2012/05/java.png "Java")

- Everything is a pointer that initially points to null. Every non-POD type must be newed (I forget this one a lot)
- The POD types (int, float, enum, etc.) behave just like their C++ counter parts.  
    The boxed versions (Integer, Float) and String in Java are more like a pointer to the POD value.  
    For example:
    ```java
    String a = "chris";
    String b = "chris";
    if (a == b) System.out.println("The strings are the same");
    ```
    
    This test will always fail because operator== for pointers (Instances of anything derived from java.lang.Object) will test if the pointers point to the same memory.  
    To compare boxed types:
    ```java
    if (a.equals(b)) System.out.println("The strings are the same");
    ```
- Strings are immutable in Java, this doesn’t work as expected:
    ```java
    String a = "a";
    a.replace('a', 'b');
    System.out.print(a); // Prints "a" instead of "b"
    ```
    
    A copy must be made:
    ```java
    String a = "a";
    String b = a.replace('a', 'b');
    System.out.print(a); // Prints "b"
    ```
    
    String toUpperCase and toLowerCase have the same problem.
- Java finalize() is not a C++ destructor. It is not guaranteed to be called. If a finalize() function is called it is up to the child class to call super.finalize().
- If you specify no access modifier in C++ the default behaviour is private to the class, in Java it is private to the package. If you are bitten by this bug it kind of serves you right because you should always specify an access modifier anyway, but it may bite you when porting old code from C++.
- There is no way to choose what lives on the stack and what lives on the heap. It doesn’t really matter most of the time, but it would be nice to have the option.
- There is no passing by reference, everything is passes as a pointer.
- There are no function pointers, anonymous interfaces are probably the closest thing to it.
- Copy vs Reference Confusion
    ```java
    Car a = new Car();
    a.SetColour("red");
    Car b = a; // Takes a reference to a, does not create a copy
    b.SetColour("blue");
    System.out.print(a.GetColour()); // Prints "blue"
    ```
- Java final is not the same as C++ const
    ```java
    class PaintShop {
      public void PaintCarBlue(final Car car) {
        car.SetColour("blue"); // Changes the colour of the original car
      }
    }
    
    PaintShop paintShop = new PaintShop();
    Car a = new Car();
    a.SetColour("red");
    paintShop.PaintCarBlue(a);
    System.out.print(a.GetColour()); // Prints "blue"
    ```
