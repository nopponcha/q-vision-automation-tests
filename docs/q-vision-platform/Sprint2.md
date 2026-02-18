# Project: q-vision-platform
## Sprint: Sprint2

### API Test Cases Summary

This document summarizes the API test cases for the `q-vision-platform` project during `Sprint2`.

| Test Name                 | Endpoint                  | Expected Status | Expected Body Content          |
| :------------------------ | :------------------------ | :-------------- | :----------------------------- |
| Get User Profile Success  | `GET /api/v1/users/123`   | 200             | Contains 'username' key        |
| Get User ID Not Found - ID 11 | `GET /api/v1/users/11`    | 404             | Message 'User not found'       |
| Get User ID Not Found - ID 2000 | `GET /api/v1/users/2000`  | 404             | Message 'User not found'       |
| Get User ID Not Found - ID 3000 | `GET /api/v1/users/3000`  | 404             | Message 'User not found'       |

### How to Run Tests

To execute these API tests, follow the steps below:

1.  **Prerequisites**: Ensure you have Robot Framework and the `robotframework-requests` library installed. If not, you can install them using pip:
    bash
    pip install robotframework robotframework-requests
    

2.  **Save the test file**: Save the provided Robot Framework code into a file named `Sprint2.robot`. It is recommended to organize your tests, for example, within a `tests/q-vision-platform/` directory structure.

3.  **Execute the tests**: Navigate to the directory containing your `Sprint2.robot` file (or your project root) in your terminal and run the following command:
    bash
    robot -d results tests/q-vision-platform/Sprint2.robot
    
    This command will execute all defined test cases. A `results` directory will be created, containing the test report (`report.html`), detailed logs (`log.html`), and XML output (`output.xml`).

### Expected Results Criteria

For a successful test run:

*   All test cases should pass without any failures.
*   HTTP status codes returned by the API should match the expected values for each specific test case (e.g., 200 for success, 404 for resource not found).
*   The response body for each API call should contain the anticipated data structures, keys, or error messages as described in the test case details.