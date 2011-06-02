import sys

class LoggedDict(dict):
    def __init__(self, *args, **kwargs):
        self.file = kwargs.pop('file', sys.stdout)
        super(LoggedDict, self).__init__(*args, **kwargs)
    def __getitem__(self, *args, **kwargs):
        rtn = super(LoggedDict, self).__getitem__(*args, **kwargs)    
        with open(self.file, 'a') as f:
            f.write("getitem %s %s -> %s\n" % (args, kwargs, rtn))
    def __setitem__(self, *args, **kwargs):
        with open(self.file, 'a') as f:
            f.write("setitem %s %s\n" % (args, kwargs))
        return super(LoggedDict, self).__setitem__(*args, **kwargs)
    def __delitem__(self, *args, **kwargs):
        with open(self.file, 'a') as f:
            f.write("delitem %s %s\n" % (args, kwargs))
        return super(LoggedDict, self).__delitem__(*args, **kwargs)

