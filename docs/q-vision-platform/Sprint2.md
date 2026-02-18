# Project: q-vision-platform
## Sprint: Sprint2

### Overview
This document outlines the API test automation for the `q-vision-platform` project during `Sprint2`. The tests focus on user profile retrieval functionalities within the API.

### Test Coverage Summary
| Test Case Name           | API Context              | Description                                        | Expected Status | Key/Message Verification      |
|--------------------------|--------------------------|----------------------------------------------------|-----------------|-------------------------------|
| Get User Profile Success | GET /api/v1/users/{id}   | Successfully retrieve user profile by a valid ID.  | 200             | Body contains `username`      |
| Get User ID Not Found    | GET /api/v1/users/{id}   | Attempt to retrieve a user with an invalid ID.     | 404             | Message is `'User not found'` |

### How to Run Tests
1.  **Prerequisites**: Ensure you have Robot Framework, `RequestsLibrary`, and `JSONLibrary` installed.
    bash
    pip install robotframework robotframework-requests robotframework-jsonlibrary
    
2.  **Base URL**: The tests are configured to run against `http://localhost:3000`. Please ensure your API service is running and accessible at this address.
3.  **Execute Tests**: Navigate to the directory containing your `.robot` file. The recommended command for execution is:
    bash
    # Assuming your .robot file is located at tests/q-vision-platform/Sprint2.robot
    robot -d results tests/q-vision-platform/Sprint2.robot
    
    This command will execute all tests and store the test results (log.html, report.html, output.xml) in a newly created `results` directory.

### Expected Results Criteria
To pass these tests, the following conditions must be met:

*   **Successful User Profile Retrieval (Status 200)**:
    *   HTTP Status Code: `200 OK`
    *   Response Body: Must be a valid JSON object containing at least the `username` key.

*   **User Not Found Error (Status 404)**:
    *   HTTP Status Code: `404 Not Found`
    *   Response Body: Must be a valid JSON object containing a `message` key with the value `'User not found'`.
