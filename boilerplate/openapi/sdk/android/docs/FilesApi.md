# FilesApi

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
```java
// Import classes:
//import io.swagger.client.api.FilesApi;

FilesApi apiInstance = new FilesApi();
try {
    File result = apiInstance.getPDFFile();
    System.out.println(result);
} catch (ApiException e) {
    System.err.println("Exception when calling FilesApi#getPDFFile");
    e.printStackTrace();
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**File**](File.md)

### Authorization

[BasicAuth](../README.md#BasicAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/pdf

<a name="loadZipFile"></a>
# **loadZipFile**
> loadZipFile(zipfile)

Uploads a zip file.

Upload the selected zip file.

### Example
```java
// Import classes:
//import io.swagger.client.api.FilesApi;

FilesApi apiInstance = new FilesApi();
File zipfile = new File("/path/to/file.txt"); // File | Contents of the ZIP file.
try {
    apiInstance.loadZipFile(zipfile);
} catch (ApiException e) {
    System.err.println("Exception when calling FilesApi#loadZipFile");
    e.printStackTrace();
}
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

