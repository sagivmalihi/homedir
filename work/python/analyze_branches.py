#!/usr/bin/env python3
import subprocess

MASTERS = ["master"]

def get_branches():
    output = subprocess.getoutput("git branch -av --no-abbrev")
    for line in output.splitlines():
        line = line.strip()
        if not line: continue
        if line.startswith("* "): continue
        if line.startswith("remotes/") and 'sagiv' not in line: continue
        branch, hash, *comment = line.split()
        if branch in MASTERS: continue
        if "->" in hash: continue # links
        if branch.startswith("remotes/"):
            branch = branch.replace("remotes/", "")
        yield branch, hash, comment

hash_cache = {}

def update_cache(branch):
    global hash_cache
    hash_cache[branch] = subprocess.getoutput("git log --format='%%H' %s" % branch).splitlines()
    
def is_hash_in_branch(hash, branch):
    global hash_cache
    if branch not in hash_cache:
        update_cache(branch)
    return hash in hash_cache[branch]

def is_cherry_picked_in_branch(hash, branch):
    new_commits = subprocess.getoutput("git cherry %s %s | grep '^+'" % (branch, hash)).strip()
    if new_commits:
        return False
    else:
        return True

def analyze(branch, hash):
    for master in MASTERS:
        if is_hash_in_branch(hash, master):
            print("%s is already in %s" % (branch, master))
            return

    for master in MASTERS:
        if is_cherry_picked_in_branch(hash, master):
            print("%s was already cherry-picked to %s" % (branch, master))
            return
    
    print("%s" % branch)

def main():
    branches = get_branches()
    for branch, hash, comment in branches:
        analyze(branch, hash)

if __name__ == '__main__':
    main()
