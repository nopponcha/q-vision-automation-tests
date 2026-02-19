*** Settings ***
Library           RequestsLibrary
Library           OperatingSystem
Suite Setup       Create Session    mysession    ${BASE_URL}    verify=True
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       https://d3a0-49-237-45-161.ngrok-free.app
&{HEADERS}        Content-Type=application/json

*** Test Cases ***
Ingest PASSED Report
    ${payload}=           Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ${resp}=              POST On Session    mysession    /api/v1/quality-reports/ingest    data=${payload}    headers=${HEADERS}
    Should Be Equal       ${resp.status_code}    201
    Should Contain        ${resp.text}    PASSED

Ingest FAILED Report
    ${payload}=           Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}
    ${resp}=              POST On Session    mysession    /api/v1/quality-reports/ingest    data=${payload}    headers=${HEADERS}
    Should Be Equal       ${resp.status_code}    201
    Should Contain        ${resp.text}    FAILED

Get Project History
    ${resp}=              GET On Session    mysession    /api/v1/quality-reports/E-Commerce
    Should Be Equal       ${resp.status_code}    200
    Should Contain        ${resp.text}    q-vision-platform