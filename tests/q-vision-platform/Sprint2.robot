***Settings***
Library    RequestsLibrary
Library    Collections
#Suite Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://uri-angeles-reserves-rica.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    Create Session    q-vision-platform    ${BASE_URL}    verify=${FALSE}    headers=&{HEADERS}

Common Ingest Report
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to ${endpoint} with payload: ${payload}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload}
    Log To Console    Received response status: ${response.status_code} and text: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Assertion passed for status code and response content.

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Starting Test Case: Ingest PASSED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${90}
    ...    failed=${1}
    ...    duration=${1}
    Common Ingest Report    /api/v1/quality-reports/ingest    ${payload}    201    PASSED
    Log To Console    --- Completed Test Case: Ingest PASSED Report ---

Ingest FAILED Report
    Log To Console    --- Starting Test Case: Ingest FAILED Report ---
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Common Ingest Report    /api/v1/quality-reports/ingest    ${payload}    201    FAILED
    Log To Console    --- Completed Test Case: Ingest FAILED Report ---