*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://d3a0-49-237-45-161.ngrok-free.app
&{HEADERS}    Content-Type=application/json

*** Test Cases ***
Ingest PASSED Report
    Create Session    api_session    ${BASE_URL}    verify=True
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=${100}    failed=${0}    duration=${15.5}
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    Dictionary Should Contain Item    ${response.json()}    status    PASSED

Ingest FAILED Report
    Create Session    api_session    ${BASE_URL}    verify=True
    ${payload}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=${50}    failed=${2}    duration=${10.0}
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    ${response}=    POST On Session    api_session    ${endpoint}    json=${payload}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    Dictionary Should Contain Item    ${response.json()}    status    FAILED
