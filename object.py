def myfunction(object, key):
    for key in key.split('/'):
        object = object[key]
    return object
#object = {"a":{"b":{"c":"d"}}}
#key = 'a/b/c'
object = {"x":{"y":{"z":"a"}}}
key = 'x/y/z'

value = myfunction(object, key)
print(value)
