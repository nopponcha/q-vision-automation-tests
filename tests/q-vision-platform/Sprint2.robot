***Settings***
Documentation    Automated API tests for q-vision-platform
Library          RequestsLibrary
Library          Collections
Library          OperatingSystem
Suite Setup      Create Session    mysession    ${BASE_URL}
Suite Teardown   Delete All Sessions

***Variables***
${BASE_URL}      https://d3a0-49-237-45-161.ngrok-free.app
&{HEADERS}       Content-Type=application/json

***Test Cases***
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

Get Project History - Success
    ${resp}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.text}    E-Commerce

Get Project History - Not Found
    ${resp}=    GET On Session    mysession    /api/v1/quality-reports/E-Commercess
    Should Be Equal As Integers    ${resp.status_code}    404
    # Note: As per strict rule, checking for 'E-Commerce' in body even for 404 status.
    # This might lead to a test failure if the API's 404 response body does not contain this string.
    Should Contain    ${resp.text}    E-Commerce