
We are going to dockerize `curl` command.

For building the docker image we should run `docker build -t curl .`{{execute}}

For running the curl container we should run `docker run --rm curl`{{execute}}

Give this commands now a try... It does not work as expected! :/

Don´t worry, we will go back to them after working on our Dockerfile!

---

FROM (Dockerfile Best-Practice)

>Whenever possible, use current official repositories as the basis for your images. 
We recommend the Alpine image as it is tightly controlled and small in size (currently under 5 MB), 
while still being a full Linux distribution.

LABEL (Dockerfile Best-Practice)
>You can add labels to your image to help organize images by project, record licensing information, to aid in automation, or for other reasons. For each label, add a line beginning with LABEL and with one or more key-value pairs. The following examples show the different acceptable formats.

```
FROM alpine:3.8
LABEL maintainer="cgiraldo@gradiant.org"
LABEL organization="gradiant.org"
```{{copy}}

Rebuild our docker image! `docker build -t curl .`{{execute}}.

Now It should work. The new curl docker image should be now part of our docker local images. Let's check it:
 
`docker image inspect curl`{{execute}}          

Alpine linux's package manager is `apk`, equivalent to debian/ubuntu `apt` or redhat/centos  `yum`.

<pre class="file" data-filename="Dockerfile" data-target="append">RUN apk add --no-cache curl
</pre>

Dockerfile Best-Practice
>The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command (and then use CMD as the default flags).

We set the entrypoint to `curl` and we set `--help` as the default parameter.

<pre class="file" data-filename="Dockerfile" data-target="append">ENTRYPOINT ["curl"]
CMD ["--help"]
</pre>

Now It´s time to rebuild our docker image! `docker build -t curl .`{{execute}}

Remember, we can run a curl container with: `docker run --rm curl`{{execute}}


Let's use our brand-new curl container  to gather useful information from the web:

`docker run --rm curl -s wttr.in/~"vigo"`{{execute}}

Nice!
