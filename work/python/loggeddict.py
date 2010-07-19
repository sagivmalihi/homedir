import traceback

class LoggedDict(dict):
    def __init__(self, *kargs, **kwargs):
        super(LoggedDict, self).__init__(*kargs, **kwargs)
    def __getitem__(self, *kargs, **kwargs):
        print "getitem"
        return super(LoggedDict, self).__getitem__(*kargs, **kwargs)    
    def __setitem__(self, *kargs, **kwargs):
        print "setitem"
        return super(LoggedDict, self).__setitem__(*kargs, **kwargs)
    def __delitem__(self, *kargs, **kwargs):
        print "delitem"
        traceback.print_stack()
        return super(LoggedDict, self).__delitem__(*kargs, **kwargs)

