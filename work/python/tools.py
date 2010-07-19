import progressbar

class tqdm(object):
    def __init__(self, iterable):
        self.obj = iterable.__iter__()
        self.max = len(iterable)
        self.pbar = progressbar.ProgressBar(maxval=self.max, widgets = [progressbar.ETA(), progressbar.Percentage(), progressbar.RotatingMarker(),progressbar.Bar(),progressbar.FileTransferSpeed()])
        self.pbar.start()
        self.item = 0
    def __iter__(self):
        return self
    def next(self):
        self.pbar.update(self.item)
        self.item += 1
        return self.obj.next()
    def __del__(self):
        self.pbar.finish()

