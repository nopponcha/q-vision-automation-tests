***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create API Session

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Setting up API session...
    Create Session    api_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session created successfully.

Send POST Request And Verify Response
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_text_value}
    Log To Console    Sending POST request to ${endpoint}
    Log To Console    Payload: ${payload}
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_text_value}
    Log To Console    POST request successful and response verified.

Send GET Request And Verify Response
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_text_value}
    Log To Console    Sending GET request to ${endpoint}
    ${response}=    GET On Session    api_session    ${endpoint}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_text_value}
    Log To Console    GET request successful and response verified.

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting Test Case: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    Send POST Request And Verify Response    /api/v1/quality-reports/ingest    ${payload}    201    PASSED

Ingest FAILED Report
    Log To Console    Starting Test Case: Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Send POST Request And Verify Response    /api/v1/quality-reports/ingest    ${payload}    201    FAILED

Get Project History
    Log To Console    Starting Test Case: Get Project History
    Send GET Request And Verify Response    /api/v1/quality-reports/E-Commerce    200    E-Commerce

Ingest FAILED Report API
    Log To Console    Starting Test Case: Ingest FAILED Report API
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Report
    ...    passed=${50}
    ...    failed=${50}
    ...    duration=${10.0}
    Send POST Request And Verify Response    /api/v1/quality-reports/ingest    ${payload}    201    FAILED

Checking Missing API
    Log To Console    Starting Test Case: Checking Missing API
    Send GET Request And Verify Response    /api/v1/quality-reportsss    404    quality-reportsss
