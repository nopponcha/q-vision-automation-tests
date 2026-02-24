***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create HTTP Session For API Testing

***Variables***
${BASE_URL}     https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}      Content-Type=application/json    Accept=application/json

***Keywords***
Create HTTP Session For API Testing
    Log To Console    Setting up HTTP session for API testing...
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    Session 'q-vision-platform' created with base URL: ${BASE_URL}

Post Quality Report Data
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_body_value}
    Log To Console    Sending POST request to ${endpoint} with payload: ${payload_dict}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload_dict}
    Log To Console    Received status code: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_body_value}

Get Quality Report Data
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_body_value}
    Log To Console    Sending GET request to ${endpoint}
    ${response}=    GET On Session    q-vision-platform    ${endpoint}
    Log To Console    Received status code: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_body_value}

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting test: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    Post Quality Report Data    /api/v1/quality-reports/ingest    ${payload}    201    PASSED
    Log To Console    Test 'Ingest PASSED Report' completed.

Ingest FAILED Report
    Log To Console    Starting test: Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Post Quality Report Data    /api/v1/quality-reports/ingest    ${payload}    201    FAILED
    Log To Console    Test 'Ingest FAILED Report' completed.

Get Project History
    Log To Console    Starting test: Get Project History
    Get Quality Report Data    /api/v1/quality-reports/E-Commerce    200    E-Commerce
    Log To Console    Test 'Get Project History' completed.

Ingest FAILED Report API
    Log To Console    Starting test: Ingest FAILED Report API
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Report
    ...    passed=${60}
    ...    failed=${40}
    ...    duration=${25.0}
    Post Quality Report Data    /api/v1/quality-reports/ingest    ${payload}    201    FAILED
    Log To Console    Test 'Ingest FAILED Report API' completed.

Checking Missing API
    Log To Console    Starting test: Checking Missing API
    Get Quality Report Data    /api/v1/quality-reportsss    404    Not Found
    Log To Console    Test 'Checking Missing API' completed.