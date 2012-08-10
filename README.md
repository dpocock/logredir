
The C library syslog() function is typically hard-coded to send
any log messages to the socket /dev/log

In cases where syslog messages have to be captured by a separate
syslog server or where you don't want a particular process to send
messages to your main syslog daemon there is no way to tell the C API to use a
different socket.

In testing and QA environments or when application users don't have
access to /var/log it can be useful to run separate instances of the
syslog daemon to capture output from specific processes.

This simple library can be loaded with the LD_PRELOAD mechanism to
intercept all calls that a process makes to the syslog API
and redirect the output to a non-standard socket name.

To use it:

a) set up a syslog instance listening to a non-standard socket,
   for example, put something like this in the rsyslog.conf file:

      $SystemLogSocketName /tmp/test-log

b) specify the desired socket name in the SYSLOG_SOCKET environment
   variable, e.g.

      export SYSLOG_SOCKET=/tmp/test-log

c) put the logredir.so somewhere on the system

d) add the logredir.so to the LD_PRELOAD environment variable, e.g.

      export LD_PRELOAD=/usr/local/lib/logredir/logredir.so

e) run the process

The SYSLOG_SOCKET and LD_PRELOAD environment variables can usually
be specified in a wrapper script for running the desired process.

See the enclosed test_logger script for an example.

License information
-------------------

This project is based on syslog.c from the glibc project.

Copyright (c) 1983, 1988, 1993
     The Regents of the University of California.  All rights reserved.

Copyright (C) 2012, Daniel Pocock http://danielpocock.com

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:
1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
4. Neither the name of the University nor the names of its contributors
   may be used to endorse or promote products derived from this software
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
SUCH DAMAGE.

