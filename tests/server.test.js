const { test, after } = require("node:test");
const assert = require("node:assert");

process.env.PORT = 5050;
process.env.API_SECRET_KEY = "test-key";
process.env.STORE_NAME = "Test Store";

const server = require("../server.js");

test("GET /api/store returns the store name and product count", async () => {
  await new Promise((resolve) => setTimeout(resolve, 300));
  const res = await fetch("http://localhost:5050/api/store");
  assert.strictEqual(res.status, 200);
  const body = await res.json();
  assert.strictEqual(body.name, "Test Store");
  assert.strictEqual(typeof body.totalProducts, "number");
});

after(() => {
  server.close();
});
