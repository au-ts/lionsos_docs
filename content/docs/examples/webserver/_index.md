---
weight: 30
bookCollapseSection: true
title: "Web server"
---

# Web server system

The LionsOS project contains an example system that acts as a
webserver for static websites. This page aims to explain how the
webserver system works as well as show you how to build and run it.

This page describes the system's architecture and details about how it works,
if you are interested in building and running it see the pages on:
* [Building](./building)
* [Running](./running)

## Supported platforms

The system works on the following platforms:
* QEMU virt AArch64
* HardKernel Odroid-C4

If you are going to use the Odroid-C4 platform, please see the section
on [hardware setup](../kitty/hardware). You do not need all the hardware
parts listed, only the ones necessay for a serial and ethernet connection.

## Architecture

Below is a diagram of the (simplified) architecture of the web server
system that contains all of the various components involved.

<div style="background-color: white; display: inline-block;">
    <img src="/webserver.svg" alt="Web server architecture diagram" />
</div>

There is a singular user protection domain running: a LionsOS port of
the MicroPython runtime. This PD depends on various LionsOS components
for serial output, timeouts, filesystem access and ethernet.

On top of the MicroPython runtime, we run our webserver
application. This consists of the webserver framework
[Microdot](https://github.com/miguelgrinberg/microdot) as well as
`webserver.py`, a script which uses Microdot to serve a static
website.

The webserver application uses our MicroPython port's asynchronous
filesystem library, which provides access to LionsOS filesystems using
async/await.

The MicroPython runtime's filesystem is backed by an NFS
component. The NFS component implements the standard LionsOS
filesystem interface and provides to a client access to a network
filesystem (NFSv3). This is where the static website's files will
live.

<!-- The webserver system runs on the HardKernel Odroid-C4, just like the
Kitty system. See [Kitty/Hardware setup]({{< relref
"/docs/examples/kitty/hardware" >}}), although to run the web server
you only need an ethernet and serial connection to the Odroid-C4, the
other hardware (such as card reader and touchscreen) is not necessary.
 -->
