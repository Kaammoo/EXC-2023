db.createCollection("products", {
    validator: {
      $jsonSchema: {
        bsonType: "object",
        required: ["name", "description", "category", "price", "stock", "image"],
        properties: {
          name: {
            bsonType: "string"
          },
          description: {
            bsonType: "string"
          },
          category: {
              bsonType: "string"
          },
          price: {
            bsonType: "number"
          },
          stock: {
              bsonType: "number"
          },
          image: {
              bsonType: "string"
          }
        }
      }
    }
  })
  
db.products.insertMany([
    {
      name: "Laptop",
      description: "15.6-inch Full HD, Intel Core i7, 16GB RAM, 512GB SSD",
      category: "Electronics",
      price: 1099.99,
      stock: 50,
      image: "laptop.jpg"
    },
    {
      name: "Smartphone",
      description: "6.5-inch Super AMOLED, 128GB Storage, Quad Camera",
      category: "Electronics",
      price: 799.99,
      stock: 100,
      image: "smartphone.jpg"
    },
    {
      name: "Headphones",
      description: "Noise-cancelling, Over-ear, Bluetooth Wireless",
      category: "Electronics",
      price: 199.99,
      stock: 30,
      image: "headphones.jpg"
    },
    {
      name: "Coffee Maker",
      description: "Programmable, 12-Cup, Stainless Steel",
      category: "Appliances",
      price: 49.99,
      stock: 20,
      image: "coffeemaker.jpg"
    },
    {
      name: "Running Shoes",
      description: "Men's Running Shoe, Lightweight, Breathable",
      category: "Sports",
      price: 89.99,
      stock: 50,
      image: "runningshoes.jpg"
    },
    {
      name: "Backpack",
      description: "Waterproof, Laptop Compartment, USB Charging Port",
      category: "Travel",
      price: 39.99,
      stock: 40,
      image: "backpack.jpg"
    },
    {
      name: "Gaming Console",
      description: "4K Ultra HD, 1TB Storage, Wireless Controller",
      category: "Electronics",
      price: 399.99,
      stock: 10,
      image: "gamingconsole.jpg"
    }
  ])
  
  db.createCollection("users", {
      validator: {
          $jsonSchema: {
              bsonType: "object",
              required: ["username", "email", "password", "firstName", "lastName", "address"],
              properties: {
                  username: { bsonType: "string" },
                  email: { bsonType: "string" },
                  password: { bsonType: "string" },
                  firstName: { bsonType: "string" },
                  lastName: { bsonType: "string" },
                  address: {
                      bsonType: "object",
                      required: ["street", "city", "state", "postalCode"],
                      properties: {
                          street: { bsonType: "string" },
                          city: { bsonType: "string" },
                          state: { bsonType: "string" },
                          postalCode: { bsonType: "string" }
                      }
                  },
                  country: { bsonType: "string" }
              }
          }
      }
  })
  
  db.users.insertMany([
    {
      username: "john_doe",
      email: "john@example.com",
      password: "password123",
      firstName: "John",
      lastName: "Doe",
      address: {
        street: "123 Main St",
        city: "New York",
        state: "NY",
        postalCode: "10001"
      },
      country: "USA"
    },
    {
      username: "jane_smith",
      email: "jane@example.com",
      password: "password456",
      firstName: "Jane",
      lastName: "Smith",
      address: {
        street: "456 Elm St",
        city: "Los Angeles",
        state: "CA",
        postalCode: "90001"
      },
      country: "USA"
    },
    {
      username: "alice_johnson",
      email: "alice@example.com",
      password: "password789",
      firstName: "Alice",
      lastName: "Johnson",
      address: {
        street: "789 Oak St",
        city: "Chicago",
        state: "IL",
        postalCode: "60601"
      },
      country: "USA"
    },
    {
      username: "mark_taylor",
      email: "mark@example.com",
      password: "password101112",
      firstName: "Mark",
      lastName: "Taylor",
      address: {
        street: "1011 Pine St",
        city: "Houston",
        state: "TX",
        postalCode: "77001"
      },
      country: "USA"
    },
    {
      username: "emily_brown",
      email: "emily@example.com",
      password: "password131415",
      firstName: "Emily",
      lastName: "Brown",
      address: {
        street: "1314 Cedar St",
        city: "Phoenix",
        state: "AZ",
        postalCode: "85001"
      },
      country: "USA"
    },
    {
      username: "david_wilson",
      email: "david@example.com",
      password: "password161718",
      firstName: "David",
      lastName: "Wilson",
      address: {
        street: "1617 Maple St",
        city: "Philadelphia",
        state: "PA",
        postalCode: "19019"
      },
      country: "USA"
    },
    {
      username: "sophia_martin",
      email: "sophia@example.com",
      password: "password192021",
      firstName: "Sophia",
      lastName: "Martin",
      address: {
        street: "1920 Walnut St",
        city: "San Francisco",
        state: "CA",
        postalCode: "94101"
      },
      country: "USA"
    }
  ])
  
  db.createCollection("orders", {
      validator: {
          $jsonSchema: {
              bsonType: "object",
              required: ["user_id", "items", "order_date", "status"],
              properties: {
                  user_id: { bsonType: "objectId" },
                  items: {
                      bsonType: "array",
                      items: {
                          bsonType: "object",
                          required: ["product_id", "quantity"],
                          properties: {
                              product_id: { bsonType: "objectId" },
                              quantity: { bsonType: "number" },
                              price: { bsonType: "number" }
                          }
                      }
                  },
                  total_price: { bsonType: "number" },
                  order_date: { bsonType: "date" },
                  status: { bsonType: "string" }
              }
          }
      }
  })

  db.orders.insertMany([
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b39"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3a"), quantity: 2, price: 1099.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3c"), quantity: 1, price: 199.99 }
      ],
      total_price: 2399.97,
      order_date: ISODate("2024-05-13T12:00:00Z"),
      status: "shipped"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3b"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3d"), quantity: 1, price: 399.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3f"), quantity: 2, price: 89.99 }
      ],
      total_price: 579.96,
      order_date: ISODate("2024-05-12T15:30:00Z"),
      status: "processing"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3c"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3b"), quantity: 1, price: 799.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3e"), quantity: 1, price: 49.99 }
      ],
      total_price: 849.98,
      order_date: ISODate("2024-05-11T10:45:00Z"),
      status: "delivered"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3d"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b40"), quantity: 3, price: 1099.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3c"), quantity: 2, price: 199.99 }
      ],
      total_price: 4099.94,
      order_date: ISODate("2024-05-10T09:00:00Z"),
      status: "processing"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3e"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3a"), quantity: 1, price: 1099.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3d"), quantity: 1, price: 399.99 }
      ],
      total_price: 1499.98,
      order_date: ISODate("2024-05-09T14:20:00Z"),
      status: "shipped"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3f"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3f"), quantity: 2, price: 89.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3e"), quantity: 1, price: 49.99 }
      ],
      total_price: 229.97,
      order_date: ISODate("2024-05-08T16:45:00Z"),
      status: "processing"
    },
    {
      user_id: ObjectId("6085f68b0f7e6a0c9a2d4b40"),
      items: [
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b3b"), quantity: 1, price: 799.99 },
        { product_id: ObjectId("6085f6a10f7e6a0c9a2d4b40"), quantity: 1, price: 1099.99 }
      ],
      total_price: 1899.98,
      order_date: ISODate("2024-05-07T11:10:00Z"),
      status: "delivered"
    }
  ])

// 1.Find all products
db.products.find().pretty()

// 2.Find products by category
db.products.find({ category: "Electronics" }).pretty()

// 3.Find products with price less than or equal to a value
db.products.find({ price: { $lte: 98 } }).pretty()

// 4.Find a user by username
db.users.find({ username: 'alice_johnson' }).pretty()

// 5.Find orders placed by a specific user
db.orders.find({ user_id: ObjectId("6085f68b0f7e6a0c9a2d4b3b") }).pretty()

// 6.Find orders with a status of "Processing"
db.orders.find({ status: 'processing' }).pretty()

// 7.Find products with stock greater than 0
db.products.find({ stock: { $gt: 0 } }).pretty()

// 8.Get the total number of products
db.products.countDocuments()

// 9.Find products with names containing a specific keyword
db.products.find({ name: { $regex: 'ph' } }).pretty()

// 10.Find orders placed within a specific date range
db.orders.find({ order_date: { $gte: new Date('2024-05-01'), $lte: new Date('2024-05-10') } }).pretty()
