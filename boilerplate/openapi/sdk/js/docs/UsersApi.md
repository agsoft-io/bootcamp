# Tutorial.UsersApi

All URIs are relative to *https://virtserver.swaggerhub.com/widjaja_a/tutorial/1.0.0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUser**](UsersApi.md#addUser) | **POST** /users/{id} | Creates a new user.
[**getUserById**](UsersApi.md#getUserById) | **GET** /users/{id} | Return a user by id.


<a name="addUser"></a>
# **addUser**
> User addUser(opts)

Creates a new user.

Add new user by name.

### Example
```javascript
var Tutorial = require('tutorial');
var defaultClient = Tutorial.ApiClient.default;

// Configure HTTP basic authorization: BasicAuth
var BasicAuth = defaultClient.authentications['BasicAuth'];
BasicAuth.username = 'YOUR USERNAME';
BasicAuth.password = 'YOUR PASSWORD';

var apiInstance = new Tutorial.UsersApi();

var opts = { 
  'username': new Tutorial.User() // User | The user to create.
};

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log('API called successfully. Returned data: ' + data);
  }
};
apiInstance.addUser(opts, callback);
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **username** | [**User**](User.md)| The user to create. | [optional] 

### Return type

[**User**](User.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

<a name="getUserById"></a>
# **getUserById**
> User getUserById(id)

Return a user by id.

Show user detail for the selected user id.

### Example
```javascript
var Tutorial = require('tutorial');
var defaultClient = Tutorial.ApiClient.default;

// Configure HTTP basic authorization: BasicAuth
var BasicAuth = defaultClient.authentications['BasicAuth'];
BasicAuth.username = 'YOUR USERNAME';
BasicAuth.password = 'YOUR PASSWORD';

var apiInstance = new Tutorial.UsersApi();

var id = 56; // Number | The id of the object.


var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log('API called successfully. Returned data: ' + data);
  }
};
apiInstance.getUserById(id, callback);
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Number**| The id of the object. | 

### Return type

[**User**](User.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

