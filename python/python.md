# Python

- [Python](#python)
  - [Types](#types)
    - [Boolean](#boolean)
    - [String](#string)
    - [Int](#int)
    - [Float](#float)
    - [None (NULL)](#none-null)
    - [Lists](#lists)
      - [Keywords `if in` and `if not in`](#keywords-if-in-and-if-not-in)
      - [append](#append)
      - [len](#len)
      - [remove](#remove)
      - [insert](#insert)
      - [max, min](#max-min)
      - [count](#count)
      - [reverse](#reverse)
      - [list, range](#list-range)
      - [Negative index](#negative-index)
      - [List indexing (Chunk)](#list-indexing-chunk)
        - [Get chunk](#get-chunk)
        - [Get chunk to some index](#get-chunk-to-some-index)
        - [Get chunk from some index](#get-chunk-from-some-index)
        - [Get chunk with step](#get-chunk-with-step)
        - [Get chunk with negative indexes](#get-chunk-with-negative-indexes)
        - [Get chunk with negative step (reverse step)](#get-chunk-with-negative-step-reverse-step)
    - [Dictionary](#dictionary)
      - [Check if key in dictionary](#check-if-key-in-dictionary)
      - [Keyword `get`](#keyword-get)
    - [Tuple](#tuple)
  - [Operators](#operators)
    - [Delete variable](#delete-variable)
    - [In-place operators](#in-place-operators)
    - [Comparison](#comparison)
    - [Lexicographic comparison](#lexicographic-comparison)
  - [Conditions](#conditions)
  - [Cycles](#cycles)
    - [Cycle `while`](#cycle-while)
    - [Cycle `for-in`](#cycle-for-in)
    - [Keyword `break`](#keyword-break)
    - [Keyword `continue`](#keyword-continue)
  - [Functions](#functions)
    - [Define function](#define-function)
    - [Call function](#call-function)
    - [Docstrings](#docstrings)
    - [Print function docstring](#print-function-docstring)
    - [Save function to variable](#save-function-to-variable)
    - [Send result of function as argument](#send-result-of-function-as-argument)
    - [Send function as argument](#send-function-as-argument)

## Types

### Boolean

```python
foo = True
bar = False
```

### String

```python
foo = 'text'

# return string
str(0) # '0'
```

### Int

```python
# return int
int('0') # 4
```

### Float

```python
# return float
float('0') # 0.0
```

### None (NULL)

Just none ( False )

Functions without return type returns 'None'

```python
def foo():
  print('foo body')
bar = foo()
print(bar) # None
```

### Lists

```python
foo = [0, 1, 2, 3, [4, 5, 6]]
print(foo[4][0]) # 4
```

```python
foo = [1, 2, 3]
print(foo * 2) # [1, 2, 3, 1, 2, 3]
print(foo + [4, 5, 6]) # [1, 2, 3, 4, 5, 6]
```

```python
foo = 'Hello'
print(foo[4]) # o
```

#### Keywords `if in` and `if not in`

```python
foo = ['John', 'Mike', 'Alex']
if 'Alex' in foo:
  print('Alex in list')

if 'Samuel' not in foo:
  print('Samuel is not in list')
```

#### append

```python
foo = []
foo.append('Hello')
foo.append(0)
foo.append([1, 2, 3])
print(foo) # ['Hello', 0, [1, 2, 3]]
```

#### len

```python
foo = [1, 2, 3, 4, 5]
print('count: ' + str(len(foo))) # count: 5
```

#### remove

```python
foo.remove(5)
print('count: ' + str(len(foo))) # count: 4
```

#### insert

```python
foo.insert(0, 6)
print('count: ' + str(len(foo))) # count: 5
print(foo) # [6, 1, 2, 3, 4]
```

#### max, min

```python
print('max: ' + str(max(foo))) # max: 6
print('min: ' + str(min(foo))) # min: 1
```

#### count

```python
foo = [1, 1, 0, 2, 0, 2, 2, 0, 3, 4, 6, 0, 6, 7, 8, 0, 9, 9, 0, 0]
print('count: ' + str(foo.count(0))) # count: 7
```

#### reverse

```python
foo = [1, 2, 3, 4, 5]
foo.reverse()
print(foo) # [5, 4, 3, 2, 1]
```

#### list, range

```python
array = list(range(10)) # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
array = list(range(50, 60)) # [50, 51, 52, 53, 54, 55, 56, 57, 58, 59]
array = list(range(0, 10, 2)) # [0, 2, 4, 6, 8]
```

#### Negative index

```python
foo = [1, 2, 3, 4, 5]
foo[-2] # 4
```

#### List indexing (Chunk)

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
foo[<start_index>:<end_index>:<step>]
foo[<start_index>:]
foo[:<end_index>]
foo[::<step>]
```

##### Get chunk

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[2:5] # [3, 4, 5]
```

##### Get chunk to some index

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[:5] # [1, 2, 3, 4, 5]
```

##### Get chunk from some index

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[5:] # [6, 7, 8, 9, 0]
```

##### Get chunk with step

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[::2] # [1, 3, 5, 7, 9]
```

##### Get chunk with negative indexes

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[-4:-1] # [7, 8, 9]
```

##### Get chunk with negative step (reverse step)

```python
foo = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
bar = foo[::-1] # [0, 9, 8, 7, 6, 5, 4, 3, 2, 1]
```

### Dictionary

Syntax:

```python
{
simple_type: any_type
}

simple_type: Int, Float, String
any_type: ...
```

Example:

```python
foo = {
    'key_1': 'value_1',
    'key_2': 'value_2'
}
```

```python
value = foo['key_1']
print(value) # value_1
```

#### Check if key in dictionary

```python
if <key> in <dict>:
  do stuff
```

#### Keyword `get`

```python
<dict>.get('key')
return 'None' if key not exist
```

```python
<dict>.get('key', '<return_value>')
<return_value> - will return if key not exist
```

### Tuple

```python
# Tuple - immutable list
foo = (1, 2, 3)
foo[0]
```

```python
# You can define tuple without `(`, `)`
foo = 1, 2, 3
foo[0]
```

## Operators

### Delete variable

```python
foo = 0
del foo
print(foo) # 'foo' is note defined
```

### In-place operators

```python
+= -= *= /= %=
```

### Comparison

```python
== != > < >= <=
```

### Lexicographic comparison

Case of letters does not affect the weight.

```python
string_1 = 'Test' # 64, 20 + 5 + 19 + 20
string_2 = 'Tesa' # 45, 20 + 5 + 19 + 1
print(string_1 > string_2) # True
```

## Conditions

```python
if else elif
and or
```

```python
if <condition>:
  do stuff
```

```python
if <condition>:
  do stuff
else:
  do other stuff
```

```python
if <condition>:
  do stuff
elif <condition>:
  do other stuff
```

```python
if <condition_1> and <condition_2>:
  do stuff
```

```python
if <condition_1> or <condition_2>:
  do stuff
```

```python
if <condition_1> and (<condition_2> or <condition_3>):
  do stuff
```

```python
# not
if not <condition>:
  do stuff
```

## Cycles

### Cycle `while`

Syntax:

```python
while <condition>:
  # do stuff
```

Example:

```python
foo = 0
while foo < 10:
  print('Current foo: ' + str(foo))
  foo += 1
```

### Cycle `for-in`

```python
array = [1, 2, 3, 4, 5]
for value in array:
  # do stuff
```

```python
for _ in range(10):
  # do stuff, will called 10 times
```

```python
for value in range(10):
  print(value) # 0123456789 one value on each call
```

### Keyword `break`

```python
while <condition_1>:
  # do stuff
if <condition_2>:
  break
```

```python
while True:
  print('Current foo: ' + str(foo))
  foo += 1

  if foo == 101:
    break
```

### Keyword `continue`

```python
while <condition_1>:
  # do stuff
  if <condition_2>:
    continue
  # do stuff
```

## Functions

### Define function

Syntax:

```python
def <fuction_name>(<arg_name_1>, <arg_name_...>):
  # do stuff, can use arg_name_1, arg_name_...
  # can return something
```

Example:

```python
def max(x, y):
  if x > y:
    return x
  else:
    return y
```

### Call function

Syntax:

```python
<function_name>(<parameter_value_1, parameter_value_...>)
```

Example:

```python
max(5, 10)
```

### Docstrings

```python
def function_name():
  ''' Function description '''
  # do stuff
```

### Print function docstring

```python
function_name.__doc__ # Function description
```

### Save function to variable

```python
def function():
  print('Called function')

var_func = function
var_func() # Called function
```

### Send result of function as argument

```python
def print_hello(name):
  print('Hello ' + name + '!')

def read_name():
  return ':::' + input('Enter your name: ') + ':::'

print_hello(read_name())
```

### Send function as argument

```python
def print_hello(name):
  print('Hello ' + name() + '!')

def read_name():
  return ':::' + input('Enter your name: ') + ':::'

print_hello(read_name)
```


```

## Exceptions

### Posible exceptions

* ImportError - wrong import
* IndexError - index out of range
* NameError - variable is not defined
* SyntaxError - syntax
* TypeError - invalid argument type
* ValueError - invalid argument value
* ZeroDivisionError - division by zero
* AssertionError - assert

### Use `try-except` construction to handle exception

```python
try:
  do stuff
except:
  do stuff
```

### You can write keyword `pass` to do nothing

```python
try:
  pass
except:
  pass
```

### You can except only defined exceptions

```python
try:
  do stuff
except <exception_name>:
  do stuff
```

### You can defined several except blocks

```python
try:
  do stuff
except <exception_name>:
  do stuff
except <exception_name>:
  do stuff
```

### You can except several exception_names

```python
try:
  do stuff
except (<exception_name>, <exception_name>):
  do stuff
```

### `SyntaxError` and `IndentationError`

To catch these exceptions, you must use the eval function

```python
try:
  eval('do stuff')
except SyntaxError:
  Here 'SyntaxError' exception
except IndentationError:
  Here 'IndentationError' exception
```

### `Finally`

Finally stuff will be always executed

```python
try:
  do stuff
except <exception_name>:
  do stuff
finally:
  do stuff
```

### Raise your exceptions

You can `except` yours exceptions by keyword `raise`

```python
try:
  if True:
      raise <error>
except <error>:
  do stuff
```

### To `raise` exception without `except`

Don't use the 'try-except' construction

```python
raise <error>('description')
```

### To see exception in `try-except` construction

Just make `raise` in except block

```python
try:
  stuff with exception
except:
  some stuff
  raise
```

### To create your own exception

```python
class MyOwnExceptionError(Exception):
  some stuff
raise MyOwnExceptionError
or
raise MyOwnExceptionError('description')
```

### `AssertionError`

```python
assert <condition>, 'assert description'
assert text != ''
```

## Work with files

Syntax:

```python
open('<file_path>', '<read_mode>')
```

### Modes

* r - read
* w - write
* a - append
* b - binary

#### `Read`

```python
file = open('files.txt', 'r')
print(file.read())
```

##### After open file, you need to close it

```python
file.close()
```

##### To read length

```python
file_len = len(file.read())
```

##### To read not full content

1 symbol = 1 byte in UTF-8

Syntax:

```python
file.read(<bytes>)
```

Example:

```python
file.read(2) # will read 2 bytes from begin
```

##### Offset, if you continue read file

```python
file.read(2) # will read 2 bytes from begin
file.read(2) # will read 2 bytes from previous stop place
```

If in the next step you user .read func without argument will read all remaining content.

```python
file.read(2) # will read 2 bytes from begin
file.read() # will read all remaining content
```

##### To read line to line

Use method `readlines()`

```python
strings = file.readlines()
```

#### `Write`

If file does not exist, it will be create
If file exist, it will be delete and create again
All content will be deleted

##### To write content to file

Syntax:

```python
file.write('<file_content>')
```

#### `Append`

Syntax:

```python
<file>.write('<content>')
file.write('some text')
```

#### `Binary`

All media content needs binary mode
Binary mode work not only with media content
You can work with .txt or any files in binary mode

Syntax:

```python
open('<file>', <mode>)
<mode> = rb, wb, ab
```

Example:

```python
open('file_name.png', 'rb')
```

### Keyword `with`

You don't need to close file

```python
with open('<file_name>', 'r') as f:
    f.read()
f.read() # ValueError  exception
```

## Modules

STL - Standart library
Three types of module

* Your modules
* Import modules
* Modules integrated to python (random, math, os, json, sys)

`PyPi` - modules by other peoples
To install packages use `pip3` console utility

Syntax:

```python
import <module name>
```

Example:

```python
import random
random.randint(0, 100) # random number 0 - 100

import math
math.sqrt(25)
```

### Import module `as`

```python
import <module_name> as my_module_name
import math as m
m.sqrt(25)
```

### `from` module import

```python
from <module_name> import <object_name>, <object_name>
from random import randint
from math import sqrt, pi
randint(0, 100) # random number 0 - 100
sqrt(25)
```

```python
from <module_name> import *
* - means all
```

### `from` module import `as`

```python
from <module_name> import <object_name> as my_object_name
from math import sqrt as my_sqrt
my_sqrt(25)
```

To use module methods, just write method name

```python
randint(0, 100) # random number 0 - 100
sqrt(25)
```

## String formatting

* %s - string
* %d - int
* %f - float

### `%`

```python
foo = '<string_value>'
bar = <int_value>
baz = '%s, %d' % (foo, bar) # 'string_value, int_value'
```

### `.format()`

```python
foo = '<string_value>'
bar = <int_value>
baz = '{}, {}'.format(foo, bar) # 'string_value, int_value'
```

#### `.format() with indexes`

```python
foo = '<string_value>'
bar = <int_value>
baz = '{0}, {1}, {0}'.format(foo, bar) # 'string_value, int_value, string_value'
```

#### `.format()` with name indexes/arguments

```python
foo = '<string_value>'
bar = <int_value>
baz = '{foo_index}, {bar_index}'.format(foo_index = foo, bar_index = bar) # 'string_value, int_value'
```
