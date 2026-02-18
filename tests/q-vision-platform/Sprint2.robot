***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Initialize API Session
Suite Teardown    Close All Sessions

***Variables***
${BASE_URL}    http://localhost:3000
${HEADERS}    ${EMPTY}

***Keywords***
Initialize API Session
    Create Session    mysession    ${BASE_URL}
    ${json_headers}=    Create Dictionary    Content-Type=application/json
    Set Suite Variable    ${HEADERS}    ${json_headers}
    Log    API Session initialized with base URL: ${BASE_URL}

Close All Sessions
    RequestsLibrary.Delete All Sessions

Perform API Request And Validate Response
    [Arguments]    ${method}    ${endpoint}    ${payload_body}    ${expected_status}    ${expected_result_str}
    Log    Running ${method} ${endpoint} with payload: ${payload_body}
    
    ${response}=    Run Keyword If    '${method}' == 'POST'
    ...    POST On Session    mysession    ${endpoint}    data=${payload_body}    headers=${HEADERS}
    ...    ELSE IF    '${method}' == 'GET'
    ...    GET On Session    mysession    ${endpoint}
    ...    ELSE
    ...    Fail    Unsupported HTTP method: ${method}

    Log    Response Status: ${{response.status_code}}
    Log    Response Body: ${{response.text}}

    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Run Keyword If    '${expected_result_str}' != '${EMPTY}'    Validate Expected Result    ${response.text}    ${expected_result_str}

Validate Expected Result
    [Arguments]    ${response_text}    ${expected_result_str}
    ${json_response}=    Convert String To JSON    ${response_text}
    ${key_value_pair}=    Split String    ${expected_result_str}    :    limit=1
    ${key}=    Set Variable    ${key_value_pair}[0]
    ${expected_value}=    Set Variable    ${key_value_pair}[1]

    ${key}=    Strip String    ${key}
    ${expected_value}=    Strip String    ${expected_value}

    ${actual_value_list}=    Get Value From JSON    ${json_response}    $.${key}
    Should Not Be Empty    ${actual_value_list}    msg=Key '${key}' not found in JSON response for expected result '${expected_result_str}'.
    ${actual_value}=    Set Variable    ${actual_value_list}[0]

    Should Be Equal As Strings    ${actual_value}    ${expected_value}    msg=Expected key '${key}' to have value '${expected_value}' but got '${actual_value}'.

***Test Cases***
Ingest_PASSED_Report
    Perform API Request And Validate Response    POST    /api/v1/quality-reports/ingest    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}    201    status: PASSED

Ingest_FAILED_Report
    Perform API Request And Validate Response    POST    /api/v1/quality-reports/ingest    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}    201    status: FAILED

Get_Project_History
    Perform API Request And Validate Response    GET    /api/v1/quality-reports/E-Commerce        200    projectName: E-Commerce

Get_Feature_History
    Perform API Request And Validate Response    GET    /api/v1/quality-reports/E-Commerce/Sprint2/Login/history        200    featureName: Login
