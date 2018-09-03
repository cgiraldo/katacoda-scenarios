En este paso comprobamos que por defecto existe un aislamiento en la red de cada contenedor.

- Comprobamos la IP y la MAC del contenedor T2 `ifconfig`{{execute T2}}

- Comprobamos la IP y la MAC del contenedor T3 `ifconfig`{{execute T3}}

- Comprobamos la IP y la MAC del HOST `ifconfig`{{execute T1}}


***

Es posible compartir el Network Namespace de dos contenedores.
Recreamos ahora el contenedor T4 compartiendo el Network Namespace con el contenedor T2.

- `docker rm -f t4`{{execute T1}}

- `docker run -ti --rm --name t4 --net=container:t2 alpine`{{execute T4}}

- Comprobamos la IP y la MAC del contenedor T4 `ifconfig`{{execute T4}}



***

Es posible incluso no aislar la pila de red del contenedor y que comparta el Network Namespace del Host.
Recreamos el contenedor T5 con esa configuración.

- `docker rm -f t5`{{execute T1}}

- `docker run -ti --rm --name t5 --net=host alpine`{{execute T5}}

- Comprobamos la IP y la MAC del contenedor T5 `ifconfig`{{execute T5}}

- Comprobamos la IP y la MAC del HOST `ifconfig`{{execute T1}}

***
