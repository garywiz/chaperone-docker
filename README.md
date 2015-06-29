# Ubuntu Docker images which use the Chaperone process manager

This repository is used to build two base-iamges which use the
[Chaperone](http://garywiz.github.io/chaperone/guide/chap-intro.html) lightweight process manager.

Two images are included:

 * chaperone-baseimage (A framework for Chaperone-based development.  On
   [Docker Hub as chaperone-baseimage](https://registry.hub.docker.com/u/chapdev/chaperone-baseimage).
 * chaperone-lamp (A LAMP image managed by Chaperone.  On
   [Docker Hub as chaperone-lamp](https://registry.hub.docker.com/u/chapdev/chaperone-lamp).
 * chaperone-lemp (A LEMP image with Nginx instead of Apache, managed by Chaperone.  On
   [Docker Hub as chaperone-lemp](https://registry.hub.docker.com/u/chapdev/chaperone-lemp).
 * chaperone-apache (An Apache-only image, managed by Chaperone.  On
   [Docker Hub as chaperone-lemp](https://registry.hub.docker.com/u/chapdev/chaperone-apache).
   
Chaperone is a lightweight process manager specifically designed as an ENTRYPOINT for Docker containers that runs as PID 1.  As a single
controlling process, it provides:

  * Dependency based [parallel start-up of services](http://garywiz.github.io/chaperone/ref/config-service.html).
  * [Built in syslog implementation](http://garywiz.github.io/chaperone/ref/config-logging.html), which listens on /dev/log and allows
    flexible redirection of all log output to docker stdout, or simultaneously
    to log files.
  * Support for ``systemd`` NOTIFY process types with in-container emulation of notify sockets to
	better manage process life-cycles.
  * PID cleanup, environment variable control, docker-friendly command line options, many many more features.

Chaperone's philosphy is to simplify management of multi-process containers and consolidate everything a container needs
in a single, compact process.

The [Reference Documentation for Chaperone](http://garywiz.github.io/chaperone/ref/index.html) is complete, and
more examples and Docker usage information is on the way.

Chaperone is newly developed, so keep in mind that this is currently in Beta and we would not recommend these images
for production.  *Please* [submit issues](https://github.com/garywiz/chaperone-docker/issues) if you have any problems or suggestions!

## Try it out

To get a quick idea of how things work, try the LAMP image and create your own userspace development directory.
It's best if you do this *as a normal user* that is a member of the docker group, since that will give you a good
idea of how the userspace development model works.

First, get the `chaplocal` script, a quick script which allows you to create userspace development "home directories":

    docker run -i --rm=true chapdev/chaperone-lamp --task get-chaplocal | sh

You now have a script in your current directory called ``chaplocal``.
Use it to create a new LAMP development directory:

    ./chaplocal test-app

Once you do, you'll be put into the container in a bash shell.  You can inspect the running environment,
and note how all files, including log files, databases, and development directories are part of your
shared mount point, all running under your user ID.   When production images are required, a
`build.sh` script inside the `test-app` directory will let you capture your development files
and package them in an image which will run your application.

You can also see a quick overview of the services running by going to the sample site at http://localhost:8080
(where localhost is whatever you've called your docker host machine).

We still have more work to do on these images, and feedback would be great.  This approach
has solved a lot of problems for us.

## License

Copyright (c) 2015, Gary J. Wisniewski <garyw@blueseastech.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
