if __name__ == '__main__':
    N = int(input())
    
    current_command_numbers = 0
    list = []
    
    def get_value_from_command(value_index, command):
        return int(command.split()[value_index])
    
    def command_list(command):

        if command.__contains__('insert'):
            position = get_value_from_command(1, command)
            value = get_value_from_command(2, command)
            list.insert(position, value)
        
        if command.__contains__('print'):
            print(list)
        
        if command.__contains__('remove'):
            value = get_value_from_command(1, command)
            list.remove(value)
            
        if command.__contains__('append'):
            value = get_value_from_command(1, command)
            list.append(value)
            
        if command.__contains__('sort'):
            list.sort()
            
        if command.__contains__('pop'):
            list.pop()
            
        if command.__contains__('reverse'):
            list.reverse()
            
    while current_command_numbers < N:
        current_command_numbers += 1
        command = input()
        command_list(command)
