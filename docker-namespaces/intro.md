La tecnología de contenedores hace uso de Linux Namespaces para aislar ("conteneirizar") procesos/servicios.
Esto permite instalar y ejecutar múltiples servicios en un mismo Host sin que exista visibilidad entre ellos. 

La definición de Linux namespace del Manual (RTFM):


```
NAMESPACES(7)             Linux Programmer's Manual            NAMESPACES(7)

NAME
       namespaces - overview of Linux namespaces

DESCRIPTION
       A namespace wraps a global system resource in an abstraction that
       makes it appear to the processes within the namespace that they have
       their own isolated instance of the global resource...

```

Este aislamiento se produce en los siguientes niveles:
- User Namespace.
- Unix Time-Sharing Namespace.
- IPC Namespace.
- Mount Namespace.
- PID Namespace.
- Network Namespace.

