input = [1, 2, 3, 4, 5, 6]
# expected_output = 6

def count(initial_count, input):
    # base case
    if len(input) == 1:
        initial_count += 1
        return initial_count
    # recursive case
    else:
        del input[0]
        initial_count += 1
        return count(initial_count, input)

output = count(0, input)
print(output)
