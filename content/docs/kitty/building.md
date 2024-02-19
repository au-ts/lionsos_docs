+++
title = 'Building'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Building the Kitty system

{{< hint danger >}}
Building on macOS is currently having issues, please follow instructions for Linux in the meantime.
{{< /hint >}}

## Acquire source code
(this takes around 1.7Gb to download)

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

### Acquire the AArch64 toolchain

There is a choice of toolchains at [ARM Toolchains](https://developer.arm.com/downloads/-/arm-gnu-toolchain-downloads)
We're currently using GCC 12.

For Linux, run the following commands:
```sh
wget 'https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz?rev=a8bbb76353aa44a69ce6b11fd560142d&hash=20124930455F791137DDEA1F0AF79B10' \
    -O arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz
tar xf arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf.tar.xz
```

For MacOSX the URLs are
https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-x86_64-aarch64-none-elf.tar.xz?rev=78193d7740294ebe8dbaa671bb5011b2&hash=1DF8812C4FFB7B78C589E702CFDE4471
for X86, and https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-darwin-arm64-aarch64-none-elf.tar.xz?rev=cc2c1d03bcfe414f82b9d5b30d3a3d0d&hash=FBA1F3807EC2AA946B3170422669D15A
for Apple ARM.

Then add the `.../arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf/bin`
directory to your `PATH`.
```sh
export PATH=$(pwd)/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-elf/bin:$PATH
```
## Compiling the Kitty system

The Kitty system, when running, takes files from an NFSv3 server.  The
address of this server has to be known at build time.

```sh
cd examples/kitty
# Configuration for the NFS server
export NFS_SERVER=0.0.0.0 # IP adddress of NFS server
export NFS_DIRECTORY=/path/to/dir # NFS directory to mount
# Define path to libgcc, where $GCC is the GCC toolchain downloaded above
export LIBGCC=$(dirname $(realpath $(aarch64-none-elf-gcc --print-file-name libgcc.a)))
make MICROKIT_SDK=/path/to/sdk -j$(nproc)
```

If you need to build a release version of the system:
```sh
make MICROKIT_SDK=/path/to/sdk MICROKIT_CONFIG=release -j$(nproc)
```
