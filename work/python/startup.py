import atexit
import os
import readline
import rlcompleter
from tools import *

# aliases
ex = execfile

# tab-completion
rlcompleter.readline.parse_and_bind('tab: complete')

# history saving
historyPath = os.path.expanduser("~/.pyhistory")

def save_history(historyPath=historyPath):
    import readline
    readline.write_history_file(historyPath)

atexit.register(save_history)

if os.path.exists(historyPath):
    readline.read_history_file(historyPath)


