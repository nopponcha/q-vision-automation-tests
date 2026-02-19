*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Suite Setup    Create Session    mysession    https://d3a0-49-237-45-161.ngrok-free.app
Suite Teardown    Delete All Sessions

*** Variables ***
&{HEADERS}    Content-Type=application/json

*** Test Cases ***
Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${15.5}
    ${resp}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal As Integers    ${resp.status_code}    201
    Should Contain    ${resp.text}    PASSED

Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${100}
    ...    failed=${5}
    ...    duration=${10.0}
    ${resp}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal As Integers    ${resp.status_code}    201
    Should Contain    ${resp.text}    FAILED

Get Project History
    ${resp}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.text}    E-Commerce
