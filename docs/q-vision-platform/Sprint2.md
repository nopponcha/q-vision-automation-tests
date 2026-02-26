# Q-Vision Platform API Tests - Sprint 2

This directory contains Robot Framework API tests for the `q-vision-platform` project, specifically for `Sprint2`.

## Setup
Before running the tests, ensure you have Robot Framework and the `robotframework-requests` library installed:

bash
pip install robotframework
pip install robotframework-requests


## Running Tests
To execute all test cases for Sprint 2, use the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
- Run the `Sprint2.robot` test suite.
- Store the test results (log.html, report.html, output.xml) in the `results/q-vision-platform/Sprint2` directory.

## Test Cases Included:
1.  **Ingest PASSED Report**: Tests the API's ability to ingest a quality report with a `PASSED` status.
2.  **Ingest FAILED Report**: Tests the API's ability to ingest a quality report with a `FAILED` status.

## Configuration
-   **Base URL**: `https://uri-angeles-reserves-rica.trycloudflare.com`
-   **Headers**: All requests include `Content-Type: application/json`.
-   **SSL Verification**: Disabled (`verify=False`) for session creation.