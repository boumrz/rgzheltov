// /server/index.js
const express = require("express");
const cors = require("cors");

const app = express();
const PORT = 3001;

app.use(cors());
app.use(express.json());

// Пример простого GET маршрута
app.get("/api/test", (req, res) => {
  res.json({ message: "Hello from the API!" });
});

// Запуск сервера
app.listen(3001, "0.0.0.0", () => {
  console.log("Server is running on port 3001");
});
