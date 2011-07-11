class Proxy(type):
    def __new__(mcs, name, bases, dict):
        dict.setdefault('PROXY', [])
        cls = type.__new__(mcs, name, bases, dict)
        def __getattribute__(self, attr):
            PROXY = super(cls, self).__getattribute__('PROXY')
            if attr in PROXY:
                obj = super(cls, self).__getattribute__('obj')
                return getattr(obj, attr)
            return super(cls, self).__getattribute__(attr)
        cls.__getattribute__ = __getattribute__
        return cls


class A(object):
    def bla(self):
        return 'Abla'
    def boo(self):
        return 'Aboo'
    def goo(self):
        return 'Agoo'

class C(object):
    def bla(self):
        return 'Cbla'
    def boo(self):
        return 'Cboo'
    def goo(self):
        return 'Cgoo'


class B(A):
    __metaclass__ = Proxy
    PROXY = ['bla']
    
    def __init__(self):
        self.obj = C()

    def bla(self):
        return 'Bbla'
    def boo(self):
        return 'Bboo'

b = B()
print b.bla()
print b.boo()
print b.goo()
