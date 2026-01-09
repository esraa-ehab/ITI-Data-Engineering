while True:
    file_name = input("Enter the file path to read: ")

    try:
        with open(file_name, "r") as f:
            content = f.read()
            print(content)
        break  
    except FileNotFoundError:
        second_chance = input("yes/no?")
        if second_chance == 'yes':
            print('try again')
        else: 
            break
            