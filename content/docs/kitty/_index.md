---
weight: 30
bookFlatSection: false
title: "Reference system (Kitty)"
---

# Reference system

Since LionsOS is trying to be a fundamentally different operating system,
we need to teach people how to properly use it.

The purpose of this reference system is to show off a real, deployable
system using all of the components that LionsOS provides.

The system we have built is called the Kitty, it is a Point-of-Sale (PoS)
system intended to be used for buying snacks in the Trustworthy Systems
Lab.

{{< hint danger >}}
**TODO: use a better picture**
{{< /hint >}}
<img style="display: block; margin-left: auto; margin-right: auto" src="/kitty_case.jpg" alt="Picture of Kitty user inteface and hardware case" width="500"/>

## Architecture

Below is a diagram of the (simplified) architecture of the Kitty system that contains
all of the various components involved.

![Kitty architecture diagram](/kitty_architecture.svg)

## LionsOS components

### Networking

#### Network File System (NFS)

### I<sup>2</sup>C

### Serial sub-system

### Timer

### Linux Virtual Machine

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

### Connections with LionsOS
#### I<sup>2</sup>C

#### Framebuffer

#### Networking

#### File System

## Navigating the codebase

In LionsOS, you will find
