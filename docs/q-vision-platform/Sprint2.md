# Project: Q-Vision Platform - Sprint 2 API Automation

This project contains automated API tests for the Q-Vision Platform, specifically for Sprint 2 functionalities. The tests are written using Robot Framework, leveraging `RequestsLibrary` for API interactions and `Collections` for data manipulation.

## Table of Contents
- [Prerequisites](#prerequisites)
- [How to Run Tests](#how-to-run-tests)
- [Test Cases](#test-cases)

## Prerequisites
Before running the tests, ensure you have the following installed:
- Python 3.x
- Robot Framework
- RequestsLibrary (`pip install robotframework-requests`)
- Collections (built-in with Robot Framework)

You## How to Run Tests
To execute the tests for Sprint 2, navigate to the root directory of your project and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


This command will:
- `-d results/q-vision-platform/Sprint2`: Create a directory named `results/q-vision-platform/Sprint2` and save the test reports (log.html, report.html, output.xml) within it.
- `tests/q-vision-platform/Sprint2.robot`: Execute the test suite located at this path.

## Test Cases

### Ingest PASSED Report
- **Description**: This test case verifies the successful ingestion of a quality report with a 'PASSED' status.
- **Endpoint**: `POST /api/v1/quality-reports/ingest`
- **Expected Status**: `201 Created`
- **Expected Result**: The response body should indicate `status: PASSED`.
