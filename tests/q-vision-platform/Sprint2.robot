***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session
Test Teardown    Delete All Sessions

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json    Accept=application/json

***Keywords***
Create HTTP Session
    Log To Console    Creating HTTP session to ${BASE_URL}
    Create Session    q-vision-platform    ${BASE_URL}    verify=${FALSE}    headers=&{HEADERS}
    Log To Console    HTTP session created successfully.

Send POST Request To Ingest Report
    [Arguments]    ${endpoint}    ${project_name}    ${sprint_name}    ${feature_name}    ${passed_count}    ${failed_count}    ${duration_value}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to ingest report for project: ${project_name}, feature: ${feature_name}
    ${payload}=    Create Dictionary
    ...    projectName=${project_name}
    ...    sprintName=${sprint_name}
    ...    featureName=${feature_name}
    ...    passed=${passed_count}
    ...    failed=${failed_count}
    ...    duration=${duration_value}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload}    headers=${HEADERS}    expected_status=${expected_status}
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    [Return]    ${response}

Send GET Request And Verify Body
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_body_value}
    Log To Console    Sending GET request to ${endpoint} and verifying body content.
    ${response}=    GET On Session    q-vision-platform    ${endpoint}    headers=${HEADERS}    expected_status=${expected_status}
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_body_value}
    [Return]    ${response}

Send GET Request And Verify Error Response
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_error_message}
    Log To Console    Sending GET request to ${endpoint} expecting an error response.
    ${response}=    GET On Session    q-vision-platform    ${endpoint}    headers=${HEADERS}    expected_status=any
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_error_message}
    [Return]    ${response}

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Running Test Case: Ingest PASSED Report ---
    Send POST Request To Ingest Report
    ...    /api/v1/quality-reports/ingest
    ...    E-Commerce
    ...    Sprint2
    ...    Login
    ...    ${100}
    ...    ${0}
    ...    ${15.5}
    ...    201
    ...    PASSED
    Log To Console    Test 'Ingest PASSED Report' completed.

Ingest FAILED Report
    Log To Console    --- Running Test Case: Ingest FAILED Report ---
    Send POST Request To Ingest Report
    ...    /api/v1/quality-reports/ingest
    ...    E-Commerce
    ...    Sprint2
    ...    Payment
    ...    ${10}
    ...    ${90}
    ...    ${20.0}
    ...    201
    ...    FAILED
    Log To Console    Test 'Ingest FAILED Report' completed.

Get Project History
    Log To Console    --- Running Test Case: Get Project History ---
    Send GET Request And Verify Body
    ...    /api/v1/quality-reports/E-Commerce
    ...    200
    ...    E-Commerce
    Log To Console    Test 'Get Project History' completed.

Ingest FAILED Report API
    Log To Console    --- Running Test Case: Ingest FAILED Report API ---
    Send POST Request To Ingest Report
    ...    /api/v1/quality-reports/ingest
    ...    E-Commerce
    ...    Sprint2
    ...    Report
    ...    ${60}
    ...    ${40}
    ...    ${25.0}
    ...    201
    ...    FAILED
    Log To Console    Test 'Ingest FAILED Report API' completed.

Checking Missing API
    Log To Console    --- Running Test Case: Checking Missing API ---
    Send GET Request And Verify Error Response
    ...    /api/v1/quality-reportsss
    ...    404
    ...    Not Found
    Log To Console    Test 'Checking Missing API' completed.