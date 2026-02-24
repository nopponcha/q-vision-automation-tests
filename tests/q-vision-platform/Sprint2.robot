***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create API Session

***Variables***
${BASE_URL}     https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}      Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Setting up API session...
    Create Session    mysession    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session 'mysession' created with base URL: ${BASE_URL}

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Test Case: Ingest PASSED Report ---
    Log To Console    Step 1: Preparing payload for a PASSED quality report.
    &{payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    Log To Console    Step 2: Sending POST request to ingest the report.
    ${response}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Step 3: Verifying the HTTP status code is 201 Created.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Step 4: Verifying the response body indicates 'PASSED' status.
    Should Contain    ${response.text}    PASSED
    Log To Console    Test case 'Ingest PASSED Report' completed successfully.

Ingest FAILED Report
    Log To Console    --- Test Case: Ingest FAILED Report ---
    Log To Console    Step 1: Preparing payload for a FAILED quality report.
    &{payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=10    failed=90    duration=20.0
    Log To Console    Step 2: Sending POST request to ingest the report.
    ${response}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Step 3: Verifying the HTTP status code is 201 Created.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Step 4: Verifying the response body indicates 'FAILED' status.
    Should Contain    ${response.text}    FAILED
    Log To Console    Test case 'Ingest FAILED Report' completed successfully.

Get Project History
    Log To Console    --- Test Case: Get Project History ---
    Log To Console    Step 1: Sending GET request to retrieve project history for 'E-Commerce'.
    ${response}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Log To Console    Step 2: Verifying the HTTP status code is 200 OK.
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Step 3: Verifying the response body contains the project name 'E-Commerce'.
    Should Contain    ${response.text}    E-Commerce
    Log To Console    Test case 'Get Project History' completed successfully.

Ingest FAILED Report API
    Log To Console    --- Test Case: Ingest FAILED Report API ---
    Log To Console    Step 1: Preparing payload for another FAILED quality report.
    &{payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Report    passed=60    failed=40    duration=25.0
    Log To Console    Step 2: Sending POST request to ingest the report.
    ${response}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Step 3: Verifying the HTTP status code is 201 Created.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Step 4: Verifying the response body indicates 'FAILED' status.
    Should Contain    ${response.text}    FAILED
    Log To Console    Test case 'Ingest FAILED Report API' completed successfully.

Checking Missing API
    Log To Console    --- Test Case: Checking Missing API ---
    Log To Console    Step 1: Sending GET request to a non-existent API endpoint.
    ${response}=    GET On Session    mysession    /api/v1/quality-reportsss    headers=${HEADERS}    expected_status=any
    Log To Console    Step 2: Verifying the HTTP status code is 404 Not Found.
    Should Be Equal As Strings    ${response.status_code}    404
    Log To Console    Step 3: Verifying the response body contains 'Not Found' error message.
    Should Contain    ${response.text}    Not Found
    Log To Console    Test case 'Checking Missing API' completed successfully.
