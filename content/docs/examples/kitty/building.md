+++
title = 'Building'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Building the Kitty system

## Acquire source code

```sh
git clone https://github.com/au-ts/lionsos.git
cd lionsos
```

## Dependencies

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
nix-shell
```
{{< /tab >}}
{{< /tabs >}}

### Acquire the Microkit SDK

Run the following commands depending on your machine:
{{< tabs "microkit-sdk" >}}
{{< tab "Linux (x64)" >}}

```sh
wget https://github.com/seL4/microkit/releases/download/1.4.1/microkit-sdk-1.4.1-linux-x86-64.tar.gz
tar xf microkit-sdk-1.4.1-linux-x86-64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (ARM64)" >}}
```sh
wget https://github.com/seL4/microkit/releases/download/1.4.1/microkit-sdk-1.4.1-macos-aarch64.tar.gz
tar xf microkit-sdk-1.4.1-macos-aarch64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (x64)" >}}
```sh
wget https://github.com/seL4/microkit/releases/download/1.4.1/microkit-sdk-1.4.1-macos-x86-64.tar.gz
tar xf microkit-sdk-1.4.1-macos-x86-64.tar.gz
```
{{< /tab >}}
{{< /tabs >}}

### Acquire the AArch64 toolchain

There is a choice of toolchains at [ARM Toolchains](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
We're currently using GCC 12.

{{< tabs "aarch64-toolchain" >}}
{{< tab "Linux (x64)" >}}

```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz?rev=a8bbb76353aa44a69ce6b11fd560142d&hash=20124930455F791137DDEA1F0AF79B10' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
export PATH=$(pwd)/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf/bin:$PATH
```
{{< /tab >}}
{{< tab "macOS (ARM64)" >}}
```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-arm64-aarch64-none-elf.tar.xz?rev=cc2c1d03bcfe414f82b9d5b30d3a3d0d&hash=FBA1F3807EC2AA946B3170422669D15A' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
export PATH=$(pwd)/arm-gnu-toolchain-12.3.rel1-darwin-arm64-aarch64-none-elf/bin:$PATH
```
{{< /tab >}}
{{< tab "macOS (x64)" >}}
```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-x86_64-aarch64-none-elf.tar.xz?rev=78193d7740294ebe8dbaa671bb5011b2&hash=1DF8812C4FFB7B78C589E702CFDE4471' \
    -O arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-aarch64-none-elf.tar.xz
export PATH=$(pwd)/arm-gnu-toolchain-12.3.rel1-darwin-x86_64-aarch64-none-elf/bin:$PATH
```
{{< /tab >}}
{{< /tabs >}}

## Compiling the Kitty system

The Kitty system, when running, takes files from an NFSv3 server.  The
address of this server has to be known at build time.

```sh
cd examples/kitty
# IP adddress of NFS server to connect to
export NFS_SERVER=0.0.0.0
# NFS directory to mount
export NFS_DIRECTORY=/path/to/dir
export MICROKIT_SDK=/path/to/sdk
# Initialise submodules
make submodules
# Compile the system
make
```

If you need to build a release version of the system:
```sh
make MICROKIT_CONFIG=release
```
