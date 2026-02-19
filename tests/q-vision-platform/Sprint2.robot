***Settings***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Test Setup    Create HTTP Session for API
Test Teardown    Delete All Sessions

***Variables***
${BASE_URL}             http://localhost:8000    # Update this with your actual API base URL
${SESSION_ALIAS}        q-vision-api
&{HEADERS}              Content-Type=application/json

${PAYLOAD_PASSED}       {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
${PAYLOAD_FAILED}       {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}

***Keywords***
Create HTTP Session for API
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}    verify=False

Perform POST Request and Validate Expected Status and Result
    [Arguments]    ${endpoint}    ${payload}    ${expected_status}    ${expected_result_key_value}
    ${response}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload}    headers=${HEADERS}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}

    ${response_json}=    Set Variable    ${response.json()}
    Log To Console       Response JSON: ${response_json}

    # Parse expected_result_key_value (e.g., "status: PASSED")
    ${expected_key_value_list}=    Split String    ${expected_result_key_value}    :
    ${expected_key}=    Strip String    ${expected_key_value_list}[0]
    ${expected_value}=    Strip String    ${expected_key_value_list}[1]

    Dictionary Should Contain Key    ${response_json}    ${expected_key}
    Should Be Equal As Strings       ${response_json}[${expected_key}]    ${expected_value}

***Test Cases***
Ingest PASSED Report - q-vision-platform Sprint2
    Perform POST Request and Validate Expected Status and Result
    ...    /api/v1/quality-reports/ingest
    ...    ${PAYLOAD_PASSED}
    ...    201
    ...    status: PASSED

Ingest FAILED Report - q-vision-platform Sprint2
    Perform POST Request and Validate Expected Status and Result
    ...    /api/v1/quality-reports/ingest
    ...    ${PAYLOAD_FAILED}
    ...    201
    ...    status: FAILED
