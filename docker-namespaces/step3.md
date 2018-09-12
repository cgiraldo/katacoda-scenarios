We are going to check network isolation among containers through Linux Network Namespaces.

- We check IP and MAC of t2 container -> `ifconfig`{{execute T2}}

- We check IP and MAC of t3 container -> `ifconfig`{{execute T3}}

- We check IP and MAC of host machine -> `ifconfig`{{execute T1}}


***
It is possible to share the Network Namespace between two or more containers:

We recreate now t4 container but sharing Network Namespace with t2 container.


- `docker rm -f t4`{{execute T1}}

- `docker run -ti --rm --name t4 --net=container:t2 alpine`{{execute T4}}

- We check IP and MAC of t4 container -> `ifconfig`{{execute T4}}



***

It is even possible to deploy a container sharing the network namespace of the host machine.

We recreate t5 container with this configuration:

- `docker rm -f t5`{{execute T1}}

- `docker run -ti --rm --name t5 --net=host alpine`{{execute T5}}

- We check IP and MAC of t5 container -> `ifconfig`{{execute T5}}

On the other hand, we can check that we keep PID Namespace isolation at containter t5:

- Process list at t5 container -> `ps`{{execute T5}}

***
