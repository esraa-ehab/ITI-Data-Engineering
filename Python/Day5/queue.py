import json

class Queue():

    def __init__(self):
        self.items = []

    def insert(self, value):
        self.items.append(value)

    def is_empty(self):
        if len(self.items) == 0:
            return True
        return False
    
    def pop(self):        
        if self.is_empty():
            print("No elements to remove")
            return None
        return self.items.pop(0)

class QueueOutOfRangeException(Exception):
    pass 

class NameQueue(Queue):

    queues = {}

    def __init__(self, name, size):
        super().__init__()
        self.name = name
        self.size = size
        NameQueue.queues[name] = self
    
    def insert(self, value):
        if self.size == len(self.items):
            raise QueueOutOfRangeException(f"Queue {self.name} is out of size")

        super().insert(value)

    @classmethod
    def search_queue(cls, name):
        return cls.queues[name]

    @classmethod
    def save_queue(cls, filename):
        data = {}
        for name, queue in cls.queues.items():
            data[name]= {
                "size": queue.size,
                "items": queue.items
            }
        with open(filename, "w") as file:
            json.dump(data, file, indent=4)


    @classmethod
    def load_queue(cls, filename):
        cls.queues.clear()

        with open(filename, "r") as file:
            data = json.load(file)

        for name, info in data.items():
            queue = cls(name, info['size'])
            queue.items = info['items']


    

q1 = NameQueue("numbers", 3)
q1.insert(1)
q1.insert(2)
print(q1.__dict__)

q2 = NameQueue("letters", 2)
q2.insert("A")
q2.insert("B")
print(q1.__dict__)

NameQueue.save_queue("queues.json")

NameQueue.load_queue("queues.json")

q = NameQueue.search_queue("numbers")
print(q.__dict__)
print(q.pop())   
