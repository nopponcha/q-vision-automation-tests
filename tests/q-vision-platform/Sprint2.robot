***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://9942-49-237-40-185.ngrok-free.app
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Setting up HTTP session...
    Create Session    api_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session created.

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Running Test: Ingest PASSED Report ---
    Log To Console    Test Steps: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    &{PAYLOAD}    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=90
    ...    failed=1
    ...    duration=1
    Log To Console    Sending POST request with payload:
    Log To Console    ${PAYLOAD}
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${PAYLOAD}    headers=${HEADERS}
    Log To Console    Response Status Code: ${{response.status_code}}
    Log To Console    Response Body: ${{response.text}}
    Should Be Equal As Strings    ${{response.status_code}}    201
    Should Contain    ${{response.text}}    PASSED

Ingest FAILED Report
    Log To Console    --- Running Test: Ingest FAILED Report ---
    Log To Console    Test Steps: 1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
    &{PAYLOAD}    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=80
    ...    failed=20
    ...    duration=20.0
    Log To Console    Sending POST request with payload:
    Log To Console    ${PAYLOAD}
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${PAYLOAD}    headers=${HEADERS}
    Log To Console    Response Status Code: ${{response.status_code}}
    Log To Console    Response Body: ${{response.text}}
    Should Be Equal As Strings    ${{response.status_code}}    201
    Should Contain    ${{response.text}}    FAILED

Checking Missing API
    Log To Console    --- Running Test: Checking Missing API ---
    Log To Console    Test Steps: 1. GET by api name 2. Check "error":"Not Found","statusCode":404
    Log To Console    Sending GET request to /api/v1/quality-reportsss (expecting status 404).
    ${response}=    GET On Session    api_session    /api/v1/quality-reportsss    expected_status=any    headers=${HEADERS}
    Log To Console    Response Status Code: ${{response.status_code}}
    Log To Console    Response Body: ${{response.text}}
    Should Be Equal As Strings    ${{response.status_code}}    404
    Should Contain    ${{response.text}}    Not Found
