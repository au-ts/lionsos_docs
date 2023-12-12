+++
title = 'Getting started'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# The Kitty system

## Acquire source code

```sh
git clone git@github.com:au-ts/LionsOS.git
cd LionsOS
git submodule update --init
```

## Installing dependencies

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

### Acquiring the Microkit SDK

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

## Compiling the Kitty system

```sh
cd examples/kitty
make MICROKIT_SDK=/path/to/sdk -j$(nproc)
```

If you need to build a release version of the system:
```sh
make MICROKIT_SDK=/path/to/sdk MICROKIT_CONFIG=release -j$(nproc)
```
