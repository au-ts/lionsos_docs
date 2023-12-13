---
title: "Device Drivers"
weight: 1
# bookFlatSection: false
# bookToc: true
# bookHidden: false
# bookCollapseSection: false
# bookComments: false
# bookSearchExclude: false
---

# Device Drivers

All device drivers are in user-space as separate components. This means that they each have their own
Thread Control Block (TCB) as well as virtual-address space. This design coupled with the guarantess
of seL4 ensure each device driver is isolated.

The drivers used in LionsOS come from the [seL4 Device Driver Framework]().

Currently LionsOS offers a variety of device classes, such as:
* Serial
* Ethernet
* I<sup>2</sup>C
* Block

## Networking
## I<sup>2</sup>C
## Block
