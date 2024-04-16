---
weight: 40
bookFlatSection: false
title: "Tutorials"
---

# Getting Started

To get to the point whre you can do _anything_ with LionsOS you need
to set up a system with toolchain, the LionsOS components, and the
microkit tools.

This section describes how to do that.  It assumes a Debian-like host
(Debian, Ubuntu, Mint, etc).  If you have instructions for a RedHat
derived build system (RedHat, Fedora, CentOS etc), Suse, or ArchLinux,
please generate a pull request against
https://github.com/au-ts/lionsos-docs

## ToolChain
You need a toolchain for your target platform.  LionsOS is for
embedded systems wih a static architecture; it is currently available
only for AARCH64.

The recommended toolchain is from [ARM
Toolchains](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
We're currently using the 12.3 version.

```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz?rev=a8bbb76353aa44a69ce6b11fd560142d&hash=20124930455F791137DDEA1F0AF79B10' \
    -O arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz
```

I usually put the toolchain in `/opt/toolchain`, then add it to my
PATH thus:
```sh
export PATH=/usr/lib/ccache:/opt/toolchain/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf/bin/:$PATH
```
then add symlinks into `/usr/lib/ccache` thus:
```sh
$ cd /usr/lib/ccache
$ sudo ln -s ../../bin/ccache aarch64-linux-gnu-gcc
$ sudo ln -s ../../bin/ccache aarch64-linux-gnu-g++
```

This allows using `ccache` to speed repeat builds.  You can create
symlinks for any other C and C++ compilers you want to use; Debian
puts links there for compilers installed using `apt`.

## The Microkit

For some of the tutorials you will be building the Microkit.  However,
prebuilt versions are available from the [Trustworthy
Systems](https://trustworthy.systems) Download pages; individual
tutorials will tell you the URL to use to fetch the right version for
that tutorial.

The microkit is available from its [Github
repository](https://github.com/seL4/microkit).  Its
[ReadME](https://github.com/seL4/microkit) gives instructions for
building.  Some tutorials use experimental versions of the microkit;
they will tell you which one to pull and build

During the Microkit build process, it also builds an instance of the
seL4 microkernel for each targeted platform.  You can fetch seL4 from
its [Github repository]{https://github.com/seL4/seL4), using the
`microkit` branch until that gets merged.  Particular tutorials may
need a different version of seL4; these will give instructions.

## LionsOS

LionsOS consists of libraries and components for building complete
systems.  To get it, clone its [Github
Repository](https://github.com/au-ts/lionsos) and then update its
submodules (this is around 1.7Gb):
```
git clone git@github.com:au-ts/lionsos.git
cd lionsos
git submodule update --init
```

## Environment Variables
To save typing, the  build system uses some environment variables to
track where things go:

| Variable | Value | Purpose |
|----------|-------|---------|
| LionsOS  | Pathname to top of LionsOS Tree | To find LionsOS components |
| MICROKIT_SDK | Pathname to the Microkit | To find board descriptions, etc |
| PATH     | Where to find executables | Make sure compilers and `${MICROKIT_SDK}/bin` are in the PATH |

