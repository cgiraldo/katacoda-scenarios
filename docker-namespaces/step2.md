

## PID Namespaces
En este paso comprobamos que por defecto existe un aislamiento en los procesos lanzados en cada contenedor

- Lanzamos proceso _top_ en T2 `top &`{{execute T2}}

- Lanzamos proceso _sum_ en T3 `sum &`{{execute T3}}

- Lista de procesos de T2 `ps aux`{{execute T2}}

- Lista de procesos de T3 `ps aux`{{execute T3}}


***

Es posible compartir el PID Namespace de dos contenedores. Lanzamos ahora el contenedor T4 compartiendo el PID Namespace con el contenedor T2.

- `docker run -ti --rm --name t4 --pid=container:t2 alpine`{{execute T4}}

- Lanzamos proceso _wc_ en T4 `wc &`{{execute T4}}

- Lista de procesos de T4 `ps aux`{{execute T4}}

- Lista de procesos de T2 `ps aux`{{execute T2}}


