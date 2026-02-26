# Project: q-vision-platform
## Sprint: Sprint2 - API Automation Tests

This directory contains Robot Framework API automation tests for the `q-vision-platform` project, specifically for `Sprint2`.

### Prerequisites
- Robot Framework installed.
- RequestsLibrary and Collections libraries installed (`pip install robotframework-requests robotframework-collections`).

### Running Tests
To execute these tests, navigate to the root of your project and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
- Run the `Sprint2.robot` test suite.
- Store the test results (log.html, report.html, output.xml) in the `results/q-vision-platform/Sprint2` directory.

### Test Scenarios Included:
1.  **Ingest PASSED Report**: Verifies the successful ingestion of a quality report with a 'PASSED' status.
2.  **Ingest FAILED Report**: Verifies the successful ingestion of a quality report with a 'FAILED' status.
3.  **Checking Missing API**: Tests for expected `404 Not Found` response when accessing a non-existent API endpoint.
