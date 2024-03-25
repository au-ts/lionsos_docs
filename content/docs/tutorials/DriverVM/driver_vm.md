+++
title = "Driver Virtual Machines"
date = 2024-02-19T06:34:24+11:00
draft = false
+++


# Background Reading
See the manual on [Github](https://github.com/au-ts/libvmm/blob/main/docs/MANUAL.md)

# Setting up your environment

Follow the standard instructions at [Getting and Building
LionsOS](../GettingStarted)

# First steps: Odroid C4
There are several templates for different platforms in the [LionsOS
VMM Examples](https://github.com/au-ts/libvmm/tree/main/examples)
directory.  You can take a look at them; but we're going to start
more-or-less from scratch for this.

For a driver VM we want to pass through everythng, and if possible use
an upstream kernel.  First step therefore is to install your linux
system of choice on the hardware.  We're using the Odroid C4; examples
assume the Ubuntu _Jammy_ distribution from
[Armbian](https://www.armbian.com/odroid-c4/).  Get that working
first, on the eMMC, with a serial console.

Getting the Payload
-------------------

Then extract the initial ramdisk, kernel, and device tree binary.
The most accurate way to get the device tree is to extract it from
`/proc`:
```
dtc -I FS -O dts /proc/device-tree
```
but the one in  `/boot/meson-sm1-odroid-c4.dtb` is good enough to
start with.  The only differences will be if U-Boot has changed the
device tree before handing it to the running kernel.  We'll be
overriding the parts that U-Boot usually changes, so there's no real
disadvantage in using the on-disk one.

The kernel and initial ramdisc you want are the ones for the kernel
that is running.  Check the kernel version in `/lib/modules` to make
sure you get the right one.  Copy them to your build machine.

Creating the VMM
----------------

The virtual machine that comes with LionsOS is a library.  You need to
provide a driver file that sets things up for the environment you're
running the system in.  Entry points for the library are documented at
[components/virtual_machines]{../../components/virtual_machines}

There is a sample file in the LionsOS
[Examples](https://github.com/au-ts/LionsOS/tree/main/examples/vmm-examples/vmm/vmm.c)
directory.

### The file `vmm.c`

`vmm.c` contains the driver for the hypervisor.  You will need a copy
of this file, suitable adapted, for every virtual machine running on
the system.

As with any _microkit_ component, there is an `init()` and a
`notifed()` function.

Starting with `init()`, the purpose here is to set up the kernel,
initrd and DTB images 

Most of the work is done by `linux_setup_images()` which copies the
images from their place in the loader image into the guest RAM area.

Apart from that the only work to do is to set up the virtual interrupt
controller.  There are two things to do:  register an interrupt for
each interrupt you want to be able to pass through from real hardware,
and initialise the device.

The interrupt controller is initialised by calling
`virq_controller_init()`.  It takes as argument the guest CPU id.  At
present, this will always be zero as we do not yet support multi-cpu
guests. 

Then for each interrupt you want to pass through, you need to assign a
Microkit channel number.  Channel numbers are per-protection-domain,
so you have complete freedom as to what numbers you use.  You do
howver need to keep track of the mapping, so that when a notification
arrives, the right interrupt can be injected; and when the guest
acknowlegdes the interrupt, the right channel can be signalled.

The `vmm.c` example does this with an array  `passthrough_irq_map[]`
indexed by channel, whose values are the irq numbers.

The remaining thing to do is to set up any MMIO Virtio regions, and
then call `guest_start()`

When running, external events will be signalled to the `notified()`
function.  In most cases these will be passed-through interrupts or
notifications from sDDF components.  Interrupts need to be injected by
calling `vgic_inject_irq()`; virtualiser channels get passed to the
appropriate virtio routine.


System XML file
---------------

By examining the device tree, the system xml file can be composed.
To pass through a device, its memory region and its interrupts need to
be mapped in the file.

So that the guest can use an almost unmodified device tree, and to
avoid confusion, it's usually best to map device MMIO regions 1:1

In the device tree for the Odroid C4, you'll notice that devices are
arranged into a series  buses.  Rather than map each device
individually, we'll set up regions using 2M  pages where possible. 

```
  <memory_region name="bus1" size="0x200_000" phys_addr="0xff600000"
	page_size = "0x200_000"/>
  <memory_region name="bus2" size="0x400_000" phys_addr="0xff800000"
	page_size = "0x200_000"/>
  <memory_region name="bus3" size="0x100_000" phys_addr="0xffd00000" />
```
If we ever want _not_ to pass a device through, these regions wil have
to be split.

There are other devices that need to be passed through individually,
such as the ethernet.    These are mapped with standard 4k pages as they
are small regions.

```
  <memory_region name="eMMCB" size="0x1000" phys_addr="0xffe05000" />
  <memory_region name="eMMCC" size="0x1000" phys_addr="0xffe07000" />
  <memory_region name="eth" size="0x10000" phys_addr="0xff3f0000" />
  <memory_region name="gic_vcpu" size="0x1_000" phys_addr="0xffc06000" />

```

All these are mapped one-to-one in the virtual machine guest protection
domain.  Device regions are mapped uncached.

```
  <protection_domain name="VMM" priority="10">
    <program_image path="vmm.elf" />
    <map mr="guest_ram" vaddr=GUESTRAMADDR perms="rw" setvar_vaddr="guest_ram_vaddr" />
    <virtual_machine name="linux" id="0" priority="1">
      <map mr="guest_ram" vaddr=GUESTRAMADDR perms="rwx" />
      <map mr="eMMCB" vaddr="0xffe05000" perms="rw" cached="false" />
      <map mr="eMMCC" vaddr="0xffe07000" perms="rw" cached="false" />
      <map mr="bus1" vaddr="0xff600000" perms="rw" cached="false" />
      <map mr="bus2" vaddr="0xff800000" perms="rw" cached="false" /> 
      <map mr="bus3" vaddr="0xffd00000" perms="rw" cached="false" />
      <map mr="eth" vaddr="0xff3f0000" perms="rw" cached="false" />
      <map mr="gic_vcpu" vaddr="0xffc02000" perms="rw" cached="false" />
    </virtual_machine>
    <!-- vpu -->
    <irq irq="35" id="15" trigger="edge" />
    <!-- panfrost-gpu -->
    <irq irq="192" id="7" />
    <!-- panfrost-mmu -->
    <irq irq="193" id="8" />
    <!-- panfrost-job -->
    <irq irq="194" id="9" />
    <!-- i2c -->
    <irq irq="53" id="10" />
	<!-- UART -->
    <irq irq="225" id="11" trigger="edge" />
    <!-- hdmi -->
    <irq irq="89" id="14" trigger="edge" />
    <!-- IRQ work interrupts -->
    <irq irq="5" id="17" />
    <!-- eMMCB -->
    <irq irq="222" id="18" />
    <!-- eMMCC -->
    <irq irq="223" id="19" />
    <!-- Ethernet -->
    <irq irq="40" id="21"/>
    <!-- GPIO IRQs -->
    <irq irq="96" id="23" trigger="edge"/>
    <irq irq="97" id="24" trigger="edge"/>
    <irq irq="98" id="25" trigger="edge"/>
    <irq irq="99" id="26" trigger="edge"/>
    <irq irq="100" id="27" trigger="edge"/>
    <irq irq="101" id="28" trigger="edge"/>
    <irq irq="102" id="29" trigger="edge"/>
    <irq irq="103" id="30" trigger="edge"/>
  </protection_domain>
```
