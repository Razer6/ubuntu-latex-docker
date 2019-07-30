# ubuntu-latex-docker

Dockerfile which installs commonly used packages and tools for working with Latex on top of Ubuntu.

The image is automatically built on every commit via [Docker Hub](https://hub.docker.com/r/nioshd/ubuntu-latex/) and gets deployed as `nioshd/ubuntu-latex:latest`.


## Usage

Simply download the image (i.e., `docker pull nioshd/ubuntu-latex`) from docker hub and launch it with the desired flags. Running `bash` in a temporary container, where the current home is mounted as `/mnt/<username>`, and with the same user ID and group ID as the current user, can for example be achieved using the following command.

```
$ docker run -ti --rm -v /etc/group:/etc/group:ro -v /etc/passwd:/etc/passwd:ro --user=$(id -u):$(id -g) -v ${HOME}:/mnt/${USERNAME} -w /mnt/${USERNAME} nioshd/ubuntu-latex bash
```

If graphical applications should be run inside the container, additionally the xserver has to be exposed to the container. This can be achieved by adding the following parameters to the `docker run` command:

```
-h $(hostname) -e DISPLAY -e XAUTHORITY -v /tmp/.X11-unix:/tmp/.X11-unix -v ${XAUTHORITY}:${XAUTHORITY}
```
