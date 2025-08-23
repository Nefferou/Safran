class Counter {
  constructor() {}
  inc() {}
}
class Gauge {
  constructor() {}
  inc() {}
  dec() {}
}
class Histogram {
  constructor() {}
  observe() {}
}

const register = {
  contentType: 'text/plain',
  async metrics() { return ''; }
};

module.exports = {
  Counter,
  Gauge,
  Histogram,
  collectDefaultMetrics: () => {},
  register,
}; 