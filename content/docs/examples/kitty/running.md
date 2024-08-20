+++
title = 'Running'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Running

The Kitty has several Mac-address endpoints, that need to be known by
several components.  It expects to be run while connected to a network
with a DHCP server that will hand out IPv4 addresses corresponding to
each of the Mac addresses.

As at the time of writing, the MAC addresses are:

| Component   |      MAC       |
|:------------|:--------------:|
| NFS         | 52:54:1:0:0:10 |
| MicroPython | 52:54:1:0:0:11 |

The Kitty needs an NFSv3 server, whose address is known at build
time.  Its MicroPython interpreter can import python modules from the
NFS filesystem.  The NFSv3 server has to be set up to export to
whatever IP address the NFS component is given by DHCP.

## Boot

When first booting up the system you will see the MicroPython REPL
prompt on the serial console:
```sh
MP|INFO: initialising!
MicroPython v1.22.2 on 2023-12-19; Odroid-C4 with Cortex A55
>>>
```

## Accessing the file system

Below is an example of accessing the file system mounted via NFS.

```python
>>> import os
>>> os.listdir()
[]
>>> with open('hello.py') as f:
...     f.write('print("hello world")\n')
... 
21
>>> os.listdir()
['hello.py']
>>> with open('hello.py') as f:
...     print(f.read())
... 
print("hello world")

>>> import hello
hello world
>>> os.remove('hello.py')
>>> os.listdir()
[]
```

<!-- ## Accessing the network

TODO -->

## Running the Kitty example
First, you must run the Kitty server script. This script can be
found in `examples/kitty/server`. To run please do the following:
```sh
cd examples/kitty/server
python3 server.py
```
You will need to supply the IP address of the machine that you are running the
server on to the Kitty program. If you are running the Kitty example on QEMU, and
running the server on your host machine, then use the IP address `10.0.2.2`.
This is the gateway IP address from QEMU to your host machine.

Below is an example of running the Kitty example.

```python
>>> import kitty

Welcome to Kitty!
Usage: kitty.run(String IP_ADDRESS, bool I2C_ENABLE, bool NFS_ENABLE, int DISPLAY_WIDTH, int DISPLAY_HEIGHT).
        IP_ADDRESS: The IP address of the kitty server.
        I2C_ENABLE: True if I2C device is enabled, False otherwise.
        NFS_ENABLE: True if NFS is available, False otherwise.
        DISPLAY_WIDTH: The width of the display.
        DISPLAY_HEIGHT: The height of the display.
>>> kitty.run("10.0.2.2", False, True, 1920, 1080)
```