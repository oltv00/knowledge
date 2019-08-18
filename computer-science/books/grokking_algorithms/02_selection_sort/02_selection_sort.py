def selection_sort(input):
    output = []
    for _ in range(len(input)):
        min_index = min(input)
        min_value = input[min_index]
        del input[min_index]
        output.append(min_value)
    return output

def min(input):
    min_value = input[0]
    min_index = 0
    for index in range(1, len(input)):
        if min_value > input[index]:
            min_value = input[index]
            min_index = index
    return min_index

input = [10, 5, 3, 7, 15, 13, 11, 43, 8, 54]
# expectation: [3, 5, 7, 8, 10, 11, 13, 15, 43, 54]
output = selection_sort(input)
print(output)
