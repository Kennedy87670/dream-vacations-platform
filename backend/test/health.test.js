const test = require('node:test');
const assert = require('node:assert/strict');

const { healthHandler } = require('../server');

test('GET /api/health returns ok', async () => {
  const req = { method: 'GET', url: '/api/health' };
  const res = {
    statusCode: 200,
    body: undefined,
    status(code) {
      this.statusCode = code;
      return this;
    },
    json(payload) {
      this.body = payload;
      return this;
    },
  };

  healthHandler(req, res);

  assert.equal(res.statusCode, 200);
  assert.deepEqual(res.body, { status: 'ok' });
});
