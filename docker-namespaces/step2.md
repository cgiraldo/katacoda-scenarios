

## PID Namespaces
En este paso comprobamos que por defecto existe un aislamiento en los procesos lanzados en cada contenedor

- Lanzamos proceso _top_ en T2 `top &`{{execute T2}}

- Lanzamos proceso _sum_ en T3 `sum &`{{execute T3}}

- Lista de procesos de T2 `ps`{{execute T2}}

- Lista de procesos de T3 `ps`{{execute T3}}

- Lista de procesos en el HOST `ps`{{execute T1}}


***

Es posible compartir el PID Namespace de dos contenedores. Lanzamos ahora el contenedor T4 compartiendo el PID Namespace con el contenedor T2.

- `docker run -ti --rm --name t4 --pid=container:t2 alpine`{{execute T4}}

- Lanzamos proceso _wc_ en T4 `wc &`{{execute T4}}

- Lista de procesos de T4 `ps`{{execute T4}}

- Lista de procesos de T2 `ps`{{execute T2}}

- Lista de procesos en el HOST `ps`{{execute T1}}

***

Es posible incluso no aislar los PIDs del contenedor y que comparta el PID Namespace del Host

- `docker run -ti --rm --name t5 --pid=host alpine`{{execute T5}}

- Lanzamos proceso _dc_ en T5 `dc &`{{execute T5}}

- Lista de procesos de T5 `ps`{{execute T5}}

- Lista de procesos del host `ps`{{execute T1}}



