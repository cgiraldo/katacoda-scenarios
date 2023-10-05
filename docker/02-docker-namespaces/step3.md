We are going to check network isolation among containers through Linux Network Namespaces.

We check IP and MAC of t2 container:

- Run in Tab2: `ifconfig`{{execute}}

We check IP and MAC of t3 container:

- Run in Tab3: `ifconfig`{{execute}}

We check IP and MAC of host machine:

- Run in Tab1: `ifconfig`{{execute}}


***
It is possible to share the Network Namespace between two or more containers:

We recreate now t4 container but sharing Network Namespace with t2 container.


- Run in Tab1: `docker rm -f t4`{{execute}}

- Run in Tab4: `docker run -ti --rm --name t4 --net=container:t2 alpine`{{execute}}

We check IP and MAC of t4 container:

- Run in Tab4: `ifconfig`{{execute}}


***

It is even possible to deploy a container sharing the network namespace of the host machine.

We recreate t5 container with this configuration:

- Run in Tab1: `docker rm -f t5`{{execute}}

- Run in Tab5: `docker run -ti --rm --name t5 --net=host alpine`{{execute}}

We check IP and MAC of t5 container:

- Run in Tab5: `ifconfig`{{execute}}

On the other hand, we can check that we keep PID Namespace isolation at containter t5:

- Run in Tab5: `ps`{{execute}}

***
