# Project: q-vision-platform
## Sprint: Sprint2

This document provides an overview of the automated API tests for the `q-vision-platform` project during `Sprint2`.

### Test Cases Summary

The following table summarizes the API endpoints and test cases covered in this sprint:

| Feature/Test Case            | Endpoint                 | Method | Status Code | Expected Output                          |
| :--------------------------- | :----------------------- | :----- | :---------- | :--------------------------------------- |
| Get User Profile Success     | `/api/v1/users/{id}`     | GET    | 200         | User profile details, containing 'username' key. |
| Get User ID Not Found        | `/api/v1/users/{id}`     | GET    | 404         | Error message: "User not found".         |

### How to Run Tests

To execute these API tests, ensure you have Robot Framework and `RequestsLibrary` installed in your environment.

1.  **Navigate to your project's root directory.**
2.  **Run the tests using the Robot Framework command:**
    bash
    robot -d results tests/q-vision-platform/Sprint2.robot
    
    *   `-d results`: Specifies that all output files (log.html, report.html, output.xml) will be generated in a directory named `results`.
    *   `tests/q-vision-platform/Sprint2.robot`: The assumed path to the test suite file for this sprint.

### Expected Results

*   **Successful Test Execution:** All test cases should pass, indicated by a "PASS" status in the Robot Framework report (`report.html`).
*   **HTTP Status Codes:** API calls should return the precise HTTP status codes (e.g., `200` for success, `404` for not found) as defined in each test case.
*   **Response Body Content:** The content of the API response bodies should match the expected data, including specific JSON keys, values, or error messages as detailed in each test case's expected result criteria.
