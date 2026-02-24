***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session
Test Setup    Log New Test Case
Test Teardown    Log Test Case Status

***Variables***
${BASE_URL}        https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}         Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Setting up HTTP session for ${BASE_URL}
    Create Session    mysession    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP Session 'mysession' created successfully.

Log New Test Case
    Log To Console    ----------------------------------------------------------------------
    Log To Console    Starting Test Case: ${TEST NAME}

Log Test Case Status
    Log To Console    Finished Test Case: ${TEST NAME} with status ${TEST STATUS}
    Log To Console    ----------------------------------------------------------------------

Post Quality Report And Verify
    [Arguments]    ${endpoint}    ${project_name}    ${sprint_name}    ${feature_name}
    ...    ${passed_count}    ${failed_count}    ${duration_val}    ${expected_status_code}
    ...    ${expected_result_value}

    Log To Console    Preparing payload for project: ${project_name}, sprint: ${sprint_name}
    ${payload}=    Create Dictionary
    ...    projectName=${project_name}
    ...    sprintName=${sprint_name}
    ...    featureName=${feature_name}
    ...    passed=${passed_count}
    ...    failed=${failed_count}
    ...    duration=${duration_val}

    Log To Console    Sending POST request to ${endpoint} with payload: ${payload}
    ${response}=    POST On Session    mysession    ${endpoint}    json=${payload}
    Log To Console    Received response: ${response.text}
    Log To Console    Expected status code: ${expected_status_code}, Actual status code: ${response.status_code}

    Status Should Be    ${expected_status_code}    ${response}
    Log To Console    Response status code ${response.status_code} matches expected ${expected_status_code}.

    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Response body contains expected value: ${expected_result_value}.

***Test Cases***
Ingest PASSED Report
    Log To Console    Test step: Send POST to ingest a PASSED report and verify 201 status and PASSED result.
    Post Quality Report And Verify
    ...    /api/v1/quality-reports/ingest
    ...    E-Commerce
    ...    Sprint2
    ...    Login
    ...    100
    ...    0
    ...    10.5
    ...    201
    ...    PASSED
