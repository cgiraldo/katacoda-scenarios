La tecnología de contenedores hace uso de varias características presentes en los últimos kernel de Linux que permiten aislar ("conteneirizar") procesos. Esto permite instalar y ejecutar múltiples servicios en un mismo Host sin que exista visibilidad entre ellos. Este aislamiento se produce en los siguientes niveles:
- User Namespace.
- Unix Time-Sharing Namespace.
- IPC Namespace.
- Mount Namespace.
- PID Namespace.
- Network Namespace.

## Creación del entorno de pruebas

El terminal **T1** nos da acceso al Host donde se lanzan los contenedores, y lo utilizaremos principalmente para gestionar los contenedores mediante el CLI de docker.
Los terminal **T2** y **T3** dan acceso a dos contenedores independientes que lanzaremos en el host. 

Lanzamiendo de los contenedores en modo _terminal interactivo_

`docker run -ti --rm --name t2 alpine`{{execute T2}}
`docker run -ti --rm --name t3 alpine`{{execute T3}}

`docker ps`{{execute T1}}

### PID Namespaces
Comprobamos que por defecto existe un aislamiento en los procesos lanzados en cada contenedor

`top &`{{execute T2}}
`yes &`{{execute T3}}

`ps -aux`{{execute T2}}
`ps -aux`{{execute T3}}

Es posible compartir el PID Namespace de dos contenedores. El contenedor T4 comparte el PID Namespace con el T2.

`docker run -ti --rm --name t4 --pid=container:t2 alpine`{{execute T4}}
`ps -aux` {{execute T4}}
`yes &` {{execute T4}}
`ps -aux` {{execute T4}}
`ps -aux` {{execute T2}}


