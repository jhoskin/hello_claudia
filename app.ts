import hello = require('./hello');
import ApiBuilder = require('claudia-api-builder')
const api = new ApiBuilder();



api.get('/hello', hello.handler);

export = api;