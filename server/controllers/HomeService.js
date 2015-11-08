'use strict';

exports.homeGet = function (location) {

    var examples = {};

    examples['application/json'] = [{
        "sound": 114,
        "temperature": 20.80,
        "humidity": 62.40,
        "home_id": 2,
        "vibration": 1,
        "dust": 72.57
    }];


    if (Object.keys(examples).length > 0)
        return examples[Object.keys(examples)[0]];

};
