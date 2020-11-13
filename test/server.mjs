import express from "express";
import path from "path";
import process from "process";

var cwd = process.cwd();

var TEST_BASE_DIR = path.join(cwd, "test");

var app = express();
var port = 3000;

var globalIdCounter = 0;

function getId() {
  return ++globalIdCounter;
}


var bikes = [
  { id: getId(), name: "Aeroad CFR Disc Di2", price: 7499 },
  { id: getId(), name: "Aeroad CFR Disc AXS", price: 7999 },
  { id: getId(), name: "Aeroad CFR Disc EPS", price: 8999 },
];

var stores = [
  { id: getId(), name: "Brussels", bikes: [1, 3] },
  { id: getId(), name: "Valencia", bikes: [2, 3] },
  { id: getId(), name: "Vienna", bikes: [1, 2, 3] },
];

app.get("/", (req, res) => {
  res.sendFile(path.join(TEST_BASE_DIR, "index.html"));
});

app.get("/api/bikes", (req, res) => {
  setTimeout(() => {
    res.json(bikes);
  }, 3000);
});

app.get("/api/bikes/:bikeId", (req, res) => {
  const bike = bikes.find((bike) => bike.id == req.params.bikeId);

  if (bike) {
    res.json(bike);
  } else {
    res.sendStatus(404);
  }
});

app.get("/api/stores", (req, res) => {
  res.json(stores);
});

app.get("/api/stores/:storeId", (req, res) => {
  const store = stores.find((store) => store.id == req.params.storeId);

  if (store) {
    res.json(store);
  } else {
    res.sendStatus(404);
  }
});

app.get("*", (req, res) => {
  res.sendFile(path.join(cwd, req.path));
});

app.listen(port, () => {
  console.log(`Test app listening at http://localhost:${port}`);
});
