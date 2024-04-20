---
weight: 10
bookFlatSection: false
title: "Integration"
---

# Integration

Due to LionsOS being a *component* Operating System, part of the process of developing
on top of LionsOS involves picking and integrating the various components and sub-systems
that you want to be part of your final system.

This brings up a problem of how, as the system designer, do you put everything together
without spending a lot of time getting familiar with the LionsOS components themselves?

In a Microkit based system, in order to get the final bootable image for your hardware, the Microkit
tool expects you to produce two artefacts:
1. The SDF file that describes what Protection Domains, Memory Regions, Communication Channels, etc
   are in the system.
2. The ELFs used as program images for the Protection Domains.

## System Description Format (SDF) file

The goal of the Microkit SDF is to describe the resources and architecture of the system. It is not
supposed to provide a way of flowing information about the system to component code. The SDF is also
quite verbose and also uses XML.

These limitations have benefits but also present problems such as:
* making the SDF difficult to hand-write for large systems.
* not giving component code a way to generalise over the system-specific parameters (e.g, how many
  clients a virtualiser component has).

We have encountered these problems in our [Kitty reference system](/docs/kitty) and are working on
improved/extra tooling in order to make the development of a LionsOS system significantly easier.

This involves a way of auto-generating information about the system for components to consume as well
as auto-generating the SDF file itself based on some higher-level specification.

## Build System

While LionsOS has less run-time complexity compared to traditional OSes, some of that complexity is
shifted to build-time which means more reliance and expectation of the build system.

### Make

The primary way we have been building LionsOS systems (such as the [reference system](/docs/kitty)) is
via GNU Make. We are in the process of creating small Makefile snippets for each component (e.g a driver
or a static library like libvmm) which can then be called from a top-level Makefile that you have created.
This should decrease the amount of time needed to get something up and running.

### Zig

We are also experimenting with the [Zig build system](https://ziglang.org/learn/build-system/). The Zig
project provides a portable C/C++ toolchain as well as a build system. Zig build 'scripts' are written in the
Zig programming language that call APIs for creating on build steps. Despite not having any Zig programs in
LionsOS, we can still leverage the build system. In fact, due to having the build system as well as the
toolchain in a single executable, building via Zig actually has less dependencies than other build systems.

We do not have Zig build scripts for all the parts of LionsOS yet, but
[libvmm has some examples](https://github.com/au-ts/libvmm/tree/main/examples/simple#building-with-zig).
