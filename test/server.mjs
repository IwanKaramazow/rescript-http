import express from "express";
import path from "path";
import process from "process";

var cwd = process.cwd();

var TEST_BASE_DIR = path.join(cwd, "test");

var app = express();
var port = 3000;

app.get("/", (req, res) => {
  res.sendFile(path.join(TEST_BASE_DIR, "index.html"));
});

app.get("/api/bikes", (req, res) => {
  res.json([
    { name: "Aeroad CFR Disc Di2", price: 7499 },
    { name: "Aeroad CFR Disc AXS", price: 7999 },
    { name: "Aeroad CFR Disc EPS", price: 8999 },
  ]);
});

app.get("*", (req, res) => {
  res.sendFile(path.join(cwd, req.path));
});

app.listen(port, () => {
  console.log(`Test app listening at http://localhost:${port}`);
});
