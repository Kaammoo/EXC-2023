db = connect( 'mongodb://localhost/Restaurant' );

db.createCollection("restaurants", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: ["address", "borough", "cuisine", "grades", "name", "restaurant_id"],
        properties: {
          address: {
            bsonType: "object",
            required: ["building", "coord", "street", "zipcode"],
            properties: {
              building: { bsonType: "string" },
              coord: { bsonType: "array", items: { bsonType: "number" } },
              street: { bsonType: "string" },
              zipcode: { bsonType: "string" }
            }
          },
          borough: { bsonType: "string" },
          cuisine: { bsonType: "string" },
          grades: {
            bsonType: "array",
            items: {
              bsonType: "object",
              required: ["date", "grade", "score"],
              properties: {
                date: { bsonType: "date" },
                grade: { bsonType: "string" },
                score: { bsonType: "number" }
              }
            }
          },
          name: { bsonType: "string" },
          restaurant_id: { bsonType: "string" }
        }
      }
    }
});

db.restaurants.insertMany([
    {
      address: {
        building: "1001",
        coord: [-73.856077, 40.848447],
        street: "Morris Park Ave",
        zipcode: "10462"
      },
      borough: "Bronx",
      cuisine: "Bakery",
      grades: [
        { date: new Date("2024-05-10"), grade: "A", score: 10 },
        { date: new Date("2023-10-25"), grade: "B", score: 18 }
      ],
      name: "Morris Park Bake Shop",
      restaurant_id: "30075445"
    },
    {
      address: {
        building: "351",
        coord: [-73.961704, 40.662942],
        street: "W 57th St",
        zipcode: "10019"
      },
      borough: "Manhattan",
      cuisine: "American ",
      grades: [
        { date: new Date("2024-05-11"), grade: "A", score: 10 },
        { date: new Date("2023-12-04"), grade: "C", score: 22 }
      ],
      name: "Wendy'S",
      restaurant_id: "30112340"
    },
    {
      address: {
        building: "469",
        coord: [-73.961704, 40.662942],
        street: "Flatbush Avenue",
        zipcode: "11225"
      },
      borough: "Brooklyn",
      cuisine: "Hamburgers",
      grades: [
        { date: new Date("2024-05-12"), grade: "A", score: 10 },
        { date: new Date("2023-12-04"), grade: "B", score: 17 }
      ],
      name: "Dj Reynolds Pub And Restaurant",
      restaurant_id: "30191841"
    },
    {
      address: {
        building: "2780",
        coord: [-73.98241999999999, 40.579505],
        street: "Stillwell Avenue",
        zipcode: "11224"
      },
      borough: "Brooklyn",
      cuisine: "American ",
      grades: [
        { date: new Date("2024-05-13"), grade: "A", score: 10 },
        { date: new Date("2023-12-04"), grade: "A", score: 12 }
      ],
      name: "Riviera Caterer",
      restaurant_id: "40356018"
    },
    {
      address: {
        building: "97-22",
        coord: [-73.8601152, 40.7311739],
        street: "63rd Road",
        zipcode: "11374"
      },
      borough: "Queens",
      cuisine: "Jewish/Kosher",
      grades: [
        { date: new Date("2024-05-14"), grade: "Z", score: 100 },
        { date: new Date("2023-11-14"), grade: "A", score: 13 }
      ],
      name: "Tov Kosher Kitchen",
      restaurant_id: "40356068"
    },
    {
      address: {
        building: "8825",
        coord: [-73.8803827, 40.7643124],
        street: "Astoria Boulevard",
        zipcode: "11369"
      },
      borough: "Queens",
      cuisine: "American ",
      grades: [
        { date: new Date("2024-05-15"), grade: "A", score: 10 },
        { date: new Date("2023-12-30"), grade: "A", score: 10 }
      ],
      name: "Brunos On The Boulevard",
      restaurant_id: "40356151"
    },
    {
      address: {
        building: "1075",
        coord: [-73.856077, 40.848447],
        street: "Flatbush Ave",
        zipcode: "11226"
      },
      borough: "Brooklyn",
      cuisine: "Ice Cream, Gelato, Yogurt, Ices",
      grades: [
        { date: new Date("2024-05-16"), grade: "A", score: 10 },
        { date: new Date("2023-12-05"), grade: "A", score: 11 }
      ],
      name: "Carvel Ice Cream",
      restaurant_id: "40356442"
    }
]);



db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1, _id: 0 });
db.restaurants.find({ borough: "Bronx" });
db.restaurants.find({ borough: "Bronx" }).limit(5);
db.restaurants.find({ borough: "Bronx" }).skip(5).limit(5);
db.restaurants.find({ "grades.score": { $gt: 90 } });
db.restaurants.find({ "grades.score": { $gt: 80, $lt: 100 } });
db.restaurants.find({ "address.coord.0": { $lt: -95.754168 } });
db.restaurants.find({
  cuisine: { $ne: "American" },
  "grades.score": { $gt: 70 },
  "address.coord.0": { $lt: -65.754168 }
});
db.restaurants.find({
  cuisine: { $ne: "American" },
  "grades.score": { $gt: 70 },
  "address.coord.0": { $lt: -65.754168 }
});
db.restaurants.find({
  cuisine: { $ne: "American" },
  "grades.grade": "A",
  borough: { $ne: "Brooklyn" }
}).sort({ cuisine: -1 });
db.restaurants.find({ name: { $regex: /^Wil/i } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({ name: { $regex: /ces$/i } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({ name: { $regex: /Reg/i } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({
  borough: "Bronx",
  cuisine: { $in: ["American", "Chinese"] }
});
db.restaurants.find({
  borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"] }
}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({
  borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"] }
}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({ "grades.score": { $lte: 10 } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({
  $or: [
    { cuisine: { $nin: ["American", "Chinese"] } },
    { name: { $regex: /^Wil/i } }
  ]
}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });
db.restaurants.find({
  "grades": { $elemMatch: { grade: "A", score: 11, date: ISODate("2014-08-11T00:00:00Z") } }
}, { restaurant_id: 1, name: 1, grades: 1 });
db.restaurants.find({
  "grades.1": { grade: "A", score: 9, date: ISODate("2014-08-11T00:00:00Z") }
}, { restaurant_id: 1, name: 1, grades: 1 });
db.restaurants.find({
  "address.coord.1": { $gt: 42, $lte: 52 }
}, { restaurant_id: 1, name: 1, address: 1 });
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }).sort({ name: 1 });
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }).sort({ name: -1 });
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }).sort({ cuisine: 1, borough: -1 });
db.restaurants.find({ "address.street": { $exists: true, $ne: "" } }).count() === db.restaurants.find().count();
db.restaurants.find({ "grades.score": { $mod: [7, 0] } }, { restaurant_id: 1, name: 1, grades:

