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

app.get("/api/test1", (req, res) => {
  res.json({ message: "Hello" });
});

app.get("/api/test2", (req, res) => {
  res.json({ message: "1231313w11sd33123" });
});

// Запуск сервера
app.listen(3001, "0.0.0.0", () => {
  console.log("Server is running on port 3001");
});
