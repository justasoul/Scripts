"""
Example of a decorator with params over a function with params
"""

def outer_decorator(arg):

    def inner_decorator(func):

        def wrapper(*args, **kwargs):

            print("Time Before")
            for i in range(arg):
                func(*args, **kwargs)
            print("Time After")
        return wrapper

    return inner_decorator


"""
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
"""

@outer_decorator(arg=2)
def dummy(p_param):
    print("I'm a dummy! :: " + p_param)

dummy(p_param="bruno")
