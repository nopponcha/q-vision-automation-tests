*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json
${SESSION_ALIAS} =    qvision_api

*** Keywords ***
Create API Session
    Log To Console    Creating API session with base URL: ${BASE_URL}
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session created successfully.

Send POST Request
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_text_value}
    Log To Console    Sending POST request to ${endpoint}
    Log To Console    Payload: ${payload}
    ${response}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    expected_status=any
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_text_value}
    Log To Console    POST request completed and verified.

Send GET Request
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_text_value}
    Log To Console    Sending GET request to ${endpoint}
    ${response}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}    expected_status=any
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_text_value}
    Log To Console    GET request completed and verified.

*** Test Cases ***
Ingest PASSED Report
    [Setup]    Create API Session
    Log To Console    Starting test case: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${1.5}
    Send POST Request    /api/v1/quality-reports/ingest    ${payload}    201    PASSED

Ingest FAILED Report
    [Setup]    Create API Session
    Log To Console    Starting test case: Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${10.0}
    Send POST Request    /api/v1/quality-reports/ingest    ${payload}    201    FAILED

Get Project History
    [Setup]    Create API Session
    Log To Console    Starting test case: Get Project History
    Send GET Request    /api/v1/quality-reports/E-Commerce    200    E-Commerce

Checking Missing API
    [Setup]    Create API Session
    Log To Console    Starting test case: Checking Missing API
    Send GET Request    /api/v1/quality-reportsss    404    Not Found
