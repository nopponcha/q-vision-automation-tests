*** Settings ***
Library           RequestsLibrary
Library           Collections
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       https://d3a0-49-237-45-161.ngrok-free.app

*** Test Cases ***
Ingest PASSED Report
    Create Session    mysession    ${BASE_URL}
    &{headers}        Create Dictionary    Content-Type=application/json
    ${payload_body}   Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ${resp}           POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload_body}    headers=${headers}
    Status Should Be    201                 ${resp}
    Should Contain    ${resp.text}        PASSED

Ingest FAILED Report
    Create Session    mysession    ${BASE_URL}
    &{headers}        Create Dictionary    Content-Type=application/json
    ${payload_body}   Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}
    ${resp}           POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload_body}    headers=${headers}
    Status Should Be    201                 ${resp}
    Should Contain    ${resp.text}        FAILED

Get Project History
    Create Session    mysession    ${BASE_URL}
    &{headers}        Create Dictionary    Content-Type=application/json
    ${resp}           GET On Session     mysession    /api/v1/quality-reports/E-Commerce    headers=${headers}
    Status Should Be    200                 ${resp}
    Should Contain    ${resp.text}        E-Commerce