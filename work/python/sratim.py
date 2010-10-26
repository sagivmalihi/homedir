#!/usr/bin/python
"""
 module to help download subtitles from sratim.co.il
"""
import sys
import os
import re
import time
import urllib2
import zipfile
import StringIO

import feedparser

from levenshtein import levenshtein

RSS_FEED_URL = "http://sratim.co.il/lastsubtitles.rss"
SUBTITLE_ID_RE = re.compile(r"http://www.sratim.co.il/subtitles.php\?mid=\d+#(\d+)")
DOWNLOAD_URL = "http://www.sratim.co.il/downloadsubtitle.php?id=%s"
SUBTITLE_SUFFIXES = ".srt", ".sub"
VIDEO_SUFFIXES = ".avi", ".mkv"
LEVENSHTEIN_DIST_BOUND = 0.1

def get_rss_sub(rss_sub):
    hebrew_title, english_title = rss_sub.title.split(" | ")
    [content] = rss_sub.content
    for match in SUBTITLE_ID_RE.finditer(content.value):
        [subtitle_id] = match.groups()
    return english_title, subtitle_id

def get_download_url(subtitle_id):
    return DOWNLOAD_URL % subtitle_id

def get_last_subs():
    rss = feedparser.parse(RSS_FEED_URL)
    for sub in rss.entries:
        yield get_rss_sub(sub)

def download_sub_zip(subtitle_id):
    url = get_download_url(subtitle_id)
    zipped_file = urllib2.urlopen(url).read()
    return zipped_file

def get_subtitle(subtitle_id, path='.'):
    zipped_sub = download_sub_zip(subtitle_id)
    zf = zipfile.ZipFile(StringIO.StringIO(zipped_sub))
    for f in zf.filelist:
        if any(f.filename.endswith(sfx) for sfx in SUBTITLE_SUFFIXES):
            zf.extract(f, path)
            yield f.filename

def get_videos(path):
    for fname in os.listdir(path):
        if any(fname.endswith(sfx) for sfx in VIDEO_SUFFIXES):
            # consider only video files w/o subtitles
            basename, _ = os.path.splitext(fname)
            full_path_basename = os.path.join(path, basename)
            if not any(os.path.exists(full_path_basename + sfx) for sfx in SUBTITLE_SUFFIXES):
                yield fname

def download_subtitles_for_path(path):
    video_filenames = list(get_videos(path))
    print "checking against %d video files" % len(video_filenames)
    for title, sub_id in get_last_subs():
        print "checking", title
        for video_filename in video_filenames:
            basename, _ = os.path.splitext(video_filename)
            score = levenshtein(title, basename)
            if score < LEVENSHTEIN_DIST_BOUND:
                print title, basename, score
                [downloaded] = list(get_subtitle(sub_id, path))
                full_path_sub = os.path.join(path, downloaded)
                _, sub_ext = os.path.splitext(downloaded)
                full_path_vid = os.path.join(path, basename)
                name_for_sub = full_path_vid + sub_ext
                i = 0
                while os.path.exists(name_for_sub):
                    name_for_sub = full_path_vid + '.' + `i` + sub_ext
                    i += 1
                os.rename(full_path_sub, full_path_vid + sub_ext)

if __name__ == '__main__':
    while True:
        download_subtitles_for_path(sys.argv[1])
        time.sleep(60)

