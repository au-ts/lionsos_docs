---
weight: 3
bookFlatSection: false
title: "Driver VM"
---

# Using a Virtual Machine to develop sDDF components

LionsOS drivers have two parts: a _driver interface_ (that consists of
the device registers and interrupts), and an _sDDF interface_ that
consists of ring buffers and microkit notifications.

The actual driver can be developed under Linux, by mapping both
interfaces as
[UIO](https://www.kernel.org/doc/html/latest/driver-api/uio-howto.html)
and writing a usermode program to do the work.

As a halfway point, one can use the Linux driver to develop the sDDF
part.  For complex drivers (like for Graphics), or if performance is
not an issue, the resulting driver can be used in a production system.
However, both performance and security will be enhanced with a native
driver.

This tutorial leads you through the creation of a simple block interface to
the sDDF.

# Steps we're going to take

1. Get a [virtual machine using LionsOS](/docs/tutorials/drivervm/driver_vm) working on the target platform,
   with all devices passed through.  This allows us to be sure the
   virtualisation system is working, and to set up a development
   environment using the target's local storage.
2. Switch the virtual machine to use LionsOS sDDF for serial and
   ethernet.  This shows how to set up the memory regions and use
   virtIO.
3. Create a second virtual machine using virtio-Network and serial;
   using a [buildroot](https://buildroot.org/) kernel and RAMdisk.
   This shows how to set up multiple virtual machines.
4. Set up a UIO region for the development VM that shares memory
   regions with the second (client) VM.
5. Set up an sDDF user-mode block device to feed virtIO-Block on the
   client VM, using only Linux user-space tools in the development VM.
   This shows how you can access sDDF rings from Linux user space in
   an appropriately configured VM.
