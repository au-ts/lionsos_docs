---
weight: 30
bookCollapseSection: true
title: "Reference system (Kitty)"
---

# Reference system

Since LionsOS is trying to be a fundamentally different operating system,
we need to teach people how to properly use it.

The purpose of this reference system is to show off a real, deployable
system using a wide range of the components that LionsOS provides.

<!-- TODO: use a better picture -->
<img style="display: block; margin-left: auto; margin-right: auto" src="/kitty_case.jpg" alt="Picture of Kitty user inteface and hardware case" width="500"/>

The system we have built is called the Kitty, it is a Point-of-Sale (PoS)
system intended to be used for buying snacks in the Trustworthy Systems
Lab.

This page describes the system's architecture and details about how it works,
if you are interested in building and running it see the pages on:
* [Hardware setup](./hardware)
* [Building](./building)
* [Running](./running)

## Architecture

Below is a diagram of the (simplified) architecture of the Kitty system that contains
all of the various components involved.

There is a client program which is inside the Kitty source code (`client/kitty.py`) that
when imported in the MicroPython REPL will do three things:
* scan for card taps
* send network requests and receive responses with a server to register card taps
* draw the UI based on the current state (e.g if someone has successfully tapped)

![Kitty architecture diagram](/kitty_architecture.svg)

## LionsOS components

<!-- ### Networking -->

<!-- #### Network File System (NFS) -->

### I<sup>2</sup>C

For accessing the card reader, we have a I<sup>2</sup>C driver that is behind
a virtualiser which clients communicate with to claim busses and send requests
and receive responses.

### Serial sub-system

Interaction with the MicroPython REPL is done via a serial connection. We use
a UART device.

### Timer

In order for functionality such as `time.sleep()` in MicroPython to work we need
to use a timer device. It is also required for each IP stack used for the NFS client
and MicroPython networking to deliver a regular timeout notification.

### Linux Virtual Machine

#### Linux images

There are three images associated with the guest operating system:
* the kernel
* the Device Tree Blob (binary format of the Device Tree)
* the initial RAM disc/root file system

The manufacturers of the Odroid-C4 platform, HardKernel, have upstreamed
support to mainline Linux.

This means that we have been able to use a standard mainline version of
Linux to build and run virtual machines on the Odroid-C4. It has the
necessary platform specific configuration and drivers.

However, for this example system there is a single driver that has not
been upstreamed. It is a driver for the `lt8619c` device which is the
HDMI bridge between the VU7C display and Odroid-C4.

<!-- #### UIO

When we get framebuffer data from the client prgoram (in this case
MicroPython), 
-->

## MicroPython

* Micropython is a Python interpreter designed for embedded use.
  It has a much smaller memory footprint than a standard Python
  implementation, and does not rely on a full operating system.
  It includes facilities for interacting directly with hardware; and
  is relatively straightfdorward to port to a new platform.
* There is extensive documnetation at https://docs.micropython.org
* how it works a bit,
* We chose micropython as a way to develop business logic quickly for
  simple embedded systems.  If appropriately configured, it can act as
  a _shell_ for LionsOS.

### Porting MicroPython

For this example system, we have not had to modify or patch MicroPython in any
way, despite MicroPython not having official support for LionsOS. This is
primarily because MicroPython allows users to add their own ports without changing
any internal code.

MicroPython is very configurable, the minimum functionality MicroPython needs to
run a way to output and receive on a serial device. From there, everything added
like timing, networking and file systems is up to what you need from MicroPython.

More information about porting can be found [here](https://docs.micropython.org/en/latest/develop/porting.html).

### Connections with LionsOS

#### I<sup>2</sup>C

The MicroPython [I2C class](https://docs.micropython.org/en/latest/library/machine.I2C.html)
is used to interact with an I<sup>2</sup>C bus.

#### Framebuffer

In order to have a basic graphical user interface (GUI) we leverage the
existing graphics driver in Linux in order to draw to a framebuffer.

We do this for two reasons:
* To show off virtual machines being used in a LionsOS-based system.
* At this stage, we do not have the capacity to write graphics drivers and
  our UI is not affected by the overhead of a virtual machine.

The framebuffer and associated configuration is exported via shared memory to
a client, in this case MicroPython.

MicroPython provides a small [framebuf](https://docs.micropython.org/en/latest/library/framebuf.html)
module for doing operations on a fixed size buffer (e.g setting a particular pixel to a certain colour).
Unlike some of the other modules we make use of in our port of MicroPython, `framebuf` does no I/O. For
this, we have a custom module called `fb` that simply allows us to send a buffer from MicroPython to
the display via the virtual machine.

This custom module was added following the process on
[MicroPython's documentation](https://docs.micropython.org/en/latest/develop/porting.html#adding-a-module-to-the-port).
This module is built and linked at build-time in contrast to extending MicroPython using `.mpy` files. More information
about extending MicroPython [here](https://docs.micropython.org/en/latest/develop/porting.html#adding-a-module-to-the-port).

<!-- #### Networking -->

<!-- #### File System -->

<!-- ## Navigating the codebase -->
