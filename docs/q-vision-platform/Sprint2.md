# Project: q-vision-platform (Sprint 2)

This document provides an overview of the automated API tests for the `q-vision-platform` project during `Sprint 2`.

## Tested Features / Test Cases Summary

| Test Name                 | Endpoint                   | Method | Description                               | Expected Result                                     |
| :------------------------ | :------------------------- | :----- | :---------------------------------------- | :-------------------------------------------------- |
| Get User Profile Success  | `/api/v1/users/123`        | GET    | Retrieve a user profile by ID.            | Status 200, Body contains username.                 |
| Get User ID 7 Not Found   | `/api/v1/users/7`          | GET    | Attempt to retrieve user with invalid ID. | Status 404, Message 'User not found'.               |
| Get User ID 8 Not Found   | `/api/v1/users/8`          | GET    | Attempt to retrieve user with invalid ID. | Status 404, Message 'User not found'.               |
| Get User ID 9 Not Found   | `/api/v1/users/9`          | GET    | Attempt to retrieve user with invalid ID. | Status 404, Message 'User not found'.               |

## How to Run Tests

### Prerequisites

Ensure you have Python, Robot Framework, and the necessary libraries installed:

bash
pip install robotframework
pip install robotframework-requests
pip install robotframework-jsonlibrary


### Running the Tests

To execute the automated tests, navigate to the root directory of your project and run the following command:

bash
robot -d results tests/q-vision-platform/Sprint2.robot


*   `-d results`: Specifies that test results (log.html, report.html, output.xml) should be stored in a directory named `results`.
*   `tests/q-vision-platform/Sprint2.robot`: Path to the Robot Framework test suite file.

## Expected Results (Criteria for Passing)

For the tests to be considered successful, all test cases must pass according to the following criteria:

*   **HTTP Status Codes**: All requests must return the expected HTTP status codes as defined in the test cases (e.g., 200 for success, 404 for not found).
*   **Response Body Content**: The response bodies must contain the expected data and error messages (e.g., a `username` field for successful profile retrieval, or "User not found" message for invalid IDs).