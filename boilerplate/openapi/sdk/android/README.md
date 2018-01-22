# swagger-android-client

## Requirements

Building the API client library requires [Maven](https://maven.apache.org/) to be installed.

## Installation

To install the API client library to your local Maven repository, simply execute:

```shell
mvn install
```

To deploy it to a remote Maven repository instead, configure the settings of the repository and execute:

```shell
mvn deploy
```

Refer to the [official documentation](https://maven.apache.org/plugins/maven-deploy-plugin/usage.html) for more information.

### Maven users

Add this dependency to your project's POM:

```xml
<dependency>
    <groupId>io.swagger</groupId>
    <artifactId>swagger-android-client</artifactId>
    <version>1.0.0</version>
    <scope>compile</scope>
</dependency>
```

### Gradle users

Add this dependency to your project's build file:

```groovy
compile "io.swagger:swagger-android-client:1.0.0"
```

### Others

At first generate the JAR by executing:

    mvn package

Then manually install the following JARs:

* target/swagger-android-client-1.0.0.jar
* target/lib/*.jar

## Getting Started

Please follow the [installation](#installation) instruction and execute the following Java code:

```java

import io.swagger.client.api.FilesApi;

public class FilesApiExample {

    public static void main(String[] args) {
        FilesApi apiInstance = new FilesApi();
        try {
            File result = apiInstance.getPDFFile();
            System.out.println(result);
        } catch (ApiException e) {
            System.err.println("Exception when calling FilesApi#getPDFFile");
            e.printStackTrace();
        }
    }
}

```

## Documentation for API Endpoints

All URIs are relative to *https://virtserver.swaggerhub.com/widjaja_a/tutorial/1.0.0*

Class | Method | HTTP request | Description
------------ | ------------- | ------------- | -------------
*FilesApi* | [**getPDFFile**](docs/FilesApi.md#getPDFFile) | **GET** /pdf | Returns the report in the PDF format.
*FilesApi* | [**loadZipFile**](docs/FilesApi.md#loadZipFile) | **POST** /zip | Uploads a zip file.
*UsersApi* | [**addUser**](docs/UsersApi.md#addUser) | **POST** /users/{id} | Creates a new user.
*UsersApi* | [**getUserById**](docs/UsersApi.md#getUserById) | **GET** /users/{id} | Return a user by id.


## Documentation for Models

 - [ErrorModel](docs/ErrorModel.md)
 - [User](docs/User.md)


## Documentation for Authorization

Authentication schemes defined for the API:
### ApiKeyAuth

- **Type**: API key
- **API key parameter name**: X-API-Key
- **Location**: HTTP header

### BasicAuth

- **Type**: HTTP basic authentication

### OAuth2

- **Type**: OAuth
- **Flow**: accessCode
- **Authorizatoin URL**: https://example.com/oauth/authorize
- **Scopes**: 
  - read: Grants read access.
  - write: Grants write access.
  - admin: Grants read and write access to administrative information.


## Recommendation

It's recommended to create an instance of `ApiClient` per thread in a multithreaded environment to avoid any potential issues.

## Author

andi.widjaja@potensi.net

