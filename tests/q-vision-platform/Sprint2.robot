***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session
Test Setup     Log Test Case Start
Test Teardown  Log Test Case End

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    [Documentation]    Creates an HTTP session for the base URL.
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP Session 'q-vision-platform' created with base URL: ${BASE_URL}

Log Test Case Start
    [Documentation]    Logs the start of a test case.
    Log To Console    ----------------------------------------------------------------------
    Log To Console    Starting Test Case: ${TEST_NAME}

Log Test Case End
    [Documentation]    Logs the end of a test case.
    Log To Console    Finished Test Case: ${TEST_NAME}
    Log To Console    ----------------------------------------------------------------------

Send POST Request And Verify
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to: ${endpoint} with payload: ${payload_dict}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Status Should Be    ${expected_status}    ${response}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Assertion successful: Response contains '${expected_result_value}' and status is '${expected_status}'.

Send GET Request And Verify
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending GET request to: ${endpoint}
    ${response}=    GET On Session    q-vision-platform    ${endpoint}    headers=${HEADERS}
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Status Should Be    ${expected_status}    ${response}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Assertion successful: Response contains '${expected_result_value}' and status is '${expected_status}'.

***Test Cases***
Ingest PASSED Report
    Log To Console    Test Step: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=100
    ...    failed=0
    ...    duration=15.5
    Send POST Request And Verify    /api/v1/quality-reports/ingest    ${payload}    201    PASSED

Ingest FAILED Report - Payment Feature (First Instance)
    Log To Console    Test Step: 1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=10
    ...    failed=90
    ...    duration=20.0
    Send POST Request And Verify    /api/v1/quality-reports/ingest    ${payload}    201    FAILED

Get Project History - E-Commerce
    Log To Console    Test Step: 1. GET by project name 2. Check 200 3. Body has project name
    Send GET Request And Verify    /api/v1/quality-reports/E-Commerce    200    E-Commerce

Ingest FAILED Report - Payment Feature (Second Instance)
    Log To Console    Test Step: 1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=10
    ...    failed=90
    ...    duration=20.0
    Send POST Request And Verify    /api/v1/quality-reports/ingest    ${payload}    201    FAILED