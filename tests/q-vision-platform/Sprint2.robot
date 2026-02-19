***Settings***
Library    RequestsLibrary
Library    Collections
Library    String
Library    JSONLibrary
Test Setup    Create HTTP Session
Test Teardown    Delete All Sessions

***Variables***
${BASE_URL}    https://d3a0-49-237-45-161.ngrok-free.app
&{HEADERS}    Content-Type=application/json

***Keywords***
Create HTTP Session
    Create Session    api_session    ${BASE_URL}    verify=False
    RETURN

***Test Cases***
Ingest PASSED Report
    ${payload_dict}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=100
    ...    failed=0
    ...    duration=15.5
    ${response}=    POST    api_session    /api/v1/quality-reports/ingest    json=${payload_dict}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: PASSED
    RETURN

Ingest FAILED Report
    ${payload_dict}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=50
    ...    failed=2
    ...    duration=10.0
    ${response}=    POST    api_session    /api/v1/quality-reports/ingest    json=${payload_dict}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    201
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    status: FAILED
    RETURN

Get Project History
    ${response}=    GET    api_session    /api/v1/quality-reports/E-Commerce    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    200
    ${body}=    Convert To String    ${response.json()}
    Should Contain    ${body}    projectName: E-Commerce
    RETURN

