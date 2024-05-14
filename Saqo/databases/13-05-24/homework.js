// Products

db.Products.drop()
db.createCollection("Products")

let products = [
    {
        name: "Smartphone",
        description: "High-performance smartphone with advanced features.",
        category: "Electronics",
        price: 699.99,
        stock: 100,
        image: "https://example.com/smartphone.jpg"
    },
    {
        name: "Laptop",
        description: "Thin and lightweight laptop with powerful performance.",
        category: "Electronics",
        price: 1299.99,
        stock: 50,
        image: "https://example.com/laptop.jpg"
    },
    {
        name: "T-shirt",
        description: "Comfortable and stylish cotton T-shirt.",
        category: "Clothing",
        price: 19.99,
        stock: 200,
        image: "https://example.com/tshirt.jpg"
    },
];

db.Products.insertMany(products);

// Users
db.Users.drop()
db.createCollection("Users")

let users = [
    {
        username: "john_doe",
        email: "john@example.com",
        password: "hashed_password_here",
        firstName: "John",
        lastName: "Doe",
        address: {
            street: "123 Main St",
            city: "New York",
            state: "NY",
            postalCode: "10001",
            country: "USA"
        }
    },
    {
        username: "jane_smith",
        email: "jane@example.com",
        password: "hashed_password_here",
        firstName: "Jane",
        lastName: "Smith",
        address: {
            street: "456 Elm St",
            city: "Los Angeles",
            state: "CA",
            postalCode: "90001",
            country: "USA"
        }
    },
];

db.Users.insertMany(users)

// Orders
db.Orders.drop()
db.createCollection("Orders")

let orders = [
    {
        user_id: '66424363a42571bcd364e2fa',
        items: [
            {
                product_id: db.Products.findOne()._id,
                quantity: 2,
                price: 699.99
            },
            {
                product_id: db.Products.findOne()._id,
                quantity: 1,
                price: 19.99
            }
        ],
        total_price: 1419.97,
        order_date: new Date('2024-05-01T12:00:00Z'),
        status: "Pending"
    },
    {
        user_id: '66424363a42571bcd364e2fb',
        items: [
            {
                product_id: db.Products.findOne()._id,
                quantity: 3,
                price: 1299.99
            }
        ],
        total_price: 3899.97,
        order_date: new Date('2024-05-05T18:30:00Z'),
        status: "Processing"
    },
    // Add more orders as needed
];

db.Orders.insertMany(orders)

// 1. Find all products
db.Products.find().pretty()

// 2. Find all products by category
db.Products.find({category: 'Electronics'}).pretty()

// 3. Find products with price less than or equal to a value
db.Products.find({ price: { $lte: 1000 } }).pretty()

// 4. Find a user by username
db.Users.find({firstName: 'Jane'})

// 5. Find orders placed by a specific user
db.Orders.find({user_id: '66424363a42571bcd364e2fb'})

// 6. Find orders with a status of "Processing"
db.Orders.find({status: 'Processing'})

// 7. Find products with stock greater than 0
db.Products.find({ stock: { $gt: 0} }).pretty()

// 8. Get the total number of products
db.Products.countDocuments()

// 9. Find products with names containing a specific keyword
db.Products.find({ name: { $regex: 'Smart', $options: 'i' } });

// 10. Find orders placed within a specific date range
db.Orders.find({ order_date: { $gte: new Date('2024-05-01T00:00:00Z'), $lte: new Date('2024-07-05T23:59:59Z') } });
