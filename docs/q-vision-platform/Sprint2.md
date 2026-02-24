# Project: q-vision-platform

## Sprint: Sprint2 - API Test Automation

This document outlines the Robot Framework test suite for the `q-vision-platform` project, specifically for `Sprint2`. It includes test cases to verify the API functionality for ingesting quality reports and retrieving project history.

### Prerequisites
*   Robot Framework installed (`pip install robotframework`)
*   RequestsLibrary installed (`pip install robotframework-requests`)

### How to Run Tests
To execute the tests, navigate to your project's root directory (or where `tests/q-vision-platform/Sprint2.robot` is located) and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


- `-d results/q-vision-platform/Sprint2`: Specifies the output directory for test results (log.html, report.html, output.xml).
- `tests/q-vision-platform/Sprint2.robot`: The path to the test suite file.

### Test Cases Included:
1.  **Ingest PASSED Report**: Verifies the successful ingestion of a quality report with 100% passed tests.
2.  **Ingest FAILED Report**: Verifies the successful ingestion of a quality report with a significant number of failed tests.
3.  **Get Project History**: Verifies the retrieval of quality report history for a specific project.

Each test case includes detailed logging to the console to track the request and response flow.
