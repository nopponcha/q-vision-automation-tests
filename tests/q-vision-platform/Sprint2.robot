***Settings***
Documentation    API tests for q-vision-platform Sprint2
Library          RequestsLibrary
Library          Collections

***Variables***
${BASE_URL}      https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}       Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Creating API session with base URL: ${BASE_URL}
    Create Session    api_session    ${BASE_URL}

Send POST Request And Verify
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_text}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Payload: ${payload_dict}
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload_dict}    headers=&{HEADERS}
    Set Global Variable    ${response}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_text}

Send GET Request And Verify
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_result_text}
    Log To Console    Sending GET request to endpoint: ${endpoint}
    ${response}=    GET On Session    api_session    ${endpoint}    headers=&{HEADERS}
    Set Global Variable    ${response}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_text}

***Test Cases***
Ingest PASSED Report
    [Setup]    Create API Session
    Log To Console    --- Executing Test Case: Ingest PASSED Report ---
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    Send POST Request And Verify    /api/v1/quality-reports/ingest    ${payload}    201    status: PASSED

Ingest FAILED Report
    [Setup]    Create API Session
    Log To Console    --- Executing Test Case: Ingest FAILED Report ---
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=100    failed=90    duration=15.0
    Send POST Request And Verify    /api/v1/quality-reports/ingest    ${payload}    201    status: FAILED

Get Project History
    [Setup]    Create API Session
    Log To Console    --- Executing Test Case: Get Project History ---
    Send GET Request And Verify    /api/v1/quality-reports/E-Commerce    200    projectName: E-Commerce
