// 1
use ITI_Mongo

// 2،3
db.Staff.insertOne({
    '_id': 3060,
    'name': 'Israa',
    'age': 22,
    'gender': 'Female',
    'department': 'CS'
})

db.Staff.find()


// 4
db.Staff.insertMany([
    {
        '_id': 3061,
        'name': 'Arwa',
        'age': 20,
        'gender': 'Female',
        'managerName' : 'Israa',
        'department': 'CS'
    },
    {
        '_id': 3062,
        'name': 'Ali',
        'age': 15,
        'gender': 'Male',
        'department': 'AI',
        'birthdate': new Date("2010-04-27T10:00:00Z")
    },
    {
        '_id': 3063,
        'name': 'Mohamed',
        'age': 21,
        'gender': 'Male',
        'department': 'Data'
    }
])


// 5
//a 
db.Staff.find()

//b
db.Staff.find({'gender': 'Male'})

//c
db.Staff.find({'age': {$gte:20, $lte:25}})

//d
db.Staff.find({'age':22 ,'gender': 'Female'})

//e
db.Staff.find({ 
    $or: [
        {'age':20 },
        {'gender': 'Female'}
    ]})
        
 
// 6
db.Staff.updateOne(
    {'age':15},
    { $set: {'name': 'Ahmed'} }
) 


// 7
db.Staff.updateMany(
    {'gender': 'Female'},
    { $set: {'department': 'AI'}}
)


// 8
use test
db.test.insertMany([
    {
        _id: 3061,
        name: 'Arwa',
        age: 20,
        gender: 'Female',
        managerName: 'Israa',
        department: 'CS'
    },
    {
        _id: 3062,
        name: 'Ali',
        age: 17,
        gender: 'Male',
        department: 'AI',
        birthdate: new Date("2010-04-27T10:00:00Z")
    },
    {
        _id: 3063,
        name: 'Mohamed',
        age: 21,
        gender: 'Male',
        department: 'Data'
    }
])


// 9
db.test.insertOne({ '_id': 3064,
    'name': "Ahmed", 
    'age': 15 })
db.test.insertOne({ '_id': 3065, 
    'name': "Eman",
    'age': 15 })


db.test.deleteOne({'age': 15})

db.test.find()


// 10
db.test.deleteMany({'gender':'Male'})


// 11
db.test.deleteMany({})

 
 
 
