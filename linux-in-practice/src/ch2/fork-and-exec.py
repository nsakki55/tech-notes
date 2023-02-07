#!/usr/bin/python3
import os, sys

ret = os.fork()

if ret == 0:
    print("子プロセス: pid={}, 親プロセス: pid={}".format(os.getpid(), os.getpid()))
    os.execve("/bin/echo", ["echo", "pid={} からこんにちは".format(os.getpid())], {})
    exit()

elif ret > 0:
    print("子プロセス: pid={}, 親プロセス: pid={}".format(os.getpid(), ret))
    exit()

sys.exit(1)