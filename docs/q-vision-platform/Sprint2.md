# Q-Vision Platform API Tests - Sprint 2

This directory contains Robot Framework API tests for the `q-vision-platform` project, specifically for `Sprint2`.

## Project Structure


.
├── results/
│   └── q-vision-platform/
│       └── Sprint2/  # Test results will be stored here
└── tests/
    └── q-vision-platform/
        └── Sprint2.robot # The Robot Framework test suite


## Setup

Ensure you have Robot Framework and `robotframework-requests` library installed:

bash
pip install robotframework
pip install robotframework-requests
pip install robotframework-collections


## How to Run Tests

To execute the tests for Sprint2, navigate to the project root directory and use the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
- Run the `Sprint2.robot` test suite.
- Store all test output (logs, reports, screenshots if any) in the `results/q-vision-platform/Sprint2` directory.

## Test Cases

The `Sprint2.robot` suite includes the following test cases:

1.  **Ingest login PASSED Report**: Verifies the successful ingestion of a login report with a 'PASSED' status.
2.  **Checking Missing API**: Tests the system's response when trying to access a non-existent API endpoint, expecting a 404 Not Found error.
