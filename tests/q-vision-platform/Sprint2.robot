***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    https://loops-arm-kim-twins.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    [Documentation]    Creates an HTTP session to the base URL with specified headers.
    Create Session    session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}

***Test Cases***
Ingest PASSED Report
    [Documentation]    Tests the ingestion of a PASSED quality report.
    [Setup]    Create HTTP Session
    Log To Console    Sending POST request to ingest a PASSED quality report.
    &{payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=90
    ...    failed=1
    ...    duration=1
    ${response}=    POST On Session    session    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Contain    ${response.text}    PASSED
    Log To Console    PASSED Report ingested successfully and verified.

Checking Missing API
    [Documentation]    Tests a GET request to a non-existent API endpoint to confirm 404 Not Found.
    [Setup]    Create HTTP Session
    Log To Console    Sending GET request to a non-existent API endpoint to check for 404.
    ${response}=    GET On Session    session    /api/v1/quality-reportsss    headers=${HEADERS}    expected_status=any
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    404
    Should Contain    ${response.text}    Not Found
    Log To Console    Missing API check passed with 404 Not Found.