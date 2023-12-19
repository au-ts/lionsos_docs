+++
title = 'Getting started'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Building the Kitty system

{{< hint danger >}}
Building on macOS is currently having issues, please follow instructions for Linux in the meantime.
{{< /hint >}}

## Acquire source code

```sh
git clone git@github.com:au-ts/LionsOS.git
cd LionsOS
git submodule update --init
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
brew install make llvm dtc
# Add LLD to PATH
echo export PATH="/opt/homebrew/Cellar/llvm/16.0.6/bin:$PATH" >> ~/.zshrc
source ~/.zshrc
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

### Acquire the Microkit SDK

Run the following commands depending on your machine:
{{< tabs "microkit-sdk" >}}
{{< tab "Linux (x64)" >}}
```sh
wget https://trustworthy.systems/Downloads/lionsos/microkit-sdk-linux-x64.tar.gz
tar xf microkit-sdk-linux-x64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (ARM64)" >}}
```sh
wget https://trustworthy.systems/Downloads/lionsos/microkit-sdk-macos-arm64.tar.gz
tar xf microkit-sdk-macos-arm64.tar.gz
```
{{< /tab >}}
{{< tab "macOS (x64)" >}}
```sh
wget https://trustworthy.systems/Downloads/lionsos/microkit-sdk-macos-x64.tar.gz
tar xf microkit-sdk-macos-x64.tar.gz
```
{{< /tab >}}
{{< /tabs >}}

### Acquire the AArch64 toolchain

Run the following commands:
```sh
wget https://developer.arm.com/-/media/Files/downloads/gnu-a/10.2-2020.11/binrel/gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz?revision=79f65c42-1a1b-43f2-acb7-a795c8427085&hash=61BBFB526E785D234C5D8718D9BA8E61
tar xf gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf.tar.xz\?revision=79f65c42-1a1b-43f2-acb7-a795c8427085\&hash=61BBFB526E785D234C5D8718D9BA8E61
```

Then add the `gcc-arm-10.2-2020.11-x86_64-aarch64-none-elf/bin` directory to your `PATH`.

## Compiling the Kitty system

```sh
cd examples/kitty
# Configuration for the NFS server
export NFS_SERVER=0.0.0.0 # IP adddress of NFS server
export NFS_DIRECTORY=/path/to/dir # NFS directory to mount
# Define path to libgcc, where $GCC is the GCC toolchain downloaded above
export LIBGCC=$GCC/lib/gcc/aarch64-none-elf/11.3.1
make MICROKIT_SDK=/path/to/sdk -j$(nproc)
```

If you need to build a release version of the system:
```sh
make MICROKIT_SDK=/path/to/sdk MICROKIT_CONFIG=release -j$(nproc)
```
