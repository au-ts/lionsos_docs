---
weight: 30
bookFlatSection: false
title: "Profiling"
---

# Profiling

In order to determine and analysis the performance of a LionsOS system, we need a systematic
way of recording where CPU time is spent.

We achieve this with a statistical profiler, which means that we take regular samples of the
Performance Monitor Unit (PMU) hardware to determine how much CPU time a particular Protection
Domain (PD) is using.

## Availability

All the work relating to profiling support can be found [here](https://github.com/au-ts/sel4_profiler).

While it is functional and receiving internal use to profiler our systems, it is yet to be properly
integrated with LionsOS. However, getting it integrated is a priority for us.

## Architecture

When you profile a system in LionsOS, there are two extra components involved. There is the PMU
driver itself which manages and controls the PMU hardware and publishes sample data via shared
memory. This data is then consumed by a client that sends the data over the chosen transport.

The transfer of sampling data happens over the standard interfaces of LionsOS' I/O. It is up to
the system designer to configure how they want to transfer the sampling data, right now we have
this working for serial and ethernet devices. This sampling data is recorded by a simple script
that is run on the host system (e.g the developer's machine).

<img src="/profiler_arch.svg" alt="Architecture of a system using the profiler" />
