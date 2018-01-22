'use strict';

var url = require('url');


var Files = require('./FilesService');


module.exports.getPDFFile = function getPDFFile (req, res, next) {
  Files.getPDFFile(req.swagger.params, res, next);
};

module.exports.loadZipFile = function loadZipFile (req, res, next) {
  Files.loadZipFile(req.swagger.params, res, next);
};
