'use strict';

var url = require('url');


var Home = require('./HomeService');


module.exports.homeGet = function homeGet (req, res, next) {
  var location = req.swagger.params['location'].value;
  

  var result = Home.homeGet(location);
  console.log(result);
  result.then((data) => {
    if(typeof data !== 'undefined') {
      res.setHeader('Content-Type', 'application/json');
      res.end(JSON.stringify(data || {}, null, 2));
    }
    else
      res.end();
  })

};
