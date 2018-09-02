La tecnología de contenedores hace uso de varias características presentes en los últimos kernel de Linux que permiten aislar ("conteneirizar") procesos. Esto permite instalar y ejecutar múltiples servicios en un mismo Host sin que exista visibilidad entre ellos. Este aislamiento se produce en los siguientes niveles:
- namespace de procesos.
- namespace de ficheros.
- namespace de red.

## Tarea

Lanzaremos dos contenedores en modo _terminal interactivo_ y comprobamos la independencia de procesos

`docker run -ti alpine`{{execute}}
