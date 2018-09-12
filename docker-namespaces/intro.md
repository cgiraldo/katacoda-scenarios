Docker relies on Linux Namespaces to isolate processes in containers.

With Docker you can install and execute multiple services in the same host but without visibility among them.

Linux Namespaces definition from the Linux Man Pages (RTFM):


```
NAMESPACES(7)             Linux Programmer's Manual            NAMESPACES(7)

NAME
       namespaces - overview of Linux namespaces

DESCRIPTION
       A namespace wraps a global system resource in an abstraction that
       makes it appear to the processes within the namespace that they have
       their own isolated instance of the global resource...

```

This isolation can be at the next levels:
- User Namespace.
- Unix Time-Sharing Namespace.
- IPC Namespace.
- Mount Namespace.
- PID Namespace.
- Network Namespace.

