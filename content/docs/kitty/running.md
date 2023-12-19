+++
title = 'Running'
date = 2023-12-12T21:00:47+11:00
draft = false
+++

# Running

When first booting up the system you will see the MicroPython REPL prompt:
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
