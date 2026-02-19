*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}    https://d3a0-49-237-45-161.ngrok-free.app

*** Test Cases ***
Ingest PASSED Report
    Create Session    mysession    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ${resp}=    POST On Session    mysession    /api/v1/quality-reports/ingest    headers=${headers}    data=${payload}
    Status Should Be    201    ${resp}
    ${body}=    Convert To String    ${resp.content}
    Should Contain    ${body}    PASSED

Ingest FAILED Report
    Create Session    mysession    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json
    ${payload}=    Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}
    ${resp}=    POST On Session    mysession    /api/v1/quality-reports/ingest    headers=${headers}    data=${payload}
    Status Should Be    201    ${resp}
    ${body}=    Convert To String    ${resp.content}
    Should Contain    ${body}    FAILED

Get Project History
    Create Session    mysession    ${BASE_URL}
    ${resp}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce
    Status Should Be    200    ${resp}
    ${body}=    Convert To String    ${resp.content}
    Should Contain    ${body}    E-Commerce