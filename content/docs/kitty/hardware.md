+++
title = 'Hardware setup'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Setting up your Odroid-C4 hardware

The example system targets the HardKernel Odroid-C4 platform as it is a fairly inexpensive, accessible, and reliable ARM single-board-computer.

The Odroid-C4 is available for purchase [directly from HardKernel](https://www.hardkernel.com/shop/odroid-c4/).

Official documentation for the Odroid-C4 is available [here](https://wiki.odroid.com/odroid-c4/odroid-c4).

![test](/all_hardware.jpeg)

## What you will need

| Hardware | Link | Price (USD) | Price (AUD) | Price (EUR) |
| ----------- | ----------- | - | - | - |
| HardKernel Odroid-C4 SBC | | 150 | 1 | 1 |
| UART to USB converter | | 150 | 1 | 1 |
| Power Supply | | 150 | 1 | 1 |
| NFC card reader | | 150 | 1 | 1 |
| VU7C touchscreen display | | 150 | 1 | 1 |
| Ethernet cable | | 150 | 1 | 1 |
| Female to female pin cables | | 150 | 1 | 1 |

In addition to the Odroid-C4 itself, you will need a couple of pieces before you can boot the system:

* A power supply (TODO add detail)
* A UART to USB adapter (3.3V)
* A microSD card or eMMC module (TODO does it need to be a specific kind or a specific size? Probably can't be too big)

TODO pictures of setting everything up (UART, power, microSD or eMMC)

## Connecting everything together

This section will show you how to connect all the hardware pieces you have to your Odroid-C4.

TODO: add notes for connecting power and UART to USB device

TODO: add notes for connecting the NFC module. Specify which GPIO pins + show a picture

### UART to USB converter

### PN532 NFC card reader

Below is the NFC card reader that we use. You will want to note two things:
1. We need the NFC card reader to be in I<sup>2</sup>C mode, which means that the pins on the
   bottom left need to be in a certain configuration. For I<sup>2</sup>C, pin 1 needs to be set
   and pin 2 needs to be not set. The image below has the correct setup.
2. On the left are the pins that will connect to Odroid-C4. If you are using the display, this will
   connect to the GPIO pins exposed on the back of the display. If you are not using the display,
   these will connect directly to the GPIO pins on the Odroid-C4.

<img src="/nfc_card_reader.jpeg" alt="PN532 NFC card reader close up" width="300"/>

#### With display

#### Without display

### VU7C touchscreen display

The display is fairly easy to connect, at the back you will see a bunch of GPIO inserts which you want
to align with the GPIO pins on the Odroid-C4.

### Network cable

If you want to use the NFS client

## Flashing U-Boot

Follow the instructions [here](https://github.com/Ivan-Velickovic/flash_uboot_odroidc4).

TODO, reproduce the instructions from https://github.com/Ivan-Velickovic/flash_uboot_odroidc4
here.

TODO, have instructions for building custom U-Boot in case the reader needs some specific
config option in U-Boot that isn't in the default one.

TODO, an option is to have a tar.gz that contains the image *as well as* the `uboot.env` file
so that they don't have to configure U-Boot manually.

## Configuring U-Boot

When you see this message from U-Boot:
```
Hit any key to stop autoboot:  1
```

You will want to stop the autoboot immediately. From here,
we want to setup the U-Boot environment to automatically load
the system image. There are two main ways of getting system images
into U-Boot:
1. (**recommended**) Booting via the network. Where you have a TFTP server
  on some other computer that transfers the system image to U-Boot
  on the Odroid-C4 via the network.
2. Using a storage device such as an SD card or eMMC.

TODO, only tested these instructions via SD card, not via eMMC yet.

### Option 1 - Booting via the network

By default U-Boot is set to auto-boot into a Linux system, we want to change that obviously.
This can be done by changing the value of the U-Boot environment variable `bootcmd`, the contents
of which is executed automatically when U-Boot starts, unless U-Boot is interrupted.

When you are in the U-Boot console, enter the following commands:

```
=> setenv bootcmd 'dhcp; tftpboot 0x20000000 <SYSTEM IMAGE PATH>; go 0x20000000'
=> saveenv
```

You should see the following output:
```
Saving Environment to MMC... Writing to MMC(0)... OK
```

Note that the `<SYSTEM IMAGE PATH>` will be the path to the system image in your TFTP server.
(TODO isn't is relative to some root directory of the TFTP server?)

From here, you will need to run `saveenv` in order to have the change persist across reboots.

Finally you can reboot your Odroid-C4 and after a couple of seconds it should automatically
boot into your system image.

### Option 2 - Booting from storage

TODO
