# Project: q-vision-platform - Sprint 2

This document outlines the automated API tests for the `q-vision-platform` project, specifically for `Sprint 2`.

## Test Scope

This test suite focuses on the User Profile API endpoints, covering scenarios for retrieving user profiles by ID, including successful and 'not found' cases.

### Summary of Test Cases

| Test Case Name                     | Description                                                                                             | Expected Result                                       | API Endpoint               |
|------------------------------------|---------------------------------------------------------------------------------------------------------|-------------------------------------------------------|----------------------------|
| Get User Profile - Valid ID        | Sends a GET request to retrieve a user profile with a valid ID.                                         | Status code 200, response body contains `username`.   | GET /api/v1/users/{id}     |
| Get User Profile - ID Not Found    | Sends GET requests to retrieve user profiles using invalid/non-existent IDs (1, 8, 9).                  | Status code 404, response body `message` is 'User not found'. | GET /api/v1/users/{id}     |

## Prerequisites

Before running the tests, ensure you have the following installed:

*   [Robot Framework](http://robotframework.org/)
*   [RequestsLibrary](https://github.com/MarketSquare/robotframework-requests)

You can install them using pip:

bash
pip install robotframework robotframework-requests


Also, ensure that the API service is running locally at `http://localhost:3000`.

## How to Run Tests

To execute the test suite, navigate to your project's root directory and run the following command. Make sure the `.robot` file is placed in `tests/q-vision-platform/Sprint2.robot`.

bash
robot -d results tests/q-vision-platform/Sprint2.robot


This command will:
*   Execute all test cases defined in `Sprint2.robot`.
*   Generate test reports (log.html, report.html, output.xml) in a `results` directory.

## Expected Test Results

A test case is considered **PASSED** if:
*   The HTTP status code received from the API matches the expected status code (e.g., `200` for success, `404` for not found).
*   The JSON response body contains the expected keys (e.g., `username` for success) or specific key-value pairs (e.g., `"message": "User not found"` for error scenarios).

Any deviation from these conditions will result in a **FAILED** test case.