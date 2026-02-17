# Project: Q-Vision Platform
## Sprint: Sprint 2

This document provides an overview of the automated API tests for the Q-Vision Platform, specifically for Sprint 2.

## Table of Contents
- [Features and Test Cases](#features-and-test-cases)
- [How to Run Tests](#how-to-run-tests)
- [Expected Results Criteria](#expected-results-criteria)

## Features and Test Cases

The following table summarizes the API test cases implemented in this sprint:

| Feature/Test Case Name | Description                                                                        | Expected Result                                                                    |
| :--------------------- | :--------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------- |
| `Get User Profile Success` | Verifies that a valid user profile can be retrieved using a specific user ID.      | The API should return a `200 OK` status code and the response body should contain the `username`. |
| `Get User ID Not Found`  | Verifies the system handles requests for non-existent user IDs gracefully.         | The API should return a `404 Not Found` status code and the response body should contain the message `'User not found'`. |

## How to Run Tests

To execute these tests, ensure you have Robot Framework and `robotframework-requests` library installed.

1.  Navigate to the root directory where your `tests` folder is located.
2.  Run the tests using the Robot Framework command line interface:

    bash
    robot -d results tests/q-vision-platform/Sprint2.robot
    

    *   `-d results`: Specifies that test reports (log.html, report.html, output.xml) should be generated in a directory named `results`.
    *   `tests/q-vision-platform/Sprint2.robot`: The path to the test suite file.

## Expected Results Criteria

A test case is considered successful if all of its steps pass according to the following criteria:

*   **HTTP Status Codes:** The API responds with the expected HTTP status code (e.g., `200 OK` for success, `404 Not Found` for resource not found).
*   **Response Body Content:** The JSON response body contains the expected data fields, values, or error messages as specified in the test case.
*   **Data Integrity:** (Implicit for success cases) The retrieved data is consistent and complete based on the request.

Any deviation from these criteria will result in a test failure, indicating a potential issue in the API implementation.