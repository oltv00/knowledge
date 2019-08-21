# input = 1680, 640
# expected_output = 80, 80

def make_bigger_square(side_1, side_2):
    # base case
    max_value = max(side_1, side_2)
    min_value = min(side_1, side_2)
    division = max_value / min_value
    remainder = division % 2

    if remainder == 0:
        return min_value, min_value
    # recursive case
    else:
        min_value = min(side_1, side_2)
        max_value = max(side_1, side_2)

        if (min_value * 2) <= max_value:
            new_min_value = min_value * 2
        else:
            new_min_value = min_value

        new_side_1 = max_value - new_min_value
        new_side_2 = min_value
        return make_bigger_square(new_side_1, new_side_2)

side_1 = 1680
side_2 = 640
output = make_bigger_square(side_1, side_2)

print(output)
