import contextlib
from functools import wraps


class cached_property(object):
    """
    Property which caches the result of the given `getter`.

    :param doc: Optional docstring which is used instead of the `getter`\s
                docstring.
    """
    def __init__(self, getter, doc=None):
        self.getter = getter
        self.__module__ = getter.__module__
        self.__name__ = getter.__name__
        self.__doc__ = doc or getter.__doc__

    def __get__(self, obj, type=None):
        if type is None:
            return self
        value = obj.__dict__[self.__name__] = self.getter(obj)
        return value


def service(func):
    func.__transactional__ = True
    return func


def _transactional(session_provider):
    def wrap_function(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            session = session_provider()
            try:
                ret = func(*args, **kwargs)
                session.commit()
                return ret
            except:
                session.rollback()
                raise
        return wrapper
    return wrap_function


def transactional(instance, session_provider):
    for key in dir(instance):
        func = getattr(instance, key)

        if callable(func) and getattr(func, '__transactional__', False):
            setattr(instance, key, wraps(func)(_transactional(session_provider)(func)))
    return instance