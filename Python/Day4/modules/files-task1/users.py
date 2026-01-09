name = input("Enter you name ")
for char in name:
    if not (char.isalpha() or char.isspace()):
        raise ValueError("names can only contain charachters and spaces")
    
try:
    age = int(input("Enter your age: "))
except ValueError:
    print("Age must be an integer")

if age < 20:
    raise ValueError("Age must be 20 or older")


email = input("Enter you email: ")
if '@' not in email or '.' not in email:
    raise ValueError("Email must contain @ and .")
 
track = input("Enter you track: ")

lines = [
    f"Name: {name}\n"
    f"Age: {age}\n"
    f"Email: {email}\n"
    f"Track: {track}\n"
    ]

with open("Day4/modules/files-task1/users.txt", "w") as f:
    f.writelines(lines)