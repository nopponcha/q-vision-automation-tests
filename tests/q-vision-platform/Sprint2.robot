***Settings***
Library    RequestsLibrary
Library    Collections
Test Setup    Create HTTP Session

***Variables***
${BASE_URL}     https://fly-powell-firm-offline.trycloudflare.com
&{HEADERS}      Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Creating HTTP session with Base URL: ${BASE_URL}
    Create Session    q-vision-api    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'q-vision-api' created successfully.

Create Ingest Report Payload
    [Arguments]    ${projectName}    ${sprintName}    ${featureName}    ${passed}    ${failed}    ${duration}
    Log To Console    Preparing payload for Project: ${projectName}, Sprint: ${sprintName}
    ${payload}=    Create Dictionary
    ...    projectName=${projectName}
    ...    sprintName=${sprintName}
    ...    featureName=${featureName}
    ...    passed=${passed}
    ...    failed=${failed}
    ...    duration=${duration}
    [Return]    ${payload}

Verify API Response
    [Arguments]    ${response}    ${expected_status}    ${expected_result_value}
    Log To Console    Verifying API response status code and content.
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Response contains expected value: ${expected_result_value}

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Starting Test Case: Ingest PASSED Report ---
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    Log To Console    Sending POST request to endpoint: ${endpoint}
    ${payload}=    Create Ingest Report Payload
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=90
    ...    failed=1
    ...    duration=1
    Log To Console    Payload for PASSED report created.
    ${response}=    POST On Session    q-vision-api    ${endpoint}    json=${payload}
    Log To Console    POST request sent for PASSED report.
    Verify API Response    ${response}    201    PASSED
    Log To Console    --- Finished Test Case: Ingest PASSED Report ---

Ingest FAILED Report
    Log To Console    --- Starting Test Case: Ingest FAILED Report ---
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    Log To Console    Sending POST request to endpoint: ${endpoint}
    ${payload}=    Create Ingest Report Payload
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=90
    ...    failed=10
    ...    duration=20.0
    Log To Console    Payload for FAILED report created.
    ${response}=    POST On Session    q-vision-api    ${endpoint}    json=${payload}
    Log To Console    POST request sent for FAILED report.
    Verify API Response    ${response}    201    FAILED
    Log To Console    --- Finished Test Case: Ingest FAILED Report ---