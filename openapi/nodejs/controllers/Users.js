'use strict';

var url = require('url');


var Users = require('./UsersService');


module.exports.addUser = function addUser (req, res, next) {
  Users.addUser(req.swagger.params, res, next);
};

module.exports.getUserById = function getUserById (req, res, next) {
  Users.getUserById(req.swagger.params, res, next);
};
