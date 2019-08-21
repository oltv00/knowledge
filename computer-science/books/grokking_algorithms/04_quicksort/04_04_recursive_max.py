input = [5, 3, 6, 1, 8, 4, 3]
# expected_output = 8

def max(input_max, input):

    def compare(input_max, input):
        possible_max = input.pop(0)
        if possible_max > input_max:
            return possible_max
        else:
            return input_max

    # base case
    if len(input) == 1:
        input_max = compare(input_max, input)
        return input_max
    # recursive case
    else:
        input_max = compare(input_max, input)
        return max(input_max, input)

output = max(0, input)
print(output)
