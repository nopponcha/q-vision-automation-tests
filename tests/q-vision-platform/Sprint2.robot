*** Settings ***
Library    RequestsLibrary
Library    Collections

Test Setup    Create API Session
Test Teardown    Close All Sessions

*** Variables ***
${BASE_URL}    https://f189-49-237-45-161.ngrok-free.app
&{HEADERS}    Content-Type=application/json

*** Test Cases ***
Ingest PASSED Report
    Log To Console    --- Starting Test: Ingest PASSED Report ---
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    ${endpoint}=    /api/v1/quality-reports/ingest
    ${expected_status_code}=    201
    ${expected_report_status}=    PASSED

    Log To Console    Step 1: Sending POST request to ingest a PASSED report.
    ${response}=    Send Ingest Report Request    ${endpoint}    ${payload}    ${expected_status_code}

    Log To Console    Step 2: Verifying response status code.
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}

    Log To Console    Step 3: Verifying report status in response body.
    ${response_json}=    To Json    ${response.content}
    Verify Report Status    ${response_json}    ${expected_report_status}
    Log To Console    --- Test Finished: Ingest PASSED Report ---

Ingest FAILED Report
    Log To Console    --- Starting Test: Ingest FAILED Report ---
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=50    failed=2    duration=10.0
    ${endpoint}=    /api/v1/quality-reports/ingest
    ${expected_status_code}=    201
    ${expected_report_status}=    FAILED

    Log To Console    Step 1: Sending POST request to ingest a FAILED report.
    ${response}=    Send Ingest Report Request    ${endpoint}    ${payload}    ${expected_status_code}

    Log To Console    Step 2: Verifying response status code.
    Should Be Equal As Strings    ${response.status_code}    ${expected_status_code}

    Log To Console    Step 3: Verifying report status in response body.
    ${response_json}=    To Json    ${response.content}
    Verify Report Status    ${response_json}    ${expected_report_status}
    Log To Console    --- Test Finished: Ingest FAILED Report ---

*** Keywords ***
Create API Session
    Log To Console    Creating API session with base URL: ${BASE_URL}
    Create Session    api_session    ${BASE_URL}    disable_warnings=True

Send Ingest Report Request
    [Arguments]    ${endpoint}    ${payload}    ${expected_status_code}
    Log To Console    Sending POST request to ${endpoint}
    Log To Console    Payload: ${payload}
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload}    headers=${HEADERS}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response body: ${response.content}
    [Return]    ${response}

Verify Report Status
    [Arguments]    ${response_json}    ${expected_status_text}
    ${actual_status}=    Get From Dictionary    ${response_json}    status
    Log To Console    Expected report status: ${expected_status_text}, Actual report status: ${actual_status}
    Should Be Equal As Strings    ${actual_status}    ${expected_status_text}
