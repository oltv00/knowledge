input = [10, 2, 4 , 6, 14]
# expected_output = 12

def sum(input_element, input):
    
    def make_next_element(input_element, input):
        element = input.pop(0)
        next_element = element + input_element
        return next_element

    # base case
    if len(input) == 1:
        next_element = make_next_element(input_element, input)
        return next_element
    # recursive case
    else:
        next_element = make_next_element(input_element, input)
        return sum(next_element, input)

output = sum(0, input)
print(output)
