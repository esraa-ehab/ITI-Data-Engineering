def add(x, y):
    return x+y

def subtract(x, y):
    return x-y

def multiply(x, y):
    return x*y

def devide(x, y):
    try:
        return x/y
    except ZeroDivisionError:
        print("can't devide by zero")
        return None

