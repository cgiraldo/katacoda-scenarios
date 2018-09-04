
A continuación vamos a dockerizar el comando curl


CONSTRUIR IMAGEN -> `docker build -t curl .`{{execute}}

LANZAR IMAGEN -> `docker run --rm curl`{{execute}}

---

FROM (Dockerfile Best-Practice)

>Whenever possible, use current official repositories as the basis for your images. 
We recommend the Alpine image as it is tightly controlled and small in size (currently under 5 MB), 
while still being a full Linux distribution.

LABEL (Dockerfile Best-Practice)
>You can add labels to your image to help organize images by project, record licensing information, to aid in automation, or for other reasons. For each label, add a line beginning with LABEL and with one or more key-value pairs. The following examples show the different acceptable formats.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
</pre>

`docker inspect curl`{{execute}}          

El sistema Alpine linux cuenta con el gestor de paquetes _apk_ similar a _apt_ de debian/ubuntu o _yum_ de redhat/centos.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8
RUN apk add --no-cache curl
</pre>

Dockerfile Best-Practice
>The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command (and then use CMD as the default flags).

Indicamos como entrypoint el binario _curl_ e indicamos que se utilice parámetro --help como parámetro por defecto.

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8
RUN apk add --no-cache curl
ENTRYPOINT ["curl"]
CMD ["--help"]
</pre>


Utilizando curl con parametros personalizados:

`docker run --rm curl -s wttr.in/~"vigo"`{{execute}}
