const express = require('express');

// Create an Express application
const app = express();

// Define a route to handle GET requests to the root URL '/'
app.get('/', (req, res) => {
  res.send('Hello World');
});

// Define the port the server will listen on
const PORT = process.env.PORT || 3000;

// Start the server and listen on the specified port
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
