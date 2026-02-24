This document outlines how to run the Robot Framework API tests for the `q-vision-platform` project, specifically for `Sprint2`.

### Project Structure

.
├── results/
│   └── q-vision-platform/
│       └── Sprint2/  (Test execution results will be stored here)
└── tests/
    └── q-vision-platform/
        └── Sprint2.robot (The main test suite file)


### Prerequisites
- Robot Framework installed.
- RequestsLibrary and Collections Library installed (`pip install robotframework-requests robotframework-collections`).

### How to Run Tests
To execute the test suite, navigate to the root directory of your project (where `tests` and `results` folders are located) and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


### Test Reports
After execution, test reports (log.html, report.html, output.xml) will be generated in the `results/q-vision-platform/Sprint2` directory.

### Test Cases Included:
1.  **Ingest PASSED Report**: Verifies the successful ingestion of a quality report with a 'PASSED' status.
2.  **Ingest FAILED Report**: Verifies the successful ingestion of a quality report with a 'FAILED' status.
3.  **Get Project History**: Retrieves the history for a specific project and verifies its name.
4.  **Ingest FAILED Report API**: Another test case for ingesting a quality report with a 'FAILED' status, using different feature data.
5.  **Checking Missing API**: Tests the behavior of accessing a non-existent API endpoint, expecting a 404 'Not Found' response.
