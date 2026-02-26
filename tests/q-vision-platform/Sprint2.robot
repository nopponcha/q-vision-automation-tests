***Settings***
Library    RequestsLibrary
Library    Collections
Test Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://compiled-ordering-spend-transactions.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Establishing HTTP session with base URL: ${BASE_URL}
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP Session 'q-vision-platform' created.

Perform POST Request And Verify
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Request Payload: ${payload}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload}    expected_status=${expected_status}
    Log To Console    Received Response Status Code: ${response.status_code}
    Log To Console    Received Response Text: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Verification successful: Status code is ${expected_status} and response contains '${expected_result_value}'.

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Starting Test Case: Ingest PASSED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${2}
    ...    failed=${1}
    ...    duration=${1}
    Perform POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    PASSED
    Log To Console    --- Test Case 'Ingest PASSED Report' Completed ---

Ingest FAILED Report
    Log To Console    --- Starting Test Case: Ingest FAILED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Perform POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    FAILED
    Log To Console    --- Test Case 'Ingest FAILED Report' Completed ---
