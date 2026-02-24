***Settings***
Library    RequestsLibrary
Library    Collections
Test Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    [Documentation]    Creates an HTTP session with the base URL and specified headers.
    Create Session    mysession    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'mysession' created with base URL: ${BASE_URL}

***Test Cases***
Ingest PASSED Report
    [Documentation]    Test case to ingest a PASSED quality report.
    Log To Console    1. Preparing payload for 'Ingest PASSED Report' POST request.
    &{PAYLOAD}        Create Dictionary
    ...               projectName=E-Commerce
    ...               sprintName=Sprint2
    ...               featureName=Login
    ...               passed=${100}
    ...               failed=${0}
    ...               duration=${15.5}
    Log To Console    2. Sending POST request to /api/v1/quality-reports/ingest.
    ${response}       POST On Session    mysession    /api/v1/quality-reports/ingest    json=${PAYLOAD}
    Log To Console    3. Verifying response status code is 201.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    4. Verifying response body contains 'PASSED' status.
    Should Contain    ${response.text}    PASSED
