***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://foam-lee-herald-scotia.trycloudflare.com
&{HEADERS}    Content-Type=application/json

***Keywords***
Create HTTP Session
    [Documentation]    Creates a new HTTP session with the base URL and specified headers.
    Create Session    api_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    Session 'api_session' created with URL: ${BASE_URL}
    Log To Console    Using headers: ${HEADERS}

***Test Cases***
Ingest PASSED Report
    [Documentation]    Test case to ingest a quality report with PASSED status.
    Log To Console    Starting Test: Ingest PASSED Report

    Log To Console    Constructing payload for the ingest API.
    &{payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=100
    ...    failed=0
    ...    duration=1

    Log To Console    Sending POST request to /api/v1/quality-reports/ingest
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${payload}

    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}

    Log To Console    Verifying response status code is 201.
    Should Be Equal As Strings    ${response.status_code}    201

    Log To Console    Verifying response body contains 'PASSED'.
    Should Contain    ${response.text}    PASSED

    Log To Console    Test Completed: Ingest PASSED Report