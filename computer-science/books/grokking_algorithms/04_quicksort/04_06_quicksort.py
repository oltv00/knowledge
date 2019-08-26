def quicksort(array):
    # base case
    if len(array) < 2:
        return array
    # recursive case
    else:
        pivot_index = (len(array) - 1) // 2
        pivot = array[pivot_index]
        
        left_side = []
        right_side = []

        for item in array:
            if item == pivot:
                continue
            if item < pivot:
                left_side.append(item)
            else:
                right_side.append(item)

        sorted_left_side = quicksort(left_side)
        sorted_right_side = quicksort(right_side)

        return sorted_left_side + [pivot] + sorted_right_side

input = [3, 5, 2, 1, 4]
# expected_output = [1, 2, 3, 4, 5]

output = quicksort(input)
print(output)
