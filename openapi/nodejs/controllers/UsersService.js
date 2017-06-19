'use strict';

exports.addUser = function(args, res, next) {
  /**
   * parameters expected in the args:
  * username (User)
  **/
    var examples = {};
  examples['application/json'] = {
  "id" : 1,
  "username" : "John Doe"
};
  if(Object.keys(examples).length > 0) {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(examples[Object.keys(examples)[0]] || {}, null, 2));
  }
  else {
    res.end();
  }
  
}

exports.getUserById = function(args, res, next) {
  /**
   * parameters expected in the args:
  * id (Integer)
  **/
    var examples = {};
  examples['application/json'] = {
  "id" : 1,
  "username" : "John Doe"
};
  if(Object.keys(examples).length > 0) {
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify(examples[Object.keys(examples)[0]] || {}, null, 2));
  }
  else {
    res.end();
  }
  
}

