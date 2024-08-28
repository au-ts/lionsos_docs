+++
title = 'Running (QEMU)'
draft = false
weight = 20
+++

## Running on QEMU

To start QEMU, run the following command in the same place you compiled the system:
```sh
make qemu
```

You should see the following lines at the bottom of your output:
```sh
nfs: nfs.c:47:nfs_connect_cb: connected to nfs server
Starting async server on 0.0.0.0:80...
```

The IP address that the webserver starts on `0.0.0.0:80` is relative to QEMU's internal network,
and is not visible from your host computer.

Instead, for connecting outside of QEMU (e.g in your browser), you want to go to
port 5555 of localhost (e.g `localhost:5555` in your browser).

All traffic from port 5555 of your host computer is routed to port 80 of the webserver program
inside QEMU.
