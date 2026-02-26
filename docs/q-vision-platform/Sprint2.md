## Project: Q-Vision Platform - Sprint 2 API Automation Tests

This directory contains Robot Framework test suites for the 'Q-Vision Platform' project, specifically targeting APIs for 'Sprint2'. The tests are designed to run on a CI/CD pipeline.

### Prerequisites
*   Robot Framework installed.
*   RequestsLibrary and Collections libraries installed (`pip install robotframework-requests robotframework-collections`).

### How to Run Tests
To execute the tests for Sprint2, navigate to your project's root directory (where `tests` folder is located) and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


### Test Reports
Upon successful execution, test reports (log.html, report.html, output.xml) will be generated in the `results/q-vision-platform/Sprint2` directory.

### Test Cases Included:
*   **Ingest PASSED Report**: Verifies the successful ingestion of a quality report with a 'PASSED' status.
*   **Ingest FAILED Report**: Verifies the successful ingestion of a quality report with a 'FAILED' status.
