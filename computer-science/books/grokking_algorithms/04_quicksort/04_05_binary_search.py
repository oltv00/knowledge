# TODO: Fix it
def binary_search(list, item):
    # base case
    if len(list) == 1:
        pass
    # recursive case
    else:
        mid = (len(list) - 1) // 2
        mid_item = list[mid]

        if mid_item == item:
            return mid
        elif mid_item > item:
            new_list = list[:mid]
            return binary_search(new_list, item)
        elif mid_item < item:
            new_list = list[mid:]
            return binary_search(new_list, item)


input = [1, 3, 5, 7, 9, 10, 15, 21]
print(binary_search(input, 1))
print(binary_search(input, 21))
print(binary_search(input, 9))