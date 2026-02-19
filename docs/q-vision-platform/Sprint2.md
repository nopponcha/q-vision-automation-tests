# Q-Vision Platform - Sprint 2 API Test Automation

This project contains Robot Framework tests for the `q-vision-platform` API, specifically for `Sprint2` functionalities.

## Project Structure


.
├── tests
│   └── q-vision-platform
│       └── Sprint2.robot
└── README.md


## Prerequisites

Before running the tests, ensure you have:

*   Python 3 installed
*   Robot Framework installed (`pip install robotframework`)
*   Robot Framework RequestsLibrary installed (`pip install robotframework-requests`)
*   Robot Framework Collections library (usually bundled with Robot Framework, but if issues, `pip install robotframework-collections`)

## Configuration

The base URL for the API can be configured in the `tests/q-vision-platform/Sprint2.robot` file under the `*** Variables ***` section:

robotframework
*** Variables ***
${BASE_URL}    http://localhost:8000  # Modify this to your API's base URL
&{HEADERS}    Content-Type=application/json


## How to Run Tests

To execute the tests and generate results in a structured artifact directory, use the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
*   Run all test cases defined in `Sprint2.robot`.
*   Create a directory `results/q-vision-platform/Sprint2`.
*   Store test execution logs (log.html), reports (report.html), and output XML (output.xml) in the created directory. These files are crucial for CI/CD artifact collection.

## Test Cases

The `Sprint2.robot` file includes the following API test cases:

*   **Ingest PASSED Report**: Verifies the API's ability to ingest a quality report where all tests have passed, expecting a `201` status code and a `PASSED` report status.
*   **Ingest FAILED Report**: Verifies the API's ability to ingest a quality report where some tests have failed, expecting a `201` status code and a `FAILED` report status.

Each test case includes detailed logging to the console, making it easy to track progress and debug during CI/CD pipeline runs.
