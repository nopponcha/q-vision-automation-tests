***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}     https://d3a0-49-237-45-161.ngrok-free.app
&{HEADERS}      Content-Type=application/json

***Keywords***
Setup Test Session
    Create Session    api_session    ${BASE_URL}    verify=False

***Test Cases***
Ingest PASSED Report
    [Tags]    q-vision-platform    Sprint2
    Setup Test Session
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: PASSED

Ingest FAILED Report
    [Tags]    q-vision-platform    Sprint2
    Setup Test Session
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=50    failed=2    duration=10.0
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: FAILED

Get Project History
    [Tags]    q-vision-platform    Sprint2
    Setup Test Session
    ${response}=    GET On Session    api_session    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    q-vision-platform