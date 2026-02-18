# Project: q-vision-platform
## Sprint: Sprint2

### API Test Plan Summary
This document outlines the API test cases executed for the `q-vision-platform` project during `Sprint2`.

| Test Name | Method | Endpoint | Expected Status | Expected Result |
|---|---|---|---|---|
| Ingest PASSED Report | POST | /api/v1/quality-reports/ingest | 201 | status: PASSED |
| Ingest FAILED Report | POST | /api/v1/quality-reports/ingest | 201 | status: FAILED |
| Get Project History | GET | /api/v1/quality-reports/E-Commerce | 200 | projectName: E-Commerce |
| Get Feature History | GET | /api/v1/quality-reports/E-Commerce/Sprint2/Login/history | 200 | featureName: Login |

### How to Run Tests
1.  **Prerequisites:**
    *   Python 3 installed.
    *   Robot Framework installed (`pip install robotframework`).
    *   RequestsLibrary installed (`pip install robotframework-requests`).

2.  **Environment Setup:**
    *   Ensure the API service is running, preferably on `http://localhost:3000` or update the `BASE_URL` variable in the `.robot` file.
    *   If using `ngrok`, update `BASE_URL` to your ngrok URL (e.g., `https://<your_ngrok_id>.ngrok.io`).

3.  **Run Tests:**
    Navigate to the directory containing the `.robot` file and execute the following command:
    bash
    robot -d results tests/q-vision-platform/Sprint2.robot
    
    (Adjust the path `tests/q-vision-platform/Sprint2.robot` if your file structure differs.)

4.  **View Results:**
    After execution, detailed HTML reports will be generated in the `results` directory.
    Open `results/log.html` or `results/report.html` in your web browser to view the test outcomes.