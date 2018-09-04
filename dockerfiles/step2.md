A continuación vamos a dockerizar el servicio nginx.  

De nuevo comenzamos el Dockerfile a partir de la imagen de referencia de Alpine.
<pre class="file" data-filename="Dockerfile" data-target="replace">FROM alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
</pre>

El servicio nginx puede instalarse en Alpine mediante su sistema de paquetes _apk_.

<pre class="file" data-filename="Dockerfile" data-target="append">
RUN apk add --no-cache nginx 
RUN mkdir -p /run/nginx </pre>


Vamos a incluir una configuración por defecto diferente a la que vienen en el paquete nginx de Alpine, para indicar 
que se servirá contenido estático desde la ruta _/usr/share/nginx/html_.

COPY
> Although ADD and COPY are functionally similar, generally speaking, COPY is preferred. That’s because it’s more 
transparent than ADD. COPY only supports the basic copying of local files into the container, while ADD has some 
features (like local-only tar extraction and remote URL support) that are not immediately obvious. Consequently, 
the best use for ADD is local tar file auto-extraction into the image, as in ADD rootfs.tar.xz /.

Esta configuración se encuentra en el fichero nginx.vh.default.conf por lo que utilizamos la instrucción COPY para 
añadir ficheros del host a la imagen docker que estamos construyendo.

<pre class="file" data-filename="Dockerfile" data-target="append">
COPY nginx/nginx.vh.default.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /usr/share/nginx/html</pre>


### Contenido estático 
Para incluir el contenido estáticoservir index.html. Puede incluirse en nuestra imagen Docker a través de la directiva COPY, 
pero las Dockerfile best-practices no lo recomiendan:

>Create ephemeral containers
The image defined by your Dockerfile should generate containers that are as ephemeral as possible. By “ephemeral,” 
we mean that the container can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up 
and configuration.

La mejor forma de configurar contenido estático en nuestra imagen es a través de un volumen.
VOLUME
>The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders 
created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable 
parts of your image.

<pre class="file" data-filename="Dockerfile" data-target="append">
VOLUME /usr/share/nginx/html</pre>

EXPOSE

>The EXPOSE instruction indicates the ports on which a container listens for connections. Consequently, you should 
use the common, traditional port for your application. For example, an image containing the Apache web server would 
use EXPOSE 80, while an image containing MongoDB would use EXPOSE 27017 and so on.

<pre class="file" data-filename="Dockerfile" data-target="append">
EXPOSE 80</pre>

CMD
>The CMD instruction should be used to run the software contained by your image, along with any arguments. CMD should 
almost always be used in the form of CMD [“executable”, “param1”, “param2”…]. Thus, if the image is for a service,
 such as Apache and Rails, you would run something like CMD ["apache2","-DFOREGROUND"]. Indeed, this form of the 
 instruction is recommended for any service-based image.


<pre class="file" data-filename="Dockerfile" data-target="append">
CMD ["nginx", "-g", "daemon off;"]
</pre>

Cada instrucción RUN, COPY y ADD añade una capa a la imagen de docker. 
Podemos seguir las siguientes dos recomendaciones

>Minimize the number of layers

>Split long or complex RUN statements on multiple lines separated with backslashes to make your Dockerfile more
 readable, understandable, and maintainable.

Quedando el Dockerfile final de la siguiente manera:

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8

RUN apk add --no-cache nginx &&\
    mkdir -p /usr/share/nginx/html
COPY nginx/nginx.vh.default.conf /etc/nginx/conf.d/default.conf
VOLUME /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
</pre>

Para construir la imagen de _ngninx_ indicamos al comando _docker build_ el nuevo contexto

`docker build -t mynginx nginx_context`{{execute}}

`docker run -d nginx`{{execute}}

