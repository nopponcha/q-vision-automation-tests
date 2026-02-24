*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create Http Session

*** Variables ***
${BASE_URL}    https://drinking-cloudy-choices-produce.trycloudflare.com
&{HEADERS}    Content-Type=application/json

*** Keywords ***
Create Http Session
    Log To Console    Creating HTTP session for ${BASE_URL}...
    Create Session    q-vision-api    ${BASE_URL}    verify=${FALSE}
    Log To Console    HTTP session created.

*** Test Cases ***
Ingest_PASSED_Report_1
    Log To Console    --- Running Test Case: Ingest PASSED Report ---
    Log To Console    Method: POST, Endpoint: /api/v1/quality-reports/ingest
    &{payload} =    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    Log To Console    Payload created: ${payload}
    ${response} =    POST On Session    q-vision-api    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Sent POST request to /api/v1/quality-reports/ingest with payload. Response received.
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Verified status code is 201.
    Should Contain    ${response.text}    PASSED
    Log To Console    Verified response body contains "PASSED".
    Log To Console    Test Case Ingest PASSED Report PASSED.

Ingest_FAILED_Report_2
    Log To Console    --- Running Test Case: Ingest FAILED Report ---
    Log To Console    Method: POST, Endpoint: /api/v1/quality-reports/ingest
    &{payload} =    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=10    failed=90    duration=20.0
    Log To Console    Payload created: ${payload}
    ${response} =    POST On Session    q-vision-api    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Sent POST request to /api/v1/quality-reports/ingest with payload. Response received.
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Verified status code is 201.
    Should Contain    ${response.text}    FAILED
    Log To Console    Verified response body contains "FAILED".
    Log To Console    Test Case Ingest FAILED Report PASSED.

Get_Project_History_3
    Log To Console    --- Running Test Case: Get Project History ---
    Log To Console    Method: GET, Endpoint: /api/v1/quality-reports/E-Commerce
    Log To Console    No payload required for this request.
    ${response} =    GET On Session    q-vision-api    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Log To Console    Sent GET request to /api/v1/quality-reports/E-Commerce. Response received.
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console    Verified status code is 200.
    Should Contain    ${response.text}    E-Commerce
    Log To Console    Verified response body contains "E-Commerce".
    Log To Console    Test Case Get Project History PASSED.

Ingest_FAILED_Report_API_4
    Log To Console    --- Running Test Case: Ingest FAILED Report API ---
    Log To Console    Method: POST, Endpoint: /api/v1/quality-reports/ingest
    &{payload} =    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Report    passed=60    failed=40    duration=25.0
    Log To Console    Payload created: ${payload}
    ${response} =    POST On Session    q-vision-api    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Sent POST request to /api/v1/quality-reports/ingest with payload. Response received.
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Verified status code is 201.
    Should Contain    ${response.text}    FAILED
    Log To Console    Verified response body contains "FAILED".
    Log To Console    Test Case Ingest FAILED Report API PASSED.

Checking_Missing_API_5
    Log To Console    --- Running Test Case: Checking Missing API ---
    Log To Console    Method: GET, Endpoint: /api/v1/quality-reportsss
    Log To Console    No payload required for this request.
    ${response} =    GET On Session    q-vision-api    /api/v1/quality-reportsss    headers=${HEADERS}    expected_status=any
    Log To Console    Sent GET request to /api/v1/quality-reportsss. Response received.
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    404
    Log To Console    Verified status code is 404.
    Should Contain    ${response.text}    Not Found
    Log To Console    Verified response body contains "Not Found".
    Log To Console    Test Case Checking Missing API PASSED.
