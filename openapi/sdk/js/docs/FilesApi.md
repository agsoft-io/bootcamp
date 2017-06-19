# Tutorial.FilesApi

All URIs are relative to *https://virtserver.swaggerhub.com/widjaja_a/tutorial/1.0.0*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPDFFile**](FilesApi.md#getPDFFile) | **GET** /pdf | Returns the report in the PDF format.
[**loadZipFile**](FilesApi.md#loadZipFile) | **POST** /zip | Uploads a zip file.


<a name="getPDFFile"></a>
# **getPDFFile**
> File getPDFFile()

Returns the report in the PDF format.

get the selected PDF file.

### Example
```javascript
var Tutorial = require('tutorial');
var defaultClient = Tutorial.ApiClient.default;

// Configure HTTP basic authorization: BasicAuth
var BasicAuth = defaultClient.authentications['BasicAuth'];
BasicAuth.username = 'YOUR USERNAME';
BasicAuth.password = 'YOUR PASSWORD';

var apiInstance = new Tutorial.FilesApi();

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log('API called successfully. Returned data: ' + data);
  }
};
apiInstance.getPDFFile(callback);
```

### Parameters
This endpoint does not need any parameter.

### Return type

**File**

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/pdf

<a name="loadZipFile"></a>
# **loadZipFile**
> loadZipFile(opts)

Uploads a zip file.

Upload the selected zip file.

### Example
```javascript
var Tutorial = require('tutorial');
var defaultClient = Tutorial.ApiClient.default;

// Configure HTTP basic authorization: BasicAuth
var BasicAuth = defaultClient.authentications['BasicAuth'];
BasicAuth.username = 'YOUR USERNAME';
BasicAuth.password = 'YOUR PASSWORD';

var apiInstance = new Tutorial.FilesApi();

var opts = { 
  'zipfile': "/path/to/file.txt" // File | Contents of the ZIP file.
};

var callback = function(error, data, response) {
  if (error) {
    console.error(error);
  } else {
    console.log('API called successfully.');
  }
};
apiInstance.loadZipFile(opts, callback);
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **zipfile** | **File**| Contents of the ZIP file. | [optional] 

### Return type

null (empty response body)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

