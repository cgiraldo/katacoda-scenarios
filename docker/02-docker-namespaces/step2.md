We are going to check process ID isolation between containers through the use of PID namespaces.

- We execute process _top_ in t2 container (Tab2) -> `top &`{{execute}}

- We execute process _sum_ in t3 container (Tab3) -> `sum &`{{execute}}

- Process list at t2 container (Tab2) -> `ps`{{execute}}

- Process list at t3 container (Tab3) -> `ps`{{execute}}

- Process list at host machine (Tab1) -> `ps`{{execute}}


***

We can share PID Namespace between two containers.

Create a new tab (Tab4) and deploy a new container t4 sharing the PID Namespace with container t2:

- Run in Tab4: `docker run -ti --rm --name t4 --pid=container:t2 alpine`{{execute}}

- We execute process _wc_ in t4 container (Tab4) -> `wc &`{{execute}}

- Process list at t4 container (Tab4) -> `ps`{{execute}}

- Process list at t2 container (Tab2) -> `ps`{{execute}}

- Process list at host machine (Tab1) -> `ps`{{execute}}

***
It is even possible to not isolate PIDs at the container and share the PID Namespace of the host machine.

Create a new tab (Tab5) a new container t5 sharing the PID Namespace with the host machine:

- Run in Tab5: `docker run -ti --rm --name t5 --pid=host alpine`{{execute}}

- We execute process _dc_ in T5 container (Tab5) -> `dc &`{{execute}}

- Process list at host machine (Tab1) -> `ps`{{execute}}

- Process list at t5 container (Tab5) -> `ps`{{execute}}

Alpine-linux's default `ps` command is from busybox and list all processes by default.

Install complete `ps` command:

- Run in Tab5: `apk add --no-cache ps`{{execute}}. 

This ps command only list processes with a tty by default. 
