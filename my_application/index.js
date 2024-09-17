// index.js
const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const db = require('./connection'); // Import the MySQL connection

const app = express();
const port = 8080;

// Middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');

// Routes
app.get('/', (req, res) => {
  db.query("SELECT * FROM entries", (err, rows) => {
    if (err) {
      return console.error('Error fetching entries:', err.message);
    }
    res.render('index', { entries: rows });
  });
});

app.post('/add', (req, res) => {
  const value = req.body.value;
  db.query("INSERT INTO entries (value) VALUES (?)", [value], (err) => {
    if (err) {
      return console.error('Error inserting entry:', err.message);
    }
    res.redirect('/');
  });
});

app.post('/delete/:id', (req, res) => {
  const id = req.params.id;
  db.query("DELETE FROM entries WHERE id = ?", [id], (err) => {
    if (err) {
      return console.error('Error deleting entry:', err.message);
    }
    res.redirect('/');
  });
});

// Start server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
