use demo

// 1 --------------------------------------------------------------------------
db.createCollection("employees", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "age", "department"],
      properties: {
        name: {
          bsonType: "string",
          description: "name is required and must be a string"
        },
        age: {
          bsonType: "int",
          minimum: 18,
          description: "age must be >= 18"
        },
        department: {
          enum: ["HR", "Engineering", "Finance"],
          description: "department must be one of the allowed values"
        }
      }
    }
  }
})


// 2 --------------------------------------------------------------------------
db.createCollection("trainningCenter1")
db.createCollection("trainningCenter2")

var data = [
  {
    _id: 1,
    firstName: "Ahmed",
    lastName: "Ali",
    age: 22,
    address: "Cairo",
    status: ["active", "student"]
  },
  {
    _id: 2,
    firstName: "Mona",
    lastName: "Hassan",
    age: 25,
    address: "Alex",
    status: ["inactive"]
  },
  {
    _id: 3,
    firstName: "Omar",
    lastName: "Sayed",
    age: 19,
    address: "Giza",
    status: ["active"]
  }
]

db.trainningCenter1.insertOne(data)
db.trainningCenter1.find()


db.trainningCenter2.insertMany(data)
db.trainningCenter2.find()


// 3 --------------------------------------------------------------------------
db.trainningCenter2.find({ age: 22 }).explain() // COLLSCAN


// 4 --------------------------------------------------------------------------
db.trainningCenter2.createIndex(
  { age: 1 },
  { name: "IX_age" }
)


// 5 --------------------------------------------------------------------------
db.trainningCenter2.find({ age: 22 }).explain() // IXSCAN


// 6 --------------------------------------------------------------------------
db.trainningCenter2.find({ firstName: "Ahmed", lastName: "Ali" }).explain() // COLLSCAN

db.trainningCenter2.createIndex(
  { firstName: 1, lastName: 1 },
  { name: "compound_idx" }
)

db.trainningCenter2.find({ firstName: "Ahmed", lastName: "Ali" }).explain() // IXSCAN


// 7 --------------------------------------------------------------------------
db.dropDatabase()


