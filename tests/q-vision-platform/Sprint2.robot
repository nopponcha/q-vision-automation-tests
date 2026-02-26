*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Setup Test Environment

*** Variables ***
&{HEADERS}    Content-Type=application/json
${BASE_URL}    https://loops-arm-kim-twins.trycloudflare.com

*** Keywords ***
Setup Test Environment
    Log To Console    Setting up test environment and creating HTTP session.
    Evaluate    urllib3.disable_warnings()    modules=urllib3
    Create Session    mysession    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'mysession' created with base URL: ${BASE_URL}

Perform POST Request And Verify Response
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_content_value}
    Log To Console    Sending POST request to ${endpoint} with payload: ${payload_dict}
    ${response}=    POST On Session    mysession    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response text: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Log To Console    Response status code is as expected: ${expected_status}
    Should Contain    ${response.text}    ${expected_content_value}
    Log To Console    Response content contains expected value: ${expected_content_value}

*** Test Cases ***
Ingest PASSED Report
    Log To Console    Starting Test Case: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    Perform POST Request And Verify Response
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    PASSED
    Log To Console    Test Case 'Ingest PASSED Report' Completed.

Ingest FAILED Report
    Log To Console    Starting Test Case: Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Perform POST Request And Verify Response
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    FAILED
    Log To Console    Test Case 'Ingest FAILED Report' Completed.
