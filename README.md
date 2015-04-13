#What the hell is this?
This project shows how docker and nginx can be used to hot swap two versions of a web app.

We have `flask` and `flask2` pretend for a second that `flask2` is your new code base.

What we want to do is swap from the old code to the new code without suffering any down time.
Both apps will be running via Gunicorn to make a graceful shutdown simple.

All the commands are done via a Makefile because at this point fig/whatever it is now, isn't suitable.

## Testing

- run `make build` to build the three images
- run `make run` to start nginx and flask and link them togehter
- curl the root url and you should get back `Hello, World!`
- you can run `consume.sh` to continue pinging the page as fast as it can (or use your own tool)
- while that's running run `make swap` to swap in the new container

## Bugs etc
Report them if you find them.

This was build with (boot2docker):
-Client version: 1.5.0
-Client API version: 1.17
-Go version (client): go1.4.1
-Git commit (client): a8a31ef
-OS/Arch (client): darwin/amd64
-Server version: 1.5.0
-Server API version: 1.17
-Go version (server): go1.4.1
-Git commit (server): a8a31ef

If you're suing boot2docker make sure your ports are exposed via VirtualBox
`VBoxManage modifyvm "boot2docker-vm" --natpf1 "tcp-port8000,tcp,,8000,,8000";`
I'll endevour to keep this updated.

