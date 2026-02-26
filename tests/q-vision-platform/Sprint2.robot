***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    https://dressing-engineers-findarticles-cold.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session for Q-Vision Platform
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'q-vision-platform' created with base URL: ${BASE_URL}

***Test Cases***
Ingest PASSED Report
    [Setup]    Create HTTP Session for Q-Vision Platform
    Log To Console    1. Sending POST request to ingest quality report for 'E-Commerce' project in 'Sprint2'.
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${99}
    ...    failed=${1}
    ...    duration=${10}
    Log To Console    Payload prepared: ${payload}
    ${response}=    POST On Session
    ...    q-vision-platform
    ...    /api/v1/quality-reports/ingest
    ...    json=${payload}
    ...    headers=${HEADERS}
    ...    verify=${FALSE}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Log To Console    2. Checking HTTP status code is 201.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    3. Verifying the response body contains 'PASSED' status.
    Should Contain    ${response.text}    PASSED
