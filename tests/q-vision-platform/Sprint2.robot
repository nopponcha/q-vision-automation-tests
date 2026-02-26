***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create Http Session For Q-Vision Platform

***Variables***
&{HEADERS}    Content-Type=application/json
${BASE_URL}    https://loops-arm-kim-twins.trycloudflare.com

***Keywords***
Create Http Session For Q-Vision Platform
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting test: Ingest PASSED Report
    ${payload}    Create Dictionary    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=90
    ...    failed=1
    ...    duration=1
    Log To Console    Created payload: ${payload}
    Log To Console    Sending POST request to /api/v1/quality-reports/ingest with payload...
    ${response}    POST On Session    q-vision-platform    /api/v1/quality-reports/ingest    json=${payload}
    Log To Console    Response status: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Log To Console    Verifying expected status code: 201
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Verifying response body contains: PASSED
    Should Contain    ${response.text}    PASSED

Checking Missing API
    Log To Console    Starting test: Checking Missing API
    Log To Console    No payload body for this request.
    Log To Console    Sending GET request to /api/v1/quality-reportsss...
    ${response}    GET On Session    q-vision-platform    /api/v1/quality-reportsss    expected_status=any
    Log To Console    Response status: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Log To Console    Verifying expected status code: 404
    Should Be Equal As Strings    ${response.status_code}    404
    Log To Console    Verifying response body contains: Not Found
    Should Contain    ${response.text}    Not Found
