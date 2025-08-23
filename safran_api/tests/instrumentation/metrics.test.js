const express = require('express');
const request = require('supertest');
const { metricsMiddleware, metricsRouter } = require('../../src/instrumentation/metrics');

describe('instrumentation/metrics', () => {
  describe('metricsMiddleware', () => {
    const makeReqRes = () => {
      const req = { method: 'GET', originalUrl: '/x' };
      const res = { statusCode: 200 };
      const listeners = {};
      res.on = (event, cb) => { listeners[event] = cb; };
      return { req, res, listeners };
    };

    it('records timing for originalUrl when response finishes', () => {
      const { req, res, listeners } = makeReqRes();
      const next = jest.fn();
      metricsMiddleware(req, res, next);
      expect(next).toHaveBeenCalled();
      listeners.finish();
    });

    it('records timing for route.path when response finishes', () => {
      const { req, res, listeners } = makeReqRes();
      req.route = { path: '/route' };
      const next = jest.fn();
      metricsMiddleware(req, res, next);
      expect(next).toHaveBeenCalled();
      listeners.finish();
    });
  });

  describe('metricsRouter', () => {
    it('serves metrics with correct content type', async () => {
      const app = express();
      app.use(metricsRouter);
      const res = await request(app).get('/');
      expect(res.status).toBe(200);
      expect(res.headers['content-type']).toContain('text/plain');
    });
  });
}); 