---
title: "Virtual Machines"
weight: 1
---

# Virtual Machines

There are two primary use cases of virtual machines within a LionsOS-based system:
* for running legacy clients or clients you do not want to port to a LionsOS environment.
* leveraging pre-existing drivers to be able to use devices without having to run a native
  device driver.

## Architecture

The general setup when doing virtualisation within LionsOS is that we have a
virtual-machine-monitor (VMM) Protection Domain (PD) that is responsible for
managing a single guest. We restrict each VMM to only service exactly one guest
as if the guest compromises the VMM then it is still isolated from the rest of
the system.

<img src="/vmm_arch.svg" alt="Architecture of a system using virtualisation" width="400" />
