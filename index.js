const express = require("express");
const app = express();
const PORT = process.env.SERVER_PORT || process.env.PORT || 8080;
app.get("/", function(req, res) {
  res.send("<html><body><h2>Search Phrase</h2><p>Enter your phrase:</p><a href='https://wikipedia.org/'>Enter</a></body></html>");
});

app.listen(PORT, () => console.log(`Http server is running on port:${PORT}!`));
