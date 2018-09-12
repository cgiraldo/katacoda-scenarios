Next we are going to dockerize NGINX service.  

Again, we set the docker reference image to Alpine Linux.

<pre class="file" data-filename="Dockerfile" data-target="replace">FROM alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
</pre>

The nginx service ca be installed in Alpine withe the `apk` package manager.

<pre class="file" data-filename="Dockerfile" data-target="append">
RUN apk add --no-cache nginx 
RUN mkdir -p /run/nginx </pre>

We should include a diferent default configuration ti set the path to the static content to _/usr/share/nginx/html_.

COPY
> Although ADD and COPY are functionally similar, generally speaking, COPY is preferred. That’s because it’s more 
transparent than ADD. COPY only supports the basic copying of local files into the container, while ADD has some 
features (like local-only tar extraction and remote URL support) that are not immediately obvious. Consequently, 
the best use for ADD is local tar file auto-extraction into the image, as in ADD rootfs.tar.xz /.

The new configuration is written in the host file _nginx.vh.default.conf_. We use COPY instruction to add this host file
to the docker image:

<pre class="file" data-filename="Dockerfile" data-target="append">
COPY nginx/nginx.vh.default.conf /etc/nginx/conf.d/default.conf
RUN mkdir -p /usr/share/nginx/html</pre>


### Contenido estático 
We can also add the static content we want serve (index.html)to serve in the image through the COPY instruction,
however It is not recommended by the Dockerfile best-practices:

>Create ephemeral containers
The image defined by your Dockerfile should generate containers that are as ephemeral as possible. By “ephemeral,” 
we mean that the container can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up 
and configuration.

The best way to configure the static content of our web is through a volume. In such a way all container will use the 
same docker images and will provide diferent static content through volumes.
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

Every RUN, COPY and ADD instruction add a new ufs layer to the docker image. 
We will apply these best-practices:

>Minimize the number of layers

>Split long or complex RUN statements on multiple lines separated with backslashes to make your Dockerfile more
 readable, understandable, and maintainable.

So our final Dockerfile is as follows:

<pre class="file" data-filename="Dockerfile" data-target="replace">
FROM alpine:3.8

RUN apk add --no-cache nginx && \
    mkdir -p /run/nginx/ && \
    mkdir -p /usr/share/nginx/html
COPY nginx/nginx.vh.default.conf /etc/nginx/conf.d/default.conf
VOLUME /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
</pre>

Now It is time to build our _nginx_ docker image:

`docker build -t mynginx .`{{execute}}

And running the nginx container to serve content from the _static/_ host path.

`docker run -d -v /root/static/:/usr/share/nginx/html/ -p 80:80 mynginx`{{execute}}

Render port 80: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

