# API Test Automation - q-vision-platform - Sprint2

## Overview
This directory contains API automation tests for the `q-vision-platform` project, specifically targeting the `Sprint2` sprint. These tests ensure the correct functionality and integration of the platform's APIs according to the defined specifications.

## Prerequisites
- Robot Framework installed.
- RequestsLibrary installed (`pip install robotframework-requests`).
- Collections Library (usually bundled with Robot Framework).

## Test Environment Configuration
The base URL for the API is configured in `Sprint2.robot`. It's recommended to manage this via environment variables for different environments (e.g., Development, Staging, Production).

**Current Placeholder:**
`robot_code` includes:
robotframework
${BASE_URL}    http://localhost:8080

**To override this:**
You can pass the base URL as a variable when running tests:
`robot -v BASE_URL:https://api.your-prod-env.com -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot`

## How to Run Tests
Navigate to the root of your test project and execute the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


### Explanation of the command:
- `robot`: The command to run Robot Framework tests.
- `-d results/q-vision-platform/Sprint2`: Specifies the output directory for test results (log.html, report.html, output.xml). This helps organize results by project and sprint.
- `tests/q-vision-platform/Sprint2.robot`: The path to the test suite file to be executed.

## Test Cases Included in this Suite
The following test cases are covered:
- **Ingest PASSED Report**: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
  - Method: POST
  - Endpoint: /api/v1/quality-reports/ingest
  - Expected Status: 201
  - Expected Result: status: PASSED
  - Payload: {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
- **Ingest FAILED Report**: 1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
  - Method: POST
  - Endpoint: /api/v1/quality-reports/ingest
  - Expected Status: 201
  - Expected Result: status: FAILED
  - Payload: {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 100, "failed": 90, "duration": 10.0}
- **Get Project History**: 1. GET by project name 2. Check 200 3. Body has project name
  - Method: GET
  - Endpoint: /api/v1/quality-reports/E-Commerce
  - Expected Status: 200
  - Expected Result: projectName: E-Commerce

## CI/CD Integration
This test suite is designed to be run as part of a CI/CD pipeline. The `-d` option ensures that results are stored in a structured way, making them easy to retrieve as build artifacts.

Example CI/CD step (e.g., in GitHub Actions, GitLab CI, Jenkins):
yaml
- name: Run Robot Framework API Tests
  run: robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot
- name: Upload Test Results
  uses: actions/upload-artifact@v3 # For GitHub Actions
  if: always()
  with:
    name: robot-framework-test-results-q-vision-platform-Sprint2
    path: results/q-vision-platform/Sprint2
