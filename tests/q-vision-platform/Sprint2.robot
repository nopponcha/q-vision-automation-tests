***Settings***
Library    RequestsLibrary
Library    Collections
Test Setup    Create User Session

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create User Session
    Log To Console    Creating HTTP session to ${BASE_URL}
    Create Session    q_vision_platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'q_vision_platform' created.

Send POST Request And Verify
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to ${endpoint}
    Log To Console    Payload: ${payload_dict}
    ${response}=    POST On Session    q_vision_platform    ${endpoint}    json=${payload_dict}
    Log To Console    Received status: ${response.status_code}
    Log To Console    Received body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    POST request successful and verified.

Send GET Request And Verify
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending GET request to ${endpoint}
    ${response}=    GET On Session    q_vision_platform    ${endpoint}
    Log To Console    Received status: ${response.status_code}
    Log To Console    Received body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    GET request successful and verified.

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting test: Ingest PASSED Report
    &{payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    Send POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    ${201}
    ...    PASSED
    Log To Console    Test completed: Ingest PASSED Report

Ingest FAILED Report
    Log To Console    Starting test: Ingest FAILED Report
    &{payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Send POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    ${201}
    ...    FAILED
    Log To Console    Test completed: Ingest FAILED Report

Get Project History
    Log To Console    Starting test: Get Project History
    Send GET Request And Verify
    ...    /api/v1/quality-reports/E-Commerce
    ...    ${200}
    ...    E-Commerce
    Log To Console    Test completed: Get Project History
