def CONTAINS(s):
    return lambda x: s in x
def NOT(predicate):
    return lambda x: not predicate(x)
def AND(*preds):
    return lambda x: all(pred(x) for pred in preds)
def OR(*preds):
    return lambda x: any(pred(x) for pred in preds)

