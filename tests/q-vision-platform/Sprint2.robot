***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup       Create HTTP Session
Test Setup        Log To Console    Starting a new test case...

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Creating HTTP session for ${BASE_URL}
    Create Session    api_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'api_session' created successfully.

Perform POST Request And Verify
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_body_value}
    Log To Console    Sending POST request to ${endpoint} with payload: ${payload_dict}
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_body_value}
    Log To Console    POST request completed and verified.

Perform GET Request And Verify
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_body_value}
    Log To Console    Sending GET request to ${endpoint}.
    ${response}=    GET On Session    api_session    ${endpoint}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_body_value}
    Log To Console    GET request completed and verified.

***Test Cases***
Ingest PASSED Report
    Log To Console    Executing Test Case: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    Perform POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    PASSED
    Log To Console    Test Case: Ingest PASSED Report completed.

Ingest FAILED Report
    Log To Console    Executing Test Case: Ingest FAILED Report
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
    Log To Console    Test Case: Ingest FAILED Report completed.

Get Project History
    Log To Console    Executing Test Case: Get Project History
    Perform GET Request And Verify
    ...    /api/v1/quality-reports/E-Commerce
    ...    200
    ...    E-Commerce
    Log To Console    Test Case: Get Project History completed.

Ingest FAILED Report API
    Log To Console    Executing Test Case: Ingest FAILED Report API
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Report
    ...    passed=${50}
    ...    failed=${50}
    ...    duration=${10.0}
    Perform POST Request And Verify
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    FAILED
    Log To Console    Test Case: Ingest FAILED Report API completed.