We will use three Tabs: Press '+' to create the tabs.

- Tab1 will be a shell at the host machine to manage containers through the docker CLI.

- Tab2 will open a terminal in container t2.

- Tab3 will open a terminal in container t3.


Let's create t2 and t3 container in interactive mode (`-ti`):

- Run in Tab2: `docker run -ti --rm --name t2 alpine`{{execute}}

- Run in Tab3: `docker run -ti --rm --name t3 alpine`{{execute}}


We can list the running containers:

- Run in Tab1: `docker ps`{{execute}}



