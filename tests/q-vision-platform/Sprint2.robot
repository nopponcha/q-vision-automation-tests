***Settings***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Suite Setup    Create HTTP Session
Suite Teardown    Delete All Sessions

***Variables***
${BASE_URL}    https://merely-bodies-moments-sand.trycloudflare.com
${HEADERS}     Create Dictionary    Content-Type=application/json

***Keywords***
Create HTTP Session
    Create Session    mysession    ${BASE_URL}    verify=True

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
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${1.0}
    ${resp}=    POST On Session    mysession    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}
    Should Be Equal As Integers    ${resp.status_code}    201
    Should Contain    ${resp.text}    FAILED

Get Project History
    ${resp}=    GET On Session    mysession    /api/v1/quality-reports/E-Commerce
    Should Be Equal As Integers    ${resp.status_code}    200
    Should Contain    ${resp.text}    E-Commerce
