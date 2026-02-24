*** Settings ***
Library    RequestsLibrary
Library    Collections
Test Setup    Create API Session

*** Variables ***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}    Content-Type=application/json

*** Keywords ***
Create API Session
    Log To Console    -- Starting Test Session --
    Log To Console    Creating API session with base URL: ${BASE_URL}
    Create Session    mysession    ${BASE_URL}    verify=${FALSE}
    Log To Console    Session 'mysession' created successfully.

*** Test Cases ***
Ingest PASSED Report
    Log To Console    \n--- Running Test Case: Ingest PASSED Report ---
    Log To Console    1. Sending POST request to ingest a PASSED report.
    ${payload}=    Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ${response}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    2. Checking response status code is 201.
    Status Should Be    201    ${response}
    Log To Console    3. Verifying status is PASSED in the response body.
    Should Contain    ${response.text}    PASSED
    Log To Console    Test Case 'Ingest PASSED Report' PASSED.

Ingest FAILED Report
    Log To Console    \n--- Running Test Case: Ingest FAILED Report ---
    Log To Console    1. Sending POST request with failed > 0.
    ${payload}=    Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 90, "failed": 10, "duration": 15.0}
    ${response}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    2. Checking response status code is 201.
    Status Should Be    201    ${response}
    Log To Console    3. Verifying status is FAILED in the response body.
    Should Contain    ${response.text}    FAILED
    Log To Console    Test Case 'Ingest FAILED Report' PASSED.

Get Project History
    Log To Console    \n--- Running Test Case: Get Project History ---
    Log To Console    1. Sending GET request by project name 'E-Commerce'.
    ${response}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Log To Console    2. Checking response status code is 200.
    Status Should Be    200    ${response}
    Log To Console    3. Verifying response body contains the project name 'E-Commerce'.
    Should Contain    ${response.text}    E-Commerce
    Log To Console    Test Case 'Get Project History' PASSED.
