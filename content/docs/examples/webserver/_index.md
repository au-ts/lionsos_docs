---
weight: 30
bookFlatSection: false
title: "Webserver"
---

# Webserver system

The LionsOS project contains an example system that acts as a
webserver for static websites. This tutorial aims to explain how the
webserver system works as well as show you how to build and run it.

## Architecture

Below is a diagram of the (simplified) architecture of the Kitty
system that contains all of the various components involved.

<div style="background-color: white; display: inline-block;">
    <img src="/webserver.svg" alt="Webserver architecture diagram" />
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

## Hardware setup

The webserver system runs on the HardKernel Odroid-C4, just like the
Kitty system. See [Kitty/Hardware setup]({{< relref
"/docs/examples/kitty/hardware" >}}).

## Building

### Acquire source code

```sh
git clone https://github.com/au-ts/lionsos.git
cd lionsos
```

### Dependencies

Run the following commands depending on your machine:
{{< tabs "dependencies" >}}
{{< tab "Ubuntu/Debian" >}}
```sh
sudo apt update && sudo apt install make clang lld device-tree-compiler unzip git
```
{{< /tab >}}
{{< tab "macOS" >}}
```sh
# Make sure that you add the LLVM bin directory to your path.
# For example:
# echo export PATH="/opt/homebrew/Cellar/llvm/16.0.6/bin:$PATH" >> ~/.zshrc
# Homebrew will print out the correct path to add
brew install make dtc llvm
```
{{< /tab >}}
{{< tab "Arch" >}}
```sh
sudo pacman -Sy make clang lld dtc
```
{{< /tab >}}
{{< tab "Nix" >}}
```sh
nix-shell --pure examples/kitty
```
{{< /tab >}}
{{< /tabs >}}

#### Acquire the Microkit SDK

Run the following commands depending on your machine:
{{< tabs "microkit-sdk" >}}
{{< tab "Linux (x64)" >}}

```sh
wget https://trustworthy.systems/Downloads/microkit/microkit-sdk-dev-7c679ea-linux-x86-64.tar.gz
tar xf microkit-sdk-dev-7c679ea-linux-x86-64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (ARM64)" >}}
```sh
wget https://trustworthy.systems/Downloads/microkit/microkit-sdk-dev-7c679ea-macos-aarch64.tar.gz
tar xf microkit-sdk-dev-7c679ea-macos-aarch64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (x64)" >}}
```sh
wget https://trustworthy.systems/Downloads/microkit/microkit-sdk-dev-7c679ea-macos-x86-64.tar.gz
tar xf microkit-sdk-dev-7c679ea-macos-x86-64.tar.gz
```
{{< /tab >}}
{{< /tabs >}}

#### Acquire the AArch64 toolchain

There is a choice of toolchains at [ARM Toolchains](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
We're currently using GCC 12.

{{< tabs "aarch64-toolchain" >}}
{{< tab "Linux (x64)" >}}

```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz?rev=a8bbb76353aa44a69ce6b11fd560142d&hash=20124930455F791137DDEA1F0AF79B10' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
```
{{< /tab >}}
{{< tab "macOS (ARM64)" >}}
```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-arm64-aarch64-none-elf.tar.xz?rev=cc2c1d03bcfe414f82b9d5b30d3a3d0d&hash=FBA1F3807EC2AA946B3170422669D15A' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
```
{{< /tab >}}
{{< tab "macOS (x64)" >}}
```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-x86_64-aarch64-none-elf.tar.xz?rev=78193d7740294ebe8dbaa671bb5011b2&hash=1DF8812C4FFB7B78C589E702CFDE4471' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
```
{{< /tab >}}
{{< /tabs >}}

Then add the `.../arm-gnu-toolchain-12.3.rel1-aarch64-none-elf/bin`
directory to your `PATH`.
```sh
export PATH=$(pwd)/arm-gnu-toolchain-12.3.rel1-aarch64-none-elf/bin:$PATH
```

### Compiling the webserver system

The Kitty system, when running, takes files from an NFSv3 server.  The
address of this server has to be known at build time.

```sh
cd examples/webserver
export MICROKIT_SDK=/path/to/sdk
# IP adddress of NFS server to connect to
export NFS_SERVER=0.0.0.0
# NFS export to mount
export NFS_DIRECTORY=/path/to/dir
# Location of website's static files on NFS export
export WEBSITE_DIR=path/to/website
# Initialise submodules (this will require an internet connection)
make submodules
# Compile the system
make
```

If you need to build a release version of the system:
```sh
make MICROKIT_CONFIG=release
```

## Running

The webserver has several Mac-address endpoints, that need to be known by
several components.  It expects to be run while connected to a network
with a DHCP server that will hand out IPv4 addresses corresponding to
each of the Mac addresses.

As at the time of writing, the MAC addresses are:

| Component   |      MAC       |
|:------------|:--------------:|
| NFS         | 52:54:1:0:0:10 |
| MicroPython | 52:54:1:0:0:11 |

The webserver needs an NFSv3 server, whose address is known at build
time.  Its MicroPython interpreter can import python modules from the
NFS filesystem.  The NFSv3 server has to be set up to export to
whatever IP address the NFS component is given by DHCP.

### Boot

When first booting up the system, if everything works correctly, you
should see something like the following on the serial console:

```sh
micropython: mpnetworkport.c:135:netif_status_callback: DHCP request finished, IP address for netif e0 is: 172.16.1.32
Starting async server on 0.0.0.0:80...
```

At this point, if you visit 172.16.1.32:80, you should be served the
contents of your website. Of course, the actual IP address will depend
on your DHCP server.
