# Robot Framework API Tests for q-vision-platform (Sprint Sprint2)

This repository contains automated API tests for the `q-vision-platform` project, focusing on `Sprint Sprint2`.

## Configuration
- **Base URL**: `https://d3a0-49-237-45-161.ngrok-free.app`

## Test Cases
- Ingest PASSED Report: POST /api/v1/quality-reports/ingest -> Expected Status: 201, Expected Result: status: PASSED
- Ingest FAILED Report: POST /api/v1/quality-reports/ingest -> Expected Status: 201, Expected Result: status: FAILED
- Get Project History: GET /api/v1/quality-reports/E-Commerce -> Expected Status: 200, Expected Result: projectName: E-Commerce

## How to Run
1.  Ensure you have Robot Framework and `RequestsLibrary` installed (`pip install robotframework robotframework-requests`).
2.  Save the generated robot code as `q_vision_platform_sprint2.robot`.
3.  Run the tests from your terminal:
    bash
    robot q_vision_platform_sprint2.robot
    
4.  View the test results in `log.html`, `report.html`, and `output.xml`.
