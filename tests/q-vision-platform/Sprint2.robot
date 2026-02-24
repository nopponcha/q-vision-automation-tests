*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

*** Keywords ***
Create API Session
    [Documentation]    Creates a new HTTP session to the base URL.
    Log To Console    Creating API session to ${BASE_URL}
    Create Session    q_vision_api    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session created.

POST Request To Endpoint
    [Documentation]    Sends a POST request with a JSON body and verifies the status code.
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status_code}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Payload: ${payload_dict}
    ${response}=    POST On Session    q_vision_api    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}
    Return From Keyword    ${response}

GET Request To Endpoint
    [Documentation]    Sends a GET request and verifies the status code.
    [Arguments]    ${endpoint}    ${expected_status_code}
    Log To Console    Sending GET request to endpoint: ${endpoint}
    ${response}=    GET On Session    q_vision_api    ${endpoint}    headers=${HEADERS}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}
    Return From Keyword    ${response}

Verify Response Contains Expected Value
    [Documentation]    Verifies that the response body contains the specified expected value.
    [Arguments]    ${response}    ${expected_value}
    Log To Console    Verifying response body contains: "${expected_value}"
    Should Contain    ${response.text}    ${expected_value}
    Log To Console    Verification successful: Response contains "${expected_value}".

*** Test Cases ***
[Setup]    Create API Session

Ingest PASSED Report
    Log To Console    --- Starting Test Case: Ingest PASSED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=100
    ...    failed=0
    ...    duration=15.5
    Log To Console    Payload created for PASSED report.
    ${response}=    POST Request To Endpoint    /api/v1/quality-reports/ingest    ${payload}    201
    Verify Response Contains Expected Value    ${response}    PASSED
    Log To Console    --- Test Case: Ingest PASSED Report COMPLETED ---

Ingest FAILED Report
    Log To Console    --- Starting Test Case: Ingest FAILED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=10
    ...    failed=90
    ...    duration=20.0
    Log To Console    Payload created for FAILED report.
    ${response}=    POST Request To Endpoint    /api/v1/quality-reports/ingest    ${payload}    201
    Verify Response Contains Expected Value    ${response}    FAILED
    Log To Console    --- Test Case: Ingest FAILED Report COMPLETED ---

Get Project History
    Log To Console    --- Starting Test Case: Get Project History ---
    ${response}=    GET Request To Endpoint    /api/v1/quality-reports/E-Commerce    200
    Verify Response Contains Expected Value    ${response}    E-Commerce
    Log To Console    --- Test Case: Get Project History COMPLETED ---
