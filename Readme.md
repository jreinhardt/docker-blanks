Blank Docker Container for Ansible Provisioning
===============================================

This repository contains Dockerfiles for creating containers that are suitable
for provisioning using Ansible. So it basically (ab)uses docker container as a
simple way to spin up empty machines, and uses ansible for everything else.

They are based on this example
https://docs.docker.com/engine/examples/running_ssh_service/

This is not a typical use case for containers, and it may or may not be a good
idea. People wrote about why you shouldn't use need to use ssh for your
containers, e.g.
https://blog.docker.com/2014/06/why-you-dont-need-to-run-sshd-in-docker/

Build image
-----------
docker build -t ansible .

Start container
---------------
docker run -d -P --name ansible1 ansible
