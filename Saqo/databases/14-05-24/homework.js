db = connect( 'mongodb://localhost/restaurantsdb' )

// Step 1: Create the collection
db.restaurants.drop()
db.createCollection("restaurants");

// Step 2: Generate insertion data
const restaurantsData = [
  {
    address: {
      building: "1000",
      coord: [-73.9667, 40.78],
      street: "2 Avenue",
      zipcode: "10075"
    },
    borough: "Manhattan",
    cuisine: "Italian",
    grades: [
      { date: new Date("2014-10-01"), grade: "A", score: 100 },
      { date: new Date("2014-01-16"), grade: "B", score: 17 }
    ],
    name: "Vella",
    restaurant_id: "41704620"
  },
  {
    address: {
      building: "1001",
      coord: [-73.9557413, 40.7720266],
      street: "3 Avenue",
      zipcode: "10075"
    },
    borough: "Brooklyn",
    cuisine: "American",
    grades: [
      { date: new Date("2014-10-01"), grade: "A", score: 20 },
      { date: new Date("2014-01-16"), grade: "B", score: 18 }
    ],
    name: "Udvozlet",
    restaurant_id: "41704621"
  }
];

db.restaurants.insertMany(restaurantsData);

// printjson(db.restaurants.find({}))

// Ex. 1
printjson(db.restaurants.find({}, {address: 0, grades: 0 }))
// Ex. 2
printjson(db.restaurants.find({},{_id: 0, address: 0, grades: 0}))
// Ex. 3
printjson(db.restaurants.find({},{
    _id: 0,
    "address.zipcode": 1,
    borough: 1,
    cuisine: 1,
    name: 1,
    restaurant_id: 1,
}))
// Ex. 4
printjson(db.restaurants.find({borough: "Brooklyn"}))
// Ex. 5
printjson(db.restaurants.find({borough: "Brooklyn"}).limit(5))
// Ex. 6
printjson(db.restaurants.find({borough: "Brooklyn"}).skip(1).limit(1))
// Ex. 7
printjson("-----------------")
printjson(db.restaurants.find({"grades.score": {$gt: 90}}))
// Ex. 8
printjson("-----------------")
db.restaurants.find({
  $and: [
    { "grades.score": { $gt: 10 } },
    { "grades.score": { $lt: 30 } }
  ]
}).pretty()
// Ex. 9
printjson(db.restaurants.find({ "address.coord.0": { $lt: -95.754168 } }))
// Ex. 10
printjson(db.restaurants.find({
  $and: [
    { cuisine: { $ne: 'American' } },
    { "grades.score": { $gt: 70 } },
    { "address.coord.0": { $lt: -65.754168 } }
  ]
}))
// Ex. 11
printjson(db.restaurants.find({
  cuisine: { $ne: 'American' },
  "grades.score": { $gt: 70 },
  "address.coord.0": { $lt: -65.754168 }
}))
// Ex. 12
printjson(db.restaurants.find({
  cuisine: { $ne: 'American' },
  "grades.grade": 'A',
  borough: { $ne: 'Brooklyn' }
}).sort({ cuisine: -1 }))
// Ex. 13
printjson(db.restaurants.find(
  { name: { $regex: /^Wil/i } },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 14
printjson(db.restaurants.find(
  { name: { $regex: /ces$/i } },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 15
printjson(db.restaurants.find(
  { name: { $regex: /Reg/i } },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 16
printjson(db.restaurants.find({
  borough: "Bronx",
  $or: [
    { cuisine: "American" },
    { cuisine: "Chinese" }
  ]
}))
// Ex. 17
printjson(db.restaurants.find(
  { 
    borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] }
  },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 18
printjson(db.restaurants.find(
  { 
    borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"] }
  },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 19
printjson(db.restaurants.find(
  { 
    "grades.score": { $lte: 10 }
  },
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }
))
// Ex. 20
printjson(db.restaurants.find({
  $or: [
    { cuisine: { $nin: ["American", "Chinese"] } },
    { name: { $regex: /^Wil/i } }
  ]
}, {
  restaurant_id: 1,
  name: 1,
  borough: 1,
  cuisine: 1
}))
// Ex. 21
printjson(db.restaurants.find({
  "grades": {
    $elemMatch: {
      "date": ISODate("2014-08-11T00:00:00Z"),
      "grade": "A",
      "score": 11
    }
  }
}, {
  "restaurant_id": 1,
  "name": 1,
  "grades": { $elemMatch: { "date": ISODate("2014-08-11T00:00:00Z"), "grade": "A", "score": 11 } }
}))
// Ex. 22
printjson(db.restaurants.find({
  "grades.1": {
    "date": ISODate("2014-08-11T00:00:00Z"),
    "grade": "A",
    "score": 9
  }
}, {
  "restaurant_id": 1,
  "name": 1,
  "grades.$": 1
}))
// Ex. 23
printjson(db.restaurants.find({
  "address.coord.1": { $gt: 42, $lte: 52 }
}, {
  "restaurant_id": 1,
  "name": 1,
  "address": 1,
  "coord": 1
}))
// Ex. 24
printjson(db.restaurants.find().sort({ "name": 1 }))
// Ex. 25
printjson(db.restaurants.find().sort({ "name": -1 }))
// Ex. 26
printjson(db.restaurants.aggregate([
  {
    $sort: { "cuisine": 1, "borough": -1 }
  }
]))
// Ex. 27
printjson(db.restaurants.aggregate([
  {
    $match: {
      "address.street": { $exists: true, $ne: null }
    }
  },
  {
    $group: {
      _id: null,
      count: { $sum: 1 }
    }
  }
]))
// Ex. 28
printjson(db.restaurants.find({ "coord": { $type: "double" } }))
// Ex. 29
printjson(db.restaurants.find({
  "grades.score": { $mod: [7, 0] }
}, {
  "restaurant_id": 1,
  "name": 1,
  "grades": 1
}))
// Ex. 30
printjson(db.restaurants.find(
  { name: { $regex: /mon/i } },
  { name: 1, borough: 1, "address.coord": 1, cuisine: 1 }
))
