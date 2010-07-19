import sys
last_frame = None

class Tracer(object):
    def __init__(self, filename = None, mode = 'w'):
        self.filename = filename
        self.mode = mode
        self.file = sys.stdout
    def __del__(self):
        if self.filename:
            self.file.close()
    def start(self):
        if self.filename:
            self.file = open(self.filename, self.mode)
        sys.settrace(self)
    def stop(self):
        sys.settrace(None)
        if self.filename:
            self.file.close()
    def __enter__(self):
        self.start()
        return self
    def __exit__(self, exc_type, exc_value, exc_tb):
        self.stop()
    def __call__(self, frame, event, arg):
        global last_frame
        last_frame = frame
        handler = getattr(self, 'handle_' + event, None)
        if handler is not None:
            handler(frame, arg)
        print >>self.file, "%s %r" % (event, frame.f_code)
        #try:
        #    print open(frame.f_code.co_filename,'r').readlines()[frame.f_code.co_firstlineno]
        #except:
        #    pass
        return self

