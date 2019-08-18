# Grokking Algorithms

## 01 Introduction To Algorithms

- [Grokking Algorithms](#grokking-algorithms)
  - [01 Introduction To Algorithms](#01-introduction-to-algorithms)
    - [Functions](#functions)
    - [Logarithms](#logarithms)
    - [Binary search](#binary-search)
    - [Big O notation](#big-o-notation)
    - [Exercises 1.1 - 1.6](#exercises-11---16)

### Functions

```math
f(x) = x * 2

example:
f(5) = 5 * 2 = 10
```

### Logarithms

```math
log n

example:
log 32 = 5 # 5^^2 = 32
log 1024 = 10 # 10^^2 = 1024
```

### Binary search

Binary search algorithm:

- Takes as input a sorted array and a search value.
- Reads the element that is in the middle.

```python
low = 0
high = len(list) - 1
mid = list[(low + high) // 2]
```

- Compares the sought value and `mid`.
- If the search value is less than `mid`: continue the search on the left.
- If the value you are looking for is greater than `mid`: continue searching on the right side.

### Big O notation

Big O notation is about the worst-case scenario.

- O(log n), also known as log time.
  - Example: Binary search.
- O(n), also known as linear time.
  - Example: Simple search.
- O(n * log n).
  - Example: A fast sorting algorithm, like quicksort.
- O($n^2$).
  - Example: A slow sorting algorithm, like selection sort.
- O(n!).
  - Example: A really slow algorithm, like the traveling salesperson.

Algorithm speed isn’t measured in seconds, but in growth of the number of operations.

Instead, we talk about how quickly the run time of an algorithm increases as the size of the input increases.

Run time of algorithms is expressed in Big O notation.

O(log n) is faster than O(n), but it gets a lot faster as the list of items you’re searching grows.

### Exercises 1.1 - 1.6

1.1 Suppose you have a sorted list of 128 names, and you’re searching through it using binary search. What’s the maximum number of steps it would take?

Answer: 7\
Why: Because log(128) = 7

1.2 Suppose you double the size of the list. What’s the maximum number of steps now?

Answer: 8\
Why: Because log(256) = 8

>Give the run time for each of these scenarios in terms of Big O.

1.3 You have a name, and you want to find the person’s phone number in the phone book.

Answer: log n\
Why: Because phone book is sorted, and we can use binary search.

1.4 You have a phone number, and you want to find the person’s name in the phone book. (Hint: You’ll have to search through the whole book!)

Answer: O(n)\
Why: Because we have to check all phone numbers.

1.5 You want to read the numbers of every person in the phone book.

Answer: 

1.6 You want to read the numbers of just the As. (This is a tricky one!

Answer: 
