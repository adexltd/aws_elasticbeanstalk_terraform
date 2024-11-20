// connection.js
const mysql = require('mysql2');

// Create a connection to the database
const connection = mysql.createConnection({
  host: process.env.DB_HOST,       
  user: process.env.DB_USERNAME,           
  password: process.env.DB_PASSWORD,           
  database: process.env.DB_NAME,     
  port: process.env.DB_PORT
});

// Connect to the MySQL server
connection.connect((err) => {
  console.log(process.env)
  if (err) {
    console.error('Error connecting to MySQL:', err.message);
    return;
  }
  console.log('Connected to MySQL');
});

// Initialize the database schema
connection.query(`CREATE TABLE IF NOT EXISTS entries (
  id INT AUTO_INCREMENT PRIMARY KEY,
  value VARCHAR(255) NOT NULL
)`, (err) => {
  if (err) {
    console.error('Error creating table:', err.message);
  }
});

module.exports = connection;
