'use strict';

var url = require('url');


var Home = require('./HomeService');


module.exports.homeGet = function homeGet (req, res, next) {
  var location = req.swagger.params['location'].value;
  

  var result = Home.homeGet(location);

  if(typeof result !== 'undefined') {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(result || {}, null, 2));
  }
  else
    res.end();
};
