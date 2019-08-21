def greet(name):
    print('Hello, ' + name + '!')
    how_are_you(name)
    print('getting ready to say bye...')
    bye()

def how_are_you(name):
    print('How are you, ' + name + '?')

def bye():
    print('ok bye!')

greet('Maggie')
