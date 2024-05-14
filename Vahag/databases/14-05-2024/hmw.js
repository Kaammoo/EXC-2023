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

// 1. Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine for all the documents in the collection restaurant.
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// 2. Write a MongoDB query to display the fields restaurant_id, name, borough and cuisine, but exclude the field _id for all the documents in the collection restaurant 
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 3. Write a MongoDB query to display the fields restaurant_id, name, borough and zip code, but exclude the field _id for all the documents in the collection restaurant 
db.restaurants.find({}, { restaurant_id: 1, name: 1, borough: 1, address: { zipcode: 1 }, _id: 0 });

// 4. Write a MongoDB query to display all the restaurant which is in the borough Bronx. 
db.restaurants.find({ borough: 'Bronx' });

// 5. Write a MongoDB query to display the first 5 restaurant which is in the borough Bronx.
db.restaurants.find({ borough: 'Queens' }).limit(5);

// 6. Write a MongoDB query to display the next 5 restaurants after skipping first 5 which are in the borough Bronx
db.restaurants.find({ borough: 'Queens' }).skip(5).limit(5);

// 7. Write a MongoDB query to find the restaurants who achieved a score more than 90 
db.restaurants.find({ 'grades.score': { $gt: 90 } });

// 8. Write a MongoDB query to find the restaurants that achieved a score, more than 80 but less than 100.
db.restaurants.find({
    $and: [
        { 'grades.score': { $gt: 90 } },
        { 'grades.score': { $lt: 125 } }
    ]
});

db.restaurants.aggregate([
  {
      $addFields: {
          filteredGrades: {
              $filter: {
                  input: "$grades",
                  as: "grade",
                  cond: { $and: [
                      { $gt: ["$$grade.score", 9] },
                      { $lt: ["$$grade.score", 20] }
                  ]}
              }
          }
      }
  },
  {
      $match: {
          $expr: { $eq: [{ $size: "$grades" }, { $size: "$filteredGrades" }] }
      }
  },
  {
      $project: {
          filteredGrades: 0
      }
  }
]);
// This is from google and I didn't understand how it works )))

// 9. Write a MongoDB query to find the restaurants which locate in latitude value less than -95.754168
db.restaurants.find({ "address.coord.0": { $lt: -95.754168 } });

// 10. Write a MongoDB query to find the restaurants that do not prepare any cuisine of 'American' and their grade score more than 70 and latitude less than -65.754168.
db.restaurants.find({
  $and: [
    { cuisine: { $ne: 'American' } },
    { 'grades.score': { $gt: 70 } },
    { 'address.coord.0': { $lt: -65.754168 } }
  ]
});

// 11. Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American' and achieved a score more than 70 and located in the longitude less than -65.754168.  Note : Do this query without using $and operator.
db.restaurants.find({ 
  cuisine: { $ne: 'American' }, 
  'grades.score': { $gt: 70 }, 
  'address.coord.1': { $lt: -65.754168 } 
});

// 12. Write a MongoDB query to find the restaurants which do not prepare any cuisine of 'American' and achieved a grade point 'A' not belongs to the borough Brooklyn. The document must be displayed according to the cuisine in descending order.
db.restaurants.find({
  cuisine: { $ne: 'American'},
  'grades.grade': 'A',
  borough: { $ne: 'Brooklyn' }
}).sort({ cuisine: -1 });

// 13. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Wil' as first three letters for its name.
db.restaurants.find({ name: { $regex: /^Wil/ } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 14. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'ces' as last three letters for its name.
db.restaurants.find({ name: { $regex: /ces$/ } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 15. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which contain 'Reg' as three letters somewhere in its name.
db.restaurants.find({ name: { $regex: /Reg/ } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 16. Write a MongoDB query to find the restaurants which belong to the borough Bronx and prepared either American or Chinese dish.
db.restaurants.find({
  $and: [
    { borough: 'Bronx' },
    {
      $or: [
        { cuisine: 'American' },
        { cuisine: 'Chinese' }
      ]
    }
  ]
});

// 17. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which belong to the borough Staten Island or Queens or Bronxor Brooklyn.
db.restaurants.find({
  $or: [
    { borough: 'Staten Island' },
    { borough: 'Queens' },
    { borough: 'Brooklyn' },
    { borough: 'Bronx' }
  ]
}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 18. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which are not belonging to the borough Staten Island or Queens or Bronxor Brooklyn.
db.restaurants.find({ borough: { $nin: [ 'Staten Island', 'Queens', 'Brooklyn', 'Bronx' ] } }, 
  { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 19. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which achieved a score which is not more than 10
db.restaurants.find({ 'grades.score': { $lte: 10 } }, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 20. Write a MongoDB query to find the restaurant Id, name, borough and cuisine for those restaurants which prepared dish except 'American' and 'Chinees' or restaurant's name begins with letter 'Wil'.
db.restaurants.find({
  $or: [
    { borough: { $nin: ['Amercan', 'Chinees'] } },
    { name: { $regex: /^Wil/} }
  ]
}, { restaurant_id: 1, name: 1, borough: 1, cuisine: 1, _id: 0 });

// 21. Write a MongoDB query to find the restaurant Id, name, and grades for those restaurants which achieved a grade of "A" and scored 11 on an ISODate "2014-08-11T00:00:00Z" among many of survey dates.
db.restaurants.find({
  $and: [
    { 'grades.grade': 'A' },
    { 'grades.score': 10 },
    { 'grades.date': ISODate("2024-05-10T00:00:00Z") }
  ]
}, { restaurant_id: 1, name: 1, grades: 1, _id: 0 });

// 22. Write a MongoDB query to find the restaurant Id, name and grades for those restaurants where the 2nd element of grades array contains a grade of "A" and score 9 on an ISODate "2014-08-11T00:00:00Z".
db.restaurants.find({
  $and: [
    { 'grades.1.grade': 'B' },
    { 'grades.1.score': 17 },
    { 'grades.1.date': ISODate("2023-12-04T00:00:00Z") }
  ]
}, { restaurant_id: 1, name: 1, grades: 1, _id: 0 });

// 23. Write a MongoDB query to find the restaurant Id, name, address and geographical location for those restaurants where 2nd element of coord array contains a value which is more than 42 and upto 52.
db.restaurants.find({
  $and: [
    { 'address.coord.1': { $gt: -72000 } },
    { 'address.coord.1': { $lte: 50000 } }
  ]
}, { restaurant_id: 1, name: 1, address: 1, _id: 0 });

// 24. Write a MongoDB query to arrange the name of the restaurants in ascending order along with all the columns
db.restaurants.find({}).sort({ name: 1 });

// 25. Write a MongoDB query to arrange the name of the restaurants in descending along with all the columns
db.restaurants.find({}).sort({ name: -1 });

// 26. Write a MongoDB query to arranged the name of the cuisine in ascending order and for that same cuisine borough should be in descending order.
db.restaurants.find({}).sort( { cuisine: 1}, { borough: -1 });

// 27. Write a MongoDB query to know whether all the addresses contains the street or not
db.restaurants.find({ 'address.street': { $exists: false } }).count();

// 28. Write a MongoDB query which will select all documents in the restaurants collection where the coord field value is Double
db.restaurants.find({ 'address.coord': { $type: 'double' } });

// 29. Write a MongoDB query which will select the restaurant Id, name and grades for those restaurants which returns 0 as a remainder after dividing the score by 7.
db.restaurants.find({ 'grades.score': { $mod: [7, 0] } }, { restaurant_id: 1, name: 1, grades: 1, _id: 0 });

// 30. Write a MongoDB query to find the restaurant name, borough, longitude and attitude and cuisine for those restaurants which contains 'mon' as three letters somewhere in its name. 
db.restaurants.find(
  { name: { $regex: /rea/ } },
  { name: 1, borough: 1, "address.coord": 1, cuisine: 1 }
);
