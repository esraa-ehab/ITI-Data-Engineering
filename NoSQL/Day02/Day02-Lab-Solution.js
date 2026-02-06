use test

// 1 --------------------------------------------------
db.inventory.find({
    tags:{$exists: true}
})


// 2 --------------------------------------------------
db.inventory.find({
    $or: [{
        tags: 'ssl'
    },
    {
        tags: 'security'
    }]
})


// 3 --------------------------------------------------
db.inventory.find({ qty: 85 })

 
// 4 --------------------------------------------------
db.inventory.find({ tags: {$all: ['ssl','security']}})

db.inventory.find({ tags: {$all: ['ssl','security'], $size:2}})

// 5 --------------------------------------------------
db.inventory.find({item:'paper'})

db.inventory.find({item:'laptopDevice'})

    // updateOne ----------
db.inventory.updateOne(
    {item:'laptop'},
    {
        $set: {'size.uom' : 'meter'},
        $currentDate: {lastModified: true},
        $setOnInsert: {
            dataSource: "todayRegister", 
            item: "laptopDevice"}
    },
    {upsert: true}
)

    // updateMany ----------
db.inventory.updateMany(
    {item:'laptop'},
    {
        $set: {'size.uom' : 'meter'},
        $currentDate: {lastModified: true},   
        $setOnInsert: {
            dataSource: "todayRegister",
            item: "laptopDevice"}
    },
    {upsert: true}
)

    // replaveOne ---------- 
db.inventory.replaceOne(
    {item:'laptopDevice'},
    {
        item: 'laptopDevice',
        qty: 50,
        size: {h:8.5, w:11, "uom" : "meter"},
        lastModified: new Date()
    },
    {upsert:true}
)

db.inventory.find({item:'laptopDevice'})

// 6 --------------------------------------------------
db.employee.find()

db.employee.insertOne({
    neme: "Ahmed",
    ege: 25,
})

db.employee.updateOne(
    { neme: "Ahmed" },  
    {
        $rename: {
            "neme": "name",
            "ege": "age"
         }
})

db.employee.find({name: 'Ahmed'})


// 7 --------------------------------------------------
db.employee.updateOne(
    { name: "Ahmed"},
    { $unset: {name: ""}}
)


// 8 --------------------------------------------------
    // max ----------
db.employees.find({name: 'Ahmed'})
db.employees.updateOne(
    { name: "Ahmed" },
  {
    $max: { salary: 15000 }
  },
  { upsert: true }
)

    // min  ----------
db.employees.updateOne(
    { name: "Ahmed" },
  {
    $min: { salary: 10000 }
  },
  { upsert: true }
)

    // inc ----------
db.employee.find({_id : 1})
db.employee.updateOne(
    {_id : 1},
    { $inc: {age: 3}}
)

    // mul ----------
db.sales.find()
db.sales.updateMany(
    {
        quantity: { $exists: true },
        price: { $exists: true }
    },
    [
        {
            $set: {
                revenue: { $multiply: ["$quantity", "$price"] }
            }
        }
    ]
)


// 9 --------------------------------------------------
db.sales.aggregate(
    { //find date matches
        $match: {
            date: {
                $gte: ISODate("2020-01-01"), 
                $lte: ISODate("2023-01-01")
            }
        }
    },
    { // group revenue by product
         $group: {
             _id: '$product',
             totalRevenue: {
                 $sum :{
                     $multiply: ["$quantity", "$price"]
                 }
             }
         }   
    },
    { // sort total revenue descendingly
        $sort: {
            totalRevenue: -1
        }
    }
)


// 10 --------------------------------------------------
db.employees.find()
db.employees.aggregate([
    {
        $group: {
            _id : '$department',
            avgSalary: { $avg: '$salary'}
        }
    }
])


// 11 --------------------------------------------------
db.likes.find()
db.likes.aggregate([
    {
        $group: {
            _id : '$title',
            maxSalary: { $: '$likes'}
        }
    }
])

