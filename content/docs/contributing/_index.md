---
weight: 100
bookFlatSection: false
title: "Contributing"
---

# Contributing

All the LionsOS code is available on Github under an open-source
licence.

Key repositories are

 1. https://github.com/au-ts/LionsOS --- the main repository.
 1. https://github.com/au-ts/sDDF --- the seL4 Device Driver framework
 1. https://github.com/au-ts/libvmm --- the virtual machine monitor
    library
 1. https://github.com/au-ts/lionsOS_docs --- documentation and tutorials

To contribute, first get the examples working.  Then generate pull
requests to the appropriate repository.

# General Guidelines

We use the same conventions as the seL4 project.
 *  [Style Guide](https://docs.sel4.systems/processes/style-guide.html)
 *  [Git Conventions](https://docs.sel4.systems/processes/git-conventions.html)
 *  [Code of Conduct](https://docs.sel4.systems/processes/conduct.html)
 *  [Pull requests](PullRequests)

Please read and abide by these --- especially the Code of Conduct.

# Areas of contribution

## Documentation
If you try LionsOS and blog or vlog about it, please tell us via the
devel@sel4.systems email list.  Noteworthy blogs will be linked from
our site(s).

If you find issues (things that are documented wrong, missing
documentation, or are confusing) raise issues in the appropriate
repository, and/or generate pull requests to fix the issue.
That includes pull requests to the
[Documentation](https://github.com/au-ts/lionsOS_docs) repository.

## Drivers and Virtualisers
New drivers and virtualisers are welcomed.  These will generally be
contributed via pull requests to the
[sDDF](https://github.com/au-ts/sDDF) repository. 

As drivers are not of much use on their own, please add in addition to
the driver, an example that uses it, and CI rules to test it, at least
to the 'it builds cleanly' stage.  The example can either be in the
LionsOS examples directory, or in the sDDF examples directory.

## Complete Systems
The intention is that (eventually) LionsOS systems can be built
entirely out-of-tree.  If you build an open-source LionsOS-based
system, please add a link to the documentation by submitting a PR to
the [LionsOS docs](https://github.com/au-ts/LionsOS_docs) repository.

# Getting Help
LionsOS was built and is supported by a small team at UNSW, Sydney.
We try to respond to queries on the devel@sel4.systems mailing list
(sign up at
https://lists.sel4.systems/postorius/lists/devel.sel4.systems/ ) and
via the [seL4
mattermost](https://mattermost.trustworthy.systems/seL4-external) chat
server.




