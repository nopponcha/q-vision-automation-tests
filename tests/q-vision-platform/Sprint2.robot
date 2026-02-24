***Settings***
Documentation    API Test Suite for q-vision-platform - Sprint2
Library          RequestsLibrary
Library          Collections
Test Setup       Create HTTP Session
Test Teardown    Delete All Sessions

***Variables***
${BASE_URL}      https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}       Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Setting up HTTP session to ${BASE_URL}
    Create Session    api_session    ${BASE_URL}    verify=${FALSE}    headers=${HEADERS}

Send POST Request
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to ${endpoint} with payload: ${payload_dict}
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload_dict}
    Log To Console    Response status: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    POST request completed successfully.

Send GET Request And Verify
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending GET request to ${endpoint}
    ${response}=    GET On Session    api_session    ${endpoint}
    Log To Console    Response status: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    GET request completed successfully.

***Test Cases***
Scenario: Ingest PASSED Report
    Log To Console    Preparing payload for POST request for 'Ingest PASSED Report'.
    &{payload_data}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=${100}    failed=${0}    duration=${15.5}
    Send POST Request    /api/v1/quality-reports/ingest    ${payload_data}    201    PASSED

Scenario: Ingest FAILED Report
    Log To Console    Preparing payload for POST request for 'Ingest FAILED Report'.
    &{payload_data}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=${10}    failed=${90}    duration=${10.0}
    Send POST Request    /api/v1/quality-reports/ingest    ${payload_data}    201    FAILED

Scenario: Get Project History
    Log To Console    Executing GET request for 'Get Project History'.
    Send GET Request And Verify    /api/v1/quality-reports/E-Commerce    200    E-Commerce