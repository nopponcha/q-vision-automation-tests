*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem

Suite Setup    Create Test Session
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}    https://d3a0-49-237-45-161.ngrok-free.app
${HEADERS}    Content-Type=application/json

*** Keywords ***
Create Test Session
    Create Session    api_session    ${BASE_URL}    verify=True

*** Test Cases ***
Ingest_PASSED_Report
    Log To Console    Running test: Ingest PASSED Report
    &{PAYLOAD_Ingest_PASSED_Report}    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=100    failed=0    duration=15.5
    ${response} =    POST On Session    api_session    /api/v1/quality-reports/ingest    json=&{PAYLOAD_Ingest_PASSED_Report}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: PASSED

Ingest_FAILED_Report
    Log To Console    Running test: Ingest FAILED Report
    &{PAYLOAD_Ingest_FAILED_Report}    projectName=E-Commerce    sprintName=Sprint2    featureName=Payment    passed=50    failed=2    duration=10.0
    ${response} =    POST On Session    api_session    /api/v1/quality-reports/ingest    json=&{PAYLOAD_Ingest_FAILED_Report}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: FAILED

Get_Project_History
    Log To Console    Running test: Get Project History
    ${response} =    GET On Session    api_session    /api/v1/quality-reports/E-Commerce
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    projectName: E-Commerce
