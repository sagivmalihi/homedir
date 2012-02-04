# Decorators

def fibonacci(n):
    if n < 2: return 1
    return fibonacci(n-1) + fibonacci(n-2)

def cached(f):
    f.cache = {}
    def cached_f(*args):
        if args not in f.cache:
            f.cache[args] = f(*args)
        return f.cache[args]
    return cached_f

@cached
def fibonacci(n):
    if n < 2: return 1
    return fibonacci(n-1) + fibonacci(n-2)

# Iterators

class N(object):
    def __init__(self):
        self.i = 0
    def __iter__(self):
        return self
    def next(self):
        self.i += 1
        return self.i

# Generators

def N2():
    i = 0
    while True:
        i += 1
        yield i

# Generator Comprehension

[fibonacci(x) for x in range(10)]
all_fibonacci = (fibonacci(x) for x in N())
import itertools
small_fibonacci = itertools.takewhile(lambda x: x < 100, all_fibonacci)

# co-routines
def consumer(gen):
    def wrapper(*args, **kwargs):
        x = gen(*args, **kwargs)
        x.next()
        return x
    return wrapper

@consumer
def average(n):
    lst = [0]
    while True:
        try:
            x = yield float(sum(lst)) / len(lst)
        except Exception as e:
            print "something horrible happened: {}".format(e)
        else:
            lst.append(x)
            if len(lst)>n:
                lst.pop(0)

avg = average(5)
avg.send(1)
avg.send(1)
avg.send(1)

avg.send(0)
avg.send(0)
avg.send(0)
avg.send(0)
avg.send(0)

avg.throw(Exception("boom!"))

# Context Managers

class logged(object):
    def __init__(self, message):
        self.message = message
    def __enter__(self):
        print "{}: starting...".format(self.message)
    def __exit__(self, et, ev, tb):
        if et is not None:
            print "{}: failed :(".format(self.message)
        else:
            print "{}: Success!".format(self.message)

import time

with logged("sleeping"):
    time.sleep(1)

with logged("sleeping"):
    time.sleep(0.5)
    # raise KeyboardInterrupt()

# Context managers from generators + decorators
from contextlib import contextmanager

@contextmanager
def logged(message):
    print "{}: starting...".format(message)
    try:
        yield
    except Exception as e:
        print "{}: failed :(".format(message)
    else:
        print "{}: Success!".format(message)

with logged("sleeping"):
    time.sleep(1)

with logged("sleeping"):
    time.sleep(0.5)
    # raise KeyboardInterrupt()




