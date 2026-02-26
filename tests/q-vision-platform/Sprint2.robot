***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session
Test Teardown    Delete All Sessions

***Variables***
${BASE_URL}    https://uri-angeles-reserves-rica.trycloudflare.com
&{HEADERS}    Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Creating HTTP session for ${BASE_URL}
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}

Ingest Quality Report
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to ${endpoint} with payload:
    Log To Console    ${payload_dict}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload_dict}
    Log To Console    Received status code: ${response.status_code}
    Log To Console    Received response body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Response body contains expected value: ${expected_result_value}

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting test: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${90}
    ...    failed=${1}
    ...    duration=${1}
    Ingest Quality Report    /api/v1/quality-reports/ingest    ${payload}    201    PASSED
    Log To Console    Test 'Ingest PASSED Report' completed successfully.

Ingest FAILED Report
    Log To Console    Starting test: Ingest FAILED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Ingest Quality Report    /api/v1/quality-reports/ingest    ${payload}    201    FAILED
    Log To Console    Test 'Ingest FAILED Report' completed successfully.
