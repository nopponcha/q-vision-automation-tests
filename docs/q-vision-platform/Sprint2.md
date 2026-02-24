# q-vision-platform - Sprint2 API Test Automation

This project contains Robot Framework API test suites for the `q-vision-platform` application, focusing on `Sprint2` functionalities.

## Prerequisites

*   Python 3.x installed
*   Robot Framework installed (`pip install robotframework`)
*   RequestsLibrary installed (`pip install robotframework-requests`)
*   Collections Library (built-in with Robot Framework)

## How to Run Tests

Navigate to the root directory of your test automation project in the terminal and execute the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
*   Run the `Sprint2.robot` test suite.
*   Output results (log.html, report.html, output.xml) into the `results/q-vision-platform/Sprint2` directory.

## Test Suite: Sprint2.robot

This suite covers the following API test cases:

*   **Ingest PASSED Report**: Tests the ingestion of a successful quality report via POST request, expecting a `201` status and 'PASSED' in the response.
*   **Ingest FAILED Report**: Tests the ingestion of a failed quality report via POST request, expecting a `201` status and 'FAILED' in the response.
*   **Get Project History**: Tests retrieving project history via GET request for 'E-Commerce', expecting a `200` status and 'E-Commerce' in the response.
*   **Ingest FAILED Report API**: Another test for ingesting a failed quality report via POST, expecting a `201` status and 'FAILED' in the response.
