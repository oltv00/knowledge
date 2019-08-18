def binary_search(list, item):
    low = 0
    high = len(list) - 1

    while low <= high:
        mid = (low + high) // 2
        guess = list[mid]

        if guess == item:
            return mid
        if guess > item:
            high = mid - 1
        else:
            low = mid + 1
    return None

input = [1, 3, 5, 7, 9, 10, 15, 21]
print(binary_search(input, 1))
print(binary_search(input, 21))
print(binary_search(input, 9))
