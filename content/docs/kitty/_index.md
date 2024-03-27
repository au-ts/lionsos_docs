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

* a bit about micropython
* links to docs
* how it works a bit,
* why we chose micropython

### Connections with LionsOS
#### I<sup>2</sup>C

#### Framebuffer

#### Networking

#### File System

## Navigating the codebase

In LionsOS, you will find
