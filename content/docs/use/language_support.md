---
weight: 3
bookFlatSection: false
title: "Language Support"
---

# Language Support

If you browse the LionsOS code and the various sub-projects that it uses such as libvmm and sDDF,
you will notice that everything is written in the C programming language.

However, this does not mean that using other programming languages is unsupported and

One of the benefits of having isolated components is that, as long as the standard interfaces
across components are held, any number of programming languages can be used within a single
system.

For example, if you had a client that used the network sub-system, perhaps the client could be
in Rust while the virtualiser/ARP components are in C and the driver is some third language. As
long as the queue structures follow the same memory layout, everything will "just work".

At the moment, we do not have any examples of this kind of setup. The [Kitty reference system](/docs/kitty) is
all written in C code (with some MicroPython scripts).

C will most likely be the most common language of LionsOS components due to our aim to have
a verifiable OS.

## Standard Library (libc)

One of the problems

## Pancake

Pancake is a new programming language, developed at Trusworthy Systems in
co-ordination with other researchers, with the goal of creating verified
device drivers.

## Rust

We have experimented with the Rust programming language briefly.

## Zig

The Zig programming language
