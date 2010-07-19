from contextlib import contextmanager

@contextmanager
def contextback(*args, **kwargs):
    print "entering context with:", `args`, `kwargs`
    yield
    print "exiting context with:", `args`, `kwargs`

