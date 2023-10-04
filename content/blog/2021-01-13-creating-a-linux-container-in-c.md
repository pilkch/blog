---
author: Chris Pilkington
date: "2021-01-13T00:34:47Z"
id: 529
tags:
- c++
- containers
- docker
- kernel
- linux
- lxc
title: Creating a Linux Container in C++
---

I love Linux containers. You get *a* degree of separation from the host and other machines without hosting a full VM and without requiring a whole second OS.

**What are containers?**

A process or group of processes that are running on the same kernel as the host but in isolation via [namespaces](https://en.wikipedia.org/wiki/Linux_namespaces), [cgroups](https://en.wikipedia.org/wiki/Cgroups) and [images](https://images.linuxcontainers.org)

**Why would you do this?**

- Share resources (3 web servers in containers on one physical server for example)
- Less overhead and quicker to spin up than a VM
- To experiment in Linux without modifying the host OS settings or filesystem
- To run software or use libraries that cannot or shouldn’t be run on the host (Mismatched versions, tries to read data from your home folder, tries to mess around with other processes, spams syslog, tries to phone home or query the network, or talk to Linux kernel modules)
- Consistent behaviour (Developers can run wildly different machines but develop within identical containers, consistent continuous integration, simulate end users’ machines for debugging)
- Run a collection of containers that can talk to each other but can’t talk to the rest of the network (Local testing, integration testing, load testing, mess around with network configurations and firewall rules without endangering the host)
- Run a collection of containers that can talk to each other but only one or two of them are public facing (LAMP stack, ELK stack, a cluster, etc.)
- Set limits on memory usage and disk usage (Restrict resource heavy applications or test out of memory situations without killing the host)
- Share folders and even whole Linux kernel modules from the host into the container.

**Why wouldn’t you do this?**

- A VM or separate machine is generally a better approach if you have the resources
- A VM can be more secure due to better isolation, not sharing a kernel for example
- A VM can be more stable due to not sharing the kernel and kernel modules
- Containers must be the same architecture as the host
- Applications and libraries in a container have to be created for a version of the Linux kernel that is compatible with the host

**Fair enough. How do containers work?**

[Namespaces](https://en.wikipedia.org/wiki/Linux_namespaces), [cgroups](https://en.wikipedia.org/wiki/Cgroups) and [images](https://images.linuxcontainers.org) are set up to provide an environment for the container’s processes to run in.

- Namespaces – Isolate the processes from the host, giving it it’s own filesystem, process tree, network, IPC, hostname, and users
- Cgroups – Set limits for CPU usage, memory, disk and more for the container
- Images – An image or folder containing the applications, libraries, and data that a container needs to run, for example cut down all the way up to fully featured distros: busybox, alpine, centos, ubuntu, etc. (Docker and LXC allow combining images via an overlay so you can get alpine + java + nifi for example which a smushed together into a single filesystem

**Great. Now what?**

What does this look like in code?  
Here is my [C++ rewrite](https://github.com/pilkch/cpp-container) of Lizzie Dixon’s excellent [C container](https://blog.lizzie.io/linux-containers-in-500-loc.html). It demonstrates setting the cgroups, creating the namespaces, mounting the busybox filesystem, and launching the child process.


**NOTE: This is just a proof of concept, it doesn’t have basic, nice things like networking, package management, file system overlays, any sort of Dockerfile/makefile/recipe support, code reviews, testing, battle hardened development history, etc. It’s not Docker, it’s a proof of concept of the basics of how containers work that doesn’t hide everything away in the Go language and libraries or a `docker run` command.**  
  
Here is an example of it running:

```bash
root@laptop:~/cpp-container# BUSYBOX_VERSION=1.33.0
root@laptop:~/cpp-container# ./cpp-container -h myhostname -m $(realpath ./busybox-${BUSYBOX_VERSION}/) -u 0 -c /bin/sh
=> validating Linux version…4.3.0-36-generic on x86_64.
Starting container myhostname
=> setting cgroups…
memory…
cpu…
pids…
done.
=> setting rlimit…done.
=> remounting everything with MS_PRIVATE…remounted.
=> making a temp directory and a bind mount there…done.
=> pivoting root…done.
=> unmounting /oldroot.kCeIkg…done.
=> trying a user namespace…writing /proc/3856/uid_map…writing /proc/3856/gid_map…done.
=> switching to uid 0 / gid 0…done.
=> dropping capabilities…bounding…inheritable…done.
=> filtering syscalls…done.
/ # echo "Look ma, no docker"
Look ma, no docker
/ # whoami
root
/ # exit
Container myhostname has exited with return code 0
=> cleaning cgroups…done.
root@laptop:~/cpp-container#
```
