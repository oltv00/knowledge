# Grokking Algorithms

## 01 Introduction To Algorithms

- [Grokking Algorithms](#grokking-algorithms)
  - [01 Introduction To Algorithms](#01-introduction-to-algorithms)
    - [Functions](#functions)
    - [Logarithms](#logarithms)
    - [Binary search](#binary-search)
    - [Big O notation](#big-o-notation)
    - [01 Recap](#01-recap)
    - [Exercises 1.1 - 1.6](#exercises-11---16)
  - [02 Selection sort](#02-selection-sort)
    - [Linked list](#linked-list)
    - [Array](#array)
    - [Selection sort](#selection-sort)
    - [02 Recap](#02-recap)
    - [Exercises 2.1 - 2.5](#exercises-21---25)
  - [04 Recursion](#04-recursion)
    - [Base case and recursive case](#base-case-and-recursive-case)
    - [The stack](#the-stack)
    - [The call stack with recursion](#the-call-stack-with-recursion)
    - [03 Recap](#03-recap)
    - [Exercises 3.1 - 3.2](#exercises-31---32)
  - [04 Quicksort](#04-quicksort)
    - [Divide and Conquer (D&C)](#divide-and-conquer-dc)
    - [Euclid’s algorithm](#euclids-algorithm)
    - [Exercises 4.1 - 4.4](#exercises-41---44)

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

### 01 Recap

- Binary search is a lot faster than simple search.
- O(log n) is faster than O(n), but it gets a lot faster once the list of items you’re searching through grows.
- Algorithm speed isn’t measured in seconds.
- Algorithm times are measured in terms of growth of an algorithm.
- Algorithm times are written in Big O notation.

### Exercises 1.1 - 1.6

1.1 Suppose you have a sorted list of 128 names, and you’re searching through it using binary search. What’s the maximum number of steps it would take?

Answer: 7\
Why: Because log(128) = 7

1.2 Suppose you double the size of the list. What’s the maximum number of steps now?

Answer: 8\
Why: Because log(256) = 8

>Give the run time for each of these scenarios in terms of Big O.

1.3 You have a name, and you want to find the person’s phone number in the phone book.

Answer: O(log n)\
Why: Because phone book is sorted, and we can use binary search.

1.4 You have a phone number, and you want to find the person’s name in the phone book.

Answer: O(n)\
Why: Because we have to check all phone numbers.

1.5 You want to read the numbers of every person in the phone book.

Answer: O(n)\
Why: Because we have to check all phone numbers.

1.6 You want to read the numbers of just the As. (This is a tricky one!

Answer: O(n)
Why: Because in Big O notation, we have to ignore constants.

## 02 Selection sort

### Linked list

With linked lists, your items can be anywhere in memory.
Each item stores the address of the next item in the list.
A bunch of random memory addresses are linked together.

Reading: O(n)
Insertion: O(1)
Deletion: O(1)

### Array

The array items are arranged sequentially, and you can access each of them quickly.

Reading: O(1)
Insertion: O(n)
Deletion: O(n)

### Selection sort

Sorting algorithm\
Big O notation: O($n^2$)

### 02 Recap

- Your computer’s memory is like a giant set of drawers.
- When you want to store multiple elements, use an array or a list.
- With an array, all your elements are stored right next to each other.
- With a list, elements are strewn all over, and one element stores the ddress of the next one.
- Arrays allow fast reads.
- Linked lists allow fast inserts and deletes.
- All elements in the array should be the same type (all ints, all oubles, and so on).

### Exercises 2.1 - 2.5

2.1 Suppose you’re building an app to keep track of your finances.

Every day, you write down everything you spent money on. At the end of the month, you review your expenses and sum up how much you spent. So, you have lots of inserts and a few reads. Should you use an array or a list?

Answer: Linked list\
Why: Because, we need to insert items more often than read.

2.2 Suppose you’re building an app for restaurants to take customer orders. Your app needs to store a list of orders. Servers keep adding orders to this list, and chefs take orders off the list and make them. It’s an order queue: servers add orders to the back of the queue, and the chef takes the first order off the queue and cooks it.

Would you use an array or a linked list to implement this queue? (Hint: Linked lists are good for inserts/deletes, and arrays are good for random access. Which one are you going to be doing here?)

2.3 Let’s run a thought experiment. Suppose Facebook keeps a list of usernames. When someone tries to log in to Facebook, a search is done for their username. If their name is in the list of usernames, they can log in. People log in to Facebook pretty often, so there are a lot of searches through this list of usernames. Suppose Facebook uses binary search to search the list. Binary search needs random access—you need to be able to get to the middle of the list of usernames instantly. Knowing this, would you implement the list as an array or a linked list?

2.4 People sign up for Facebook pretty often, too. Suppose you decided to use an array to store the list of users. What are the downsides of an array for inserts? In particular, suppose you’re using binary search to search for logins. What happens when you add new users to an array?

2.5 In reality, Facebook uses neither an array nor a linked list to store user information. Let’s consider a hybrid data structure: an array of linked lists. You have an array with 26 slots. Each slot points to a linked list. For example, the first slot in the array points to a linked list containing all the usernames starting with a. The second slot points to a linked list containing all the usernames starting with b, and so on.

Suppose Adit B signs up for Facebook, and you want to add them to the list. You go to slot 1 in the array, go to the linked list for slot 1, and add Adit B at the end. Now, suppose you want to search for Zakhir H. You go to slot 26, which points to a linked list of all the Z names. Then you search through that list to find Zakhir H.

Compare this hybrid data structure to arrays and linked lists. Is it slower or faster than each for searching and inserting? You don’t have to give Big O run times, just whether the new data structure would be faster or slower.

## 04 Recursion

The simple way to explain how recursion works, it look to task with box and key.

You need to find key in the box, but in the box may be other box.

What’s your algorithm to search for the key?

Here’s one approach.

1. Make a pile of boxes to look through.
2. Grab a box, and look through it.
3. If you find a box, add it to the pile to look through later.
4. If you find a key, you’re done!
5. Repeat.

Here’s an alternate approach.

1. Look through the box.
2. If you find a box, go to step 1.
3. If you find a key, you’re done!

### Base case and recursive case

Recursive function has tow pars:

- base case
- recursive case

That means you have to tell it when to stop recursing.

### The stack

When you insert an item, it gets added to the top of the list.\
When you read an item, you only read the topmost item, and it’s taken off the list.\
So your todo list has only two actions: push (insert) and pop (remove and read).

### The call stack with recursion

For example we can use `factorial` function to explain how actually call stack works.

### 03 Recap

- Recursion is when a function calls itself.
- Every recursive function has two cases: the base case and the recursive case.
- A stack has two operations: push and pop.
- All function calls go onto the call stack.
- The call stack can get very large, which takes up a lot of memory.

### Exercises 3.1 - 3.2

3.1 Suppose I show you a call stack like this.

```txt
[greet_2]
[name: maggie]
[greet]
[name: maggie]
```

What information can you give me, just based on this call stack?

Answer: We are now in function call `greet_2`, and we save local variable `name` with value `maggie`.
When `greet_2` return, we will in function `greet`.

3.2 Suppose you accidentally write a recursive function that runs forever. As you saw, your computer allocates memory on the stack for each function call. What happens to the stack when your recursive function runs forever?

Answer: The stack will increase while computer has memory.

## 04 Quicksort

### Divide and Conquer (D&C)

To solve a problem using D&C, there are two steps:

1. Figure out the base case. This should be the simplest possible case.
2. Divide or decrease your problem until it becomes the base case.

### Euclid’s algorithm

If you find the biggest box that will work for the size, that will be the biggest box that will work for the entire size.

### Inductive proofs

Each inductive proof has two steps: the base case and the inductive case.

### Merge sort vs. quicksort

Which sort algorithm will be faster depends on what `constant` will be in the algorithm complixity.\
Quicksort is faster in practice beacuse it hits the average case way more often than the worst case.

### Average case vs. worst case



### Exercises 4.1 - 4.4

4.1 Write out the code for the earlier sum function.\
Answer: [04_02_recursive_sum.py](04_quicksort/04_02_recursive_sum.py)

4.2 Write a recursive function to count the number of items in a list.\
Answer: [04_03_recursive_count.py](04_quicksort/04_03_recursive_count.py)

4.3 Find the maximum number in a list.\
Answer: [04_04_recursive_max.py](04_quicksort/04_04_recursive_max.py)

4.4 Remember binary search from chapter 1? It’s a divide-and-conquer algorithm, too. Can you come up with the base case and recursive case for binary search?\
Answer: [04_05_binary_search.py](04_quicksort/04_05_binary_search.py)\
Base case: \
Recursive case:
