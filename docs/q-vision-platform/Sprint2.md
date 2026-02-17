# Project: q-vision-platform
## Sprint: Sprint2

### Test Case Summary

This document outlines the API test cases for the `q-vision-platform` project, specifically for `Sprint2`. The tests focus on user profile retrieval functionalities.

| ID | Feature/Test Case             | API Endpoint           | Expected Status | Expected Body Content                  |
|----|-------------------------------|------------------------|-----------------|----------------------------------------|
| 1  | Get User Profile Success      | GET /api/v1/users/123  | 200             | Body contains a 'username' key         |
| 2  | Get User ID Not Found - 111   | GET /api/v1/users/111  | 404             | Message is 'User not found'            |
| 3  | Get User ID Not Found - 222   | GET /api/v1/users/222  | 404             | Message is 'User not found'            |
| 4  | Get User ID Not Found - 333   | GET /api/v1/users/333  | 404             | Message is 'User not found'            |

### How to Run Tests

To execute these API tests, follow these steps:

1.  **Prerequisites:**
    *   Ensure Python is installed.
    *   Install Robot Framework and RequestsLibrary:
        bash
        pip install robotframework robotframework-requests
        
    *   Make sure the `q-vision-platform` API server is running locally at `http://localhost:3000`.

2.  **Execution:**
    *   Save the provided Robot Framework code into a file, for example, `Sprint2.robot` within a directory structure like `tests/q-vision-platform/`.
    *   Open your terminal or command prompt.
    *   Navigate to the directory where you intend to run the tests from (e.g., the root of your test project).
    *   Run the tests using the Robot Framework command:
        bash
        robot -d results tests/q-vision-platform/Sprint2.robot
        
    *   Test results, logs, and reports will be generated in the `results` directory.

### Expected Results Criteria

For a successful test run, the following criteria must be met:

*   All executed test cases should pass without any failures.
*   The API responses should return the exact HTTP status codes as specified in each test case (e.g., `200` for success, `404` for not found).
*   The content of the API response bodies should match the expected data structures and error messages defined in the test cases.