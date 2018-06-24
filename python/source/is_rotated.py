# Example
# string_1 = 'hello world'
# string_2 = 'orldhello w'
# --> true

str_1 = 'hello world'
str_2 = 'llo worldhe'

def is_rotated(str_1, str_2):
    if len(str_1) != len(str_2):
        print('Strings have different count of characters')
        return False
    
    list_1 = []
    list_2 = []

    for item in str_1: list_1.append(item)
    for item in str_2: list_2.append(item)

    iteration = 1
    length_1 = len(str_1)
    is_rotated = False

    for _ in range(length_1):
        print('Current iteration: ' + str(iteration))
        print('list_1: ' + str(list_1))
        print('list_2: ' + str(list_2))
        
        iteration += 1
        is_compare = True
        
        for index in range(length_1):
            
            char_1 = list_1[index]
            char_2 = list_2[index]
            
            print('Compare char \'' + char_1 + '\' with \'' + char_2 + '\' in index ' + str(index))
            
            if char_1 != char_2:
                print('Get not equal chars, go to next possible lists')
                print('----------\n')
                is_compare = False
                break
        
        if is_compare:
            is_rotated = True
            break
        
        last_char = list_1.pop()
        list_1.insert(0, last_char)

    return is_rotated

if is_rotated(str_1, str_2):
    print('Second string is reversed of first.')
else:
    print('Second string is not reversod of first')

# Console log

# Current iteration: 1
# list_1: ['h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'h' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 2
# list_1: ['d', 'h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r', 'l']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'd' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 3
# list_1: ['l', 'd', 'h', 'e', 'l', 'l', 'o', ' ', 'w', 'o', 'r']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'l' with 'l' in index 0
# Compare char 'd' with 'l' in index 1
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 4
# list_1: ['r', 'l', 'd', 'h', 'e', 'l', 'l', 'o', ' ', 'w', 'o']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'r' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 5
# list_1: ['o', 'r', 'l', 'd', 'h', 'e', 'l', 'l', 'o', ' ', 'w']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'o' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 6
# list_1: ['w', 'o', 'r', 'l', 'd', 'h', 'e', 'l', 'l', 'o', ' ']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'w' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 7
# list_1: [' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e', 'l', 'l', 'o']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char ' ' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 8
# list_1: ['o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e', 'l', 'l']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'o' with 'l' in index 0
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 9
# list_1: ['l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e', 'l']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'l' with 'l' in index 0
# Compare char 'o' with 'l' in index 1
# Get not equal chars, go to next possible lists
# ----------

# Current iteration: 10
# list_1: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# list_2: ['l', 'l', 'o', ' ', 'w', 'o', 'r', 'l', 'd', 'h', 'e']
# Compare char 'l' with 'l' in index 0
# Compare char 'l' with 'l' in index 1
# Compare char 'o' with 'o' in index 2
# Compare char ' ' with ' ' in index 3
# Compare char 'w' with 'w' in index 4
# Compare char 'o' with 'o' in index 5
# Compare char 'r' with 'r' in index 6
# Compare char 'l' with 'l' in index 7
# Compare char 'd' with 'd' in index 8
# Compare char 'h' with 'h' in index 9
# Compare char 'e' with 'e' in index 10
# Second string is reversed of first.