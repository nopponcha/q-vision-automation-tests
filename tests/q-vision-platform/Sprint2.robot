***Settings***
Library     RequestsLibrary
Library     Collections

***Variables***
${BASE_URL}     https://d3a0-49-237-45-161.ngrok-free.app
${HEADERS}      Content-Type=application/json

***Test Cases***
Ingest PASSED Report
    Create Session     q-vision-platform    ${BASE_URL}
    ${payload}=        Create Dictionary
    ...                projectName=E-Commerce
    ...                sprintName=Sprint2
    ...                featureName=Login
    ...                passed=100
    ...                failed=0
    ...                duration=15.5
    ${resp}=           POST                 q-vision-platform    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal    ${resp.status_code}    201
    ${body}=           Convert To String    ${resp.json()}
    Should Contain     ${body}              PASSED

Ingest FAILED Report
    Create Session     q-vision-platform    ${BASE_URL}
    ${payload}=        Create Dictionary
    ...                projectName=E-Commerce
    ...                sprintName=Sprint2
    ...                featureName=Payment
    ...                passed=50
    ...                failed=2
    ...                duration=10.0
    ${resp}=           POST                 q-vision-platform    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal    ${resp.status_code}    201
    ${body}=           Convert To String    ${resp.json()}
    Should Contain     ${body}              FAILED

Get Project History
    Create Session     q-vision-platform    ${BASE_URL}
    ${resp}=           GET                  q-vision-platform    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Should Be Equal    ${resp.status_code}    200
    ${json_body}=      Set Variable         ${resp.json()}
    ${body_string}=    Convert To String    ${json_body}
    Should Contain     ${body_string}       q-vision-platform
