+++
title = 'Running (hardware)'
draft = false
weight = 100
+++

## Running on hardware

The webserver has several Mac-address endpoints, that need to be known by
several components.  It expects to be run while connected to a network
with a DHCP server that will hand out IPv4 addresses corresponding to
each of the Mac addresses.

At the time of writing, the MAC addresses are:

| Component   |      MAC       |
|:------------|:--------------:|
| NFS         | 52:54:1:0:0:10 |
| MicroPython | 52:54:1:0:0:11 |

The webserver needs an NFSv3 server, whose address is known at build
time.  Its MicroPython interpreter can import python modules from the
NFS filesystem.  The NFSv3 server has to be set up to export to
whatever IP address the NFS component is given by DHCP.

### Booting

When first booting up the system, if everything works correctly, you
should see something like the following on the serial console:

```sh
micropython: mpnetworkport.c:135:netif_status_callback: DHCP request finished, IP address for netif e0 is: 172.16.1.32
Starting async server on 0.0.0.0:80...
```

At this point, if you visit `172.16.1.32:80`, you should be served the
contents of your website. Of course, the actual IP address will depend
on your network.
