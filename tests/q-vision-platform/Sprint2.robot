***Settings***
Library    RequestsLibrary
Library    Collections

Test Setup    Create API Session

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Establishing API session with base URL: ${BASE_URL}
    Create Session    q-vision-platform-session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session created successfully.

Send POST Request And Verify Response
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_text_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    With payload: ${payload}
    ${response}=    POST On Session    q-vision-platform-session    ${endpoint}    json=${payload}    expected_status=${expected_status}
    Log To Console    Received status code: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_text_value}
    Log To Console    Response verified successfully.

Create Ingest Passed Report Payload
    [Arguments]    ${project_name}    ${sprint_name}    ${feature_name}    ${passed_count}    ${failed_count}    ${duration_value}
    ${payload}=    Create Dictionary
    ...    projectName=${project_name}
    ...    sprintName=${sprint_name}
    ...    featureName=${feature_name}
    ...    passed=${passed_count}
    ...    failed=${failed_count}
    ...    duration=${duration_value}
    [Return]    ${payload}

Create Ingest Failed Report Payload
    [Arguments]    ${project_name}    ${sprint_name}    ${feature_name}    ${passed_count}    ${failed_count}    ${duration_value}
    ${payload}=    Create Dictionary
    ...    projectName=${project_name}
    ...    sprintName=${sprint_name}
    ...    featureName=${feature_name}
    ...    passed=${passed_count}
    ...    failed=${failed_count}
    ...    duration=${duration_value}
    [Return]    ${payload}

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting test: Ingest PASSED Report
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    ${payload}=     Create Ingest Passed Report Payload
    ...    E-Commerce
    ...    Sprint2
    ...    Login
    ...    100
    ...    0
    ...    15.5
    ${expected_status}=    Set Variable    201
    ${expected_result_value}=    Set Variable    PASSED
    Send POST Request And Verify Response    ${endpoint}    ${payload}    ${expected_status}    ${expected_result_value}
    Log To Console    Test 'Ingest PASSED Report' finished successfully.

Ingest FAILED Report
    Log To Console    Starting test: Ingest FAILED Report
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    ${payload}=     Create Ingest Failed Report Payload
    ...    E-Commerce
    ...    Sprint2
    ...    Payment
    ...    10
    ...    90
    ...    20.0
    ${expected_status}=    Set Variable    201
    ${expected_result_value}=    Set Variable    FAILED
    Send POST Request And Verify Response    ${endpoint}    ${payload}    ${expected_status}    ${expected_result_value}
    Log To Console    Test 'Ingest FAILED Report' finished successfully.
