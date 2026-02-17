# Project: q-vision-platform
## Sprint: Sprint3

### Overview
This document outlines the API test cases executed for the `q-vision-platform` project during `Sprint3`. These tests focus on user profile retrieval scenarios.

### Tested Features/Test Cases Summary

| Feature         | Test Case Name               | API Endpoint                | Expected Behavior                               |
|-----------------|------------------------------|-----------------------------|-------------------------------------------------|
| User Management | Get User Profile Success     | `GET /api/v1/users/123`     | Status 200, Body contains `username` field.     |
| User Management | Get User ID Not Found - ID 6666 | `GET /api/v1/users/6666`    | Status 404, JSON body: `{"message": "User not found"}`. |
| User Management | Get User ID Not Found - ID 7777 | `GET /api/v1/users/7777`    | Status 404, JSON body: `{"message": "User not found"}`. |
| User Management | Get User ID Not Found - ID 8888 | `GET /api/v1/users/8888`    | Status 404, JSON body: `{"message": "User not found"}`. |

### How to Run Tests
To execute these API tests, ensure you have Robot Framework and `RequestsLibrary` installed. You can install them using pip:
bash
pip install robotframework robotframework-requests


Once installed, navigate to the directory containing the `.robot` file and run the following command:

bash
robot -d results Sprint3.robot


*(Note: If the `.robot` file is located in a subdirectory, adjust the path accordingly, e.g., `robot -d results tests/q-vision-platform/Sprint3.robot`)*

### Expected Results for Passing Tests
A test case is considered successful if all the following conditions are met:

*   **Get User Profile Success:**
    *   The HTTP status code of the response is `200 OK`.
    *   The response body is a valid JSON and contains a key named `username`.

*   **Get User ID Not Found (all variations):**
    *   The HTTP status code of the response is `404 Not Found`.
    *   The response body is a valid JSON and contains a key `message` with the exact value `'User not found'`.