---
weight: 20
bookFlatSection: false
title: "Debugging"
---

# Debugging

The current debugging experience with LionsOS systems is quite tedious as the only options for debugging
are to insert `printf`s or looking at the object dump if a certain protection domain faulted at an address.

While simulators such as QEMU offer debugging support with GDB, those debugging on hardware cannot attach
a debugger.

We have been working to add first-class GDB support to LionsOS so you can do things like single-stepping
over code, set breakpoints and read the state of a program.

## Availability

All the work relating to GDB support can be found [here](https://github.com/au-ts/libgdb).

While it is functional and can be used to debug applications, it is yet to be properly integrated with
LionsOS. However, getting it integrated is a priority for us.

## Features

We implement most of the GDB remote protocol, which means that you can:
* Read/write register state
* Read/write memory of a PD
* Single step execute
* Set breakpoints
* Set watchpoints

## Architecture

Below is the general setup of a LionsOS system using GDB. There is a GDB Protection Domain (PD) that is
responsible for controlling the execution of the buggy PDs depending on the GDB commands given by the user.

The host (e.g developer's machine) that is running the GDB client connects to the GDB PD via some transport
such as a serial or network device. For failicating this I/O, we use the standard interfaces that are used
for all other [I/O in LionsOS](/docs/components/drivers).

We have GDB over serial and are working on GDB over the network. In theory it would be possible to use other
device classes but at this time we have no plans to do so.

<img src="/gdb_arch.svg" alt="Architecture of a system using GDB support" />
