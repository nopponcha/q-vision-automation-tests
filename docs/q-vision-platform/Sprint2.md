# Project: q-vision-platform
# Sprint: Sprint2

This directory contains Robot Framework test automation scripts for the `q-vision-platform` project, specifically for `Sprint2`.

## Running Tests

To execute the tests, navigate to the root of your test project and run the following command:

bash
robot -d results/q-vision-platform/Sprint2 tests/q-vision-platform/Sprint2.robot


## Test Case Details

### Ingest PASSED Report

This test case verifies the successful ingestion of a quality report with a 'PASSED' status.

- **Method**: POST
- **Endpoint**: `/api/v1/quality-reports/ingest`
- **Expected Status Code**: `201`
- **Expected Result**: The response body should indicate a `PASSED` status.
