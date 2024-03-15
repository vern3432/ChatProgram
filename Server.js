const express = require('express');
const express = require("express");
const cors = require("cors");
const sql3 = require("better-sqlite3");
const db = new sql3("MessageApp.db");

// Create an Express application
const app = express();

// Define a route to handle GET requests to the root URL '/'

app.get('/', (req, res) => {
  res.send('Hello World');
});
 app.post("/existingUser", (req, res) => {
  const email = req.body.email; // Get the user's email from the request query
  console.log(email);

  const viewPlaneData = db.prepare("SELECT * FROM user");
  console.log("\nPlane Table:");
  console.log(viewPlaneData.all());

  // Check if the email exists in the user table
  const checkEmailQuery = db.prepare(
    "SELECT COUNT(*) as count FROM user WHERE email = ?"
  );
  const result = checkEmailQuery.get(email);

  // Get all the values given the email and append to response
  const viewUserData = db.prepare("SELECT * FROM user WHERE email = ?");
  const userData = viewUserData.get(email);

  if (result.count > 0) {
    res.json({ success: true, user: userData });
  } else {
    // If the email exists, return false
    res.status(404).json({ error: "Email not registered" });
  }
});

// Handle new signup
app.post("/newUser", (req, res) => {
  const email = req.body.email; // Get the user's email from the request query
  const user_type = req.body.user_type; // Get the user's user_type from the request query

  // Check if the email exists in the user table
  const checkEmailQuery = db.prepare(
    "SELECT COUNT(*) as count FROM user WHERE email = ?"
  );
  const result = checkEmailQuery.get(email);

  if (result.count > 0) {
    // If the email exists, return false
    res.status(404).json({ error: "Email already registered" });
  } else {
    // Insert the email and user_type into user table
    const insertUserQuery = db.prepare(
      "INSERT INTO user (email, user_type) VALUES (?, ?)"
    );
    insertUserQuery.run(email, user_type);

    // Get all the values given the email and append to response
    const viewUserData = db.prepare("SELECT * FROM user WHERE email = ?");
    const userData = viewUserData.get(email);

    res.json({ success: true, user: userData });
  }
});























// Define the port the server will listen on
const PORT = process.env.PORT || 3000;

// Start the server and listen on the specified port
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
