+++
title = 'Running'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

The Kitty has several Mac-address endpoints, that need to be known by
several components.  It expects to be run while connected to a network
with a DHCP server that will hand out IPv4 addresses corresponding to
each of the Mac addresses.

As at the time of writing, the MAC addresses are:

| Component   |      MAC       |
|:------------|:--------------:|
| NFS         | 52:54:1:0:0:10 |
| microPython | 52:54:1:0:0:11 |

The Kitty needs an NFSv3 server, whose address is known at build
time.  Its micropython interpreter can import python modules from the
NFS filesystem.  The NFSv3 server has to be set up to export to
whatever IP address the NFS component is given by DHCP.


# Running

When first booting up the system you will see the MicroPython REPL
prompt on the serial console:
```sh
MP|INFO: initialising!
MicroPython v1.20.0-328-g01c758e26 on 2023-12-19; Odroid-C4 with Cortex A55
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

## Accessing the network

TODO
