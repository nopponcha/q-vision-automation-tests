# Project: q-vision-platform

## Sprint: Sprint2

### API Test Cases Summary

This document outlines the API test cases for the `q-vision-platform` project during `Sprint2`.

| Test Case Name        | Method | Endpoint                       |
| :-------------------- | :----- | :----------------------------- |
| Ingest PASSED Report  | POST   | /api/v1/quality-reports/ingest |

### How to Run Tests

1.  **Prerequisites:**
    *   Ensure Python is installed.
    *   Install Robot Framework and required libraries:
        bash
        pip install robotframework robotframework-requests robotframework-jsonlibrary
        

2.  **Save the test file:**
    Save the provided Robot Framework code as `tests/q-vision-platform/Sprint2.robot` (or any preferred path and filename).

3.  **Ensure API is Running:**
    Make sure your API server is running and accessible at `http://localhost:3000` (or update the `${BASE_URL}` variable in the `.robot` file if your API is at a different address, e.g., an ngrok URL).

4.  **Execute Tests:**
    Navigate to the directory containing your test file (or its parent) in your terminal and run the following command:
    bash
    robot -d results tests/q-vision-platform/Sprint2.robot
    

5.  **View Results:**
    Test reports and logs will be generated in the `results` directory.