'use strict';

var mongoose = require('mongoose');
var Rx = require('rx');
var q = require('q');

// Build the connection string
var dbURI = 'mongodb://192.168.0.2:27017/summer';
mongoose.set('debug', true);
mongoose.connect(dbURI);

// CONNECTION EVENTS
// When successfully connected
mongoose.connection.on('connected', function () {
    console.log('Mongoose default connection open to ' + dbURI);
});

// If the connection throws an error
mongoose.connection.on('error', function (err) {
    console.log('Mongoose default connection error: ' + err);
});

// When the connection is disconnected
mongoose.connection.on('disconnected', function () {
    console.log('Mongoose default connection disconnected');
});

// When the connection is open
mongoose.connection.on('open', function () {
    console.log('Mongoose default connection is open');
});

var SensorSchema = mongoose.Schema({
    humidity: Number,
    temperature: Number,
    sound: Number,
    vibration: Number,
    dust: Number,
    location: String
}, {collection: 'sensor'});

var Sensor = mongoose.model('Sensor', SensorSchema);
exports.homeGet = function (location) {

    var examples = {};

    var source = Rx.Observable.defer(function () {
        return Rx.Observable.return(42);
    });

    var subscription = source.subscribe(
        function (x) {
            console.log('Next: ' + x);
        },
        function (err) {
            console.log('Error: ' + err);
        },
        function () {
            console.log('Completed');
        }
    );

    var defer = q.defer();


    Sensor.find({
            location: 2
        })
        .limit(10)
        .sort({updateAt: 1})
        .exec((error, docs) => {
            var result = docs[0];
            examples['application/json'] = {
                _id: result._id,
                updatedAt: result.updatedAt,
                createdAt: result.createdAt,
                sound: result.sound,
                temperature: result.temperature,
                humidity: result.humidity,
                home_id: 2,
                vibration: result.vibration,
                dust: result.dust
            };

            if (Object.keys(examples).length > 0) {
                defer.resolve(examples[Object.keys(examples)[0]]);
            } else {
                defer.reject(err);
            }
        });

    return defer.promise;
};
