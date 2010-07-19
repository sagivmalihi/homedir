#!/usr/bin/env python
import sys
import os
import re
from glob import glob
import commands

USAGE = '%s <mp3 dir>'

ID3_RE = '=== %s .*:(?P<data>.*)'

class ID3Attribute(object):
    def __init__(self, name, tags):
        self.name = name
        self.regexps = [re.compile(ID3_RE % tag) for tag in tags]
    def getValue(self, info):
        matches =  [regexp.search(info) for regexp in self.regexps]
        matches = [match for match in matches if match is not None]
        if len(matches) != 1:
            return None
        [match] = matches
        val = match.groupdict()['data'].strip()
        val = self.postProcess(val)
        return val or None
    def postProcess(self, val):
        return val.replace('/','-')

class TrackNumAttribute(ID3Attribute):
    def __init__(self):
        super(TrackNumAttribute, self).__init__('TRACK', ('TRCK','TRK'))
    def postProcess(self, val):
        if val:
            return int(val.split('/')[0])


ATTRIBUTES = [ 
               ID3Attribute('ARTIST', ('TPE1', 'TP1')),
               ID3Attribute('ALBUM', ('TALB', 'TAL')),
               ID3Attribute('TITLE', ('TIT2', 'TT2')),
               TrackNumAttribute(),
             ]

class MP3File(object):
    def __init__(self, fname):
        self.fname = os.path.abspath(fname)
        info = commands.getoutput('id3info "%s"' % self.fname)
        for attr in ATTRIBUTES:
            setattr(self, attr.name, attr.getValue(info))
    @property
    def ok(self):
        return all(getattr(self, attr.name) is not None for attr in ATTRIBUTES)
    def __repr__(self):
        if self.ok:
            return '%02d - %s' % (self.TRACK, self.TITLE)
        else:
            return os.path.basename(self.fname)
    def __str__(self):
        return repr(self)

class MP3Database(object):
    def __init__(self, dirname):
        self.dirname = os.path.abspath(dirname)
        self.db = {}
        self.unrecognized = []
        files = glob(os.path.join(self.dirname, '*.mp3'))
        for file in files:
            song = MP3File(file)
            if song.ok:
                folder = '%s - %s' % (song.ARTIST, song.ALBUM)
                self.db[folder] = self.db.get(folder, []) + [song]
            else:
                self.unrecognized.append(song)
    def printStructure(self):
        for folder in self.db:
            print folder + '\\'
            for song in self.db[folder]:
                print '\t', song
        print 'The following files had missing attributes:'
        for song in self.unrecognized:
            print song
    def createStructure(self):
        for folder in self.db:
            fullpath = os.path.join(self.dirname, folder)
            if not os.path.exists(fullpath):
                os.mkdir(fullpath)
            for song in self.db[folder]:
                target_fname = os.path.join(fullpath, str(song) + '.mp3')
                os.rename(song.fname, target_fname)

def main(directory):
    db = MP3Database(directory)
    print "About to create the following tree structure:"
    db.printStructure()
    if raw_input("continue? (y/N)") == 'y':
        db.createStructure()
    print "done."

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print USAGE % sys.argv[0]
    directory = os.path.abspath(sys.argv[1])
    if not os.path.isdir(directory):
        print USAGE % sys.argv[0]
    print "going to work on %s" % directory
    main(directory)

