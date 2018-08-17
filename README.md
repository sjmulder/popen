popen
=====

Open a process with a named pipe.


Synopsis
--------

**popen** [_-V_] _program_ [_arguments_ ...]


Installation
------------

From source: tweak the Makefile, then:

    $ make
    $ make install

The install step may need to be run as root. Uninstall with `make uninstall`.


Description
-----------

**popen** starts the _program_ with any given _arguments_,
redirecting its standard output to a newly created named pipe.
The path to the named pipe is printed to standard output
before the redirection is applied:

    $ popen ls
    /tmp/tmp.0.BrR4L2yzE

The pipe can then be read from by another process:

    $ cat /tmp/tmp.0.BrR4L2yzE
    foo.txt
    bar.txt

Note that the process waits until the pipe is opened for reading.

The only supported option is _-V_,
which will make **popen** print its version number and exit.


Examples
-------

One use of **popen** is as a poor man's version of the
[bash(1)](http://linux.die.net/man/1/bash) process substitution feature,
allowing one to use the output of a process where a filename is expected.
For example, this compares the file listing of two directories:

    $ diff -u $(popen ls foo/) $(popen ls bar/)
    [...]
      one.txt
     -two.txt
     +three.txt

The equivalent _ bash(1)_ command line would be:

    $ diff -u <(ls foo/) <(ls bar/)


See also
--------

[bash(1)](http://linux.die.net/man/1/bash),
[mkfifo(1)](https://man.openbsd.org/mkfifo.1),
[mkfifo(2)](https://man.openbsd.org/mkfifo.2),
[popen(3)](https://man.openbsd.org/popen.3)


Author
------

Sijmen J. Mulder (<ik@sjmulder.nl>).


Caveats
-------

There is no write mode
with the pipe connecteed to the standard input of the process.
Such a mode would be severely limited
by the inability to use standard output,
which must be closed in order to unblock the shell.
