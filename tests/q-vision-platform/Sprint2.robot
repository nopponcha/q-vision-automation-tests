***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session for Q-Vision Platform
Test Teardown    Log To Console    Test Case Completed.

***Variables***
${BASE_URL}    https://drinking-cloudy-choices-produce.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session for Q-Vision Platform
    Log To Console    [Suite Setup] Creating HTTP session with Base URL: ${BASE_URL}
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    [Suite Setup] Session 'q-vision-platform' created successfully.

***Test Cases***
Ingest login PASSED Report
    Log To Console    [Test Case] Starting 'Ingest login PASSED Report' test.
    Log To Console    [Step 1] Creating payload dictionary for POST request.
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${20.5}
    Log To Console    [Step 2] Sending POST request to /api/v1/quality-reports/ingest.
    ${response}=    POST On Session    q-vision-platform    /api/v1/quality-reports/ingest    json=${payload}
    Log To Console    [Step 3] Received response with Status Code: ${response.status_code}
    Log To Console    [Step 3] Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    [Step 4] Asserting 'PASSED' in response body.
    Should Contain    ${response.text}    PASSED
    Log To Console    [Test Case] 'Ingest login PASSED Report' PASSED.

Checking Missing API
    Log To Console    [Test Case] Starting 'Checking Missing API' test (Negative Testing).
    Log To Console    [Step 1] Sending GET request to a non-existent endpoint /api/v1/quality-reportsss.
    ${response}=    GET On Session    q-vision-platform    /api/v1/quality-reportsss    expected_status=any
    Log To Console    [Step 2] Received response with Status Code: ${response.status_code}
    Log To Console    [Step 2] Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    404
    Log To Console    [Step 3] Asserting 'Not Found' in response body for 404.
    Should Contain    ${response.text}    Not Found
    Log To Console    [Test Case] 'Checking Missing API' PASSED.
