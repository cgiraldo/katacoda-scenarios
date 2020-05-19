We are going to check process ID isolation between containers through the use of PID namespaces.

- We execute process _top_ in t2 container -> `top &`{{execute T2}}

- We execute process _sum_ in t3 container -> `sum &`{{execute T3}}

- Process list at t2 container -> `ps`{{execute T2}}

- Process list at t3 container -> `ps`{{execute T3}}

- Process list at host machine -> `ps`{{execute T1}}


***

We can share PID Namespace between two containers.

We deploy now container t4 sharing the PID Namespace with container t2:

- `docker run -ti --rm --name t4 --pid=container:t2 alpine`{{execute T4}}

- We execute process _wc_ in t4 container -> `wc &`{{execute T4}}

- Process list at t4 container -> `ps`{{execute T4}}

- Process list at t2 container -> `ps`{{execute T2}}

- Process list at host machine -> `ps`{{execute T1}}

***
It is even possible to not isolate PIDs at the container and share the PID Namespace of the host machine. 

- `docker run -ti --rm --name t5 --pid=host alpine`{{execute T5}}

- We execute process _dc_ in T5 container -> `dc &`{{execute T5}}

- Process list at host machine -> `ps`{{execute T1}}

- Process list at t5 container -> `ps`{{execute T5}}

Alpine-linux's default `ps` command is from busybox and list all processes by default.
To install typical `ps` command -> `apk add --no-cache ps`{{execute T5}}. This ps command only list processes with a tty by default. 





