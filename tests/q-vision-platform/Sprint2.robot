***Settings***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

***Variables***
${BASE_URL}    http://localhost:8080
&{HEADERS}    Content-Type=application/json

***Keywords***
Setup Test Session
    Log To Console    INFO: Setting up test session for Base URL: ${BASE_URL}
    Create Session    q-vision-api    ${BASE_URL}    disable_warnings=True

Send POST Request And Verify Status
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}
    Log To Console    INFO: Sending POST request to ${endpoint} with payload: ${payload_dict}
    ${response}=    POST Request    q-vision-api    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    INFO: Received status code: ${response.status_code}
    Log To Console    INFO: Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Set Test Variable    ${response}    ${response}
    [Return]    ${response}

Send GET Request And Verify Status
    [Arguments]    ${endpoint}    ${expected_status}
    Log To Console    INFO: Sending GET request to ${endpoint}
    ${response}=    GET Request    q-vision-api    ${endpoint}    headers=${HEADERS}
    Log To Console    INFO: Received status code: ${response.status_code}
    Log To Console    INFO: Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Set Test Variable    ${response}    ${response}
    [Return]    ${response}

Verify Response Body Contains Value
    [Arguments]    ${response}    ${key}    ${expected_value}
    Log To Console    INFO: Verifying response body contains '${key}: ${expected_value}'
    ${json_body}=    Convert To Dictionary    ${response.json()}
    ${actual_value}=    Get From Dictionary    ${json_body}    ${key}
    Should Be Equal As Strings    ${actual_value}    ${expected_value}

***Test Cases***
Setup    Setup Test Session

Ingest_PASSED_Report
    Log To Console    ### Running Test Case: Ingest PASSED Report ###
    Log To Console    Test Description: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    &{PAYLOAD}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=${100}    failed=${0}    duration=${15.5}
    ${response}=    Send POST Request And Verify Status    /api/v1/quality-reports/ingest    ${PAYLOAD}    201
    Verify Response Body Contains Value    ${response}    status    PASSED

Ingest_FAILED_Report
    Log To Console    ### Running Test Case: Ingest FAILED Report ###
    Log To Console    Test Description: 1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
    &{PAYLOAD}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=${100}    failed=${90}    duration=${10.0}
    ${response}=    Send POST Request And Verify Status    /api/v1/quality-reports/ingest    ${PAYLOAD}    201
    Verify Response Body Contains Value    ${response}    status    FAILED

Get_Project_History
    Log To Console    ### Running Test Case: Get Project History ###
    Log To Console    Test Description: 1. GET by project name 2. Check 200 3. Body has project name
    ${response}=    Send GET Request And Verify Status    /api/v1/quality-reports/E-Commerce    200
    Verify Response Body Contains Value    ${response}    projectName    E-Commerce