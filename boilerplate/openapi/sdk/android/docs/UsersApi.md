# UsersApi

All URIs are relative to *https://virtserver.swaggerhub.com/widjaja_a/tutorial/1.0.0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addUser**](UsersApi.md#addUser) | **POST** /users/{id} | Creates a new user.
[**getUserById**](UsersApi.md#getUserById) | **GET** /users/{id} | Return a user by id.


<a name="addUser"></a>
# **addUser**
> User addUser(username)

Creates a new user.

Add new user by name.

### Example
```java
// Import classes:
//import io.swagger.client.api.UsersApi;

UsersApi apiInstance = new UsersApi();
User username = new User(); // User | The user to create.
try {
    User result = apiInstance.addUser(username);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#addUser");
    e.printStackTrace();
}
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
```java
// Import classes:
//import io.swagger.client.api.UsersApi;

UsersApi apiInstance = new UsersApi();
Integer id = 56; // Integer | The id of the object.
try {
    User result = apiInstance.getUserById(id);
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling UsersApi#getUserById");
    e.printStackTrace();
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **Integer**| The id of the object. |

### Return type

[**User**](User.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

