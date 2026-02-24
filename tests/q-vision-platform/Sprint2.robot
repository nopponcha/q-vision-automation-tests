*** Settings ***
Library    RequestsLibrary
Library    Collections
# No need for OperatingSystem as 'json' module is available for Evaluate directly.

*** Variables ***
${BASE_URL}    http://localhost:8000
&{HEADERS}     Content-Type=application/json
${API_SESSION_ALIAS}    q-vision-api

*** Keywords ***
Create API Session
    [Documentation]    Creates a new HTTP session for API requests.
    Log To Console    [INFO] Connecting to API Base URL: ${BASE_URL}
    Create Session    ${API_SESSION_ALIAS}    ${BASE_URL}    headers=&{HEADERS}
    Log To Console    [INFO] API Session '${API_SESSION_ALIAS}' created successfully.

Send POST Request
    [Documentation]    Sends a POST request to the given endpoint with a JSON payload.
    [Arguments]    ${endpoint}    ${payload_body}    ${expected_status}
    Log To Console    ----------------------------------------------------------------------
    Log To Console    [INFO] Step: Sending POST request to: ${endpoint}
    Log To Console    [INFO] Payload: ${payload_body}
    ${response}=    Post Request    ${API_SESSION_ALIAS}    ${endpoint}    data=${payload_body}
    Log To Console    [INFO] Response Status: ${response.status_code}
    Log To Console    [INFO] Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    [Return]    ${response}

Send GET Request
    [Documentation]    Sends a GET request to the given endpoint.
    [Arguments]    ${endpoint}    ${expected_status}
    Log To Console    ----------------------------------------------------------------------
    Log To Console    [INFO] Step: Sending GET request to: ${endpoint}
    ${response}=    Get Request    ${API_SESSION_ALIAS}    ${endpoint}
    Log To Console    [INFO] Response Status: ${response.status_code}
    Log To Console    [INFO] Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    [Return]    ${response}

Verify Response Body Contains Key Value
    [Documentation]    Verifies if a specific key-value pair exists in the JSON response body.
    [Arguments]    ${response}    ${expected_key_value_string}
    Log To Console    [INFO] Step: Verifying response body for key-value: '${expected_key_value_string}'
    Log To Console    [DEBUG] Full Response Text: ${response.text}

    Run Keyword If    '${response.text}' == ''    Fail    Response body is empty, cannot verify key-value pair.

    ${parts}=    Split String    ${expected_key_value_string}    :    max_split=1
    ${expected_key}=    Strip String    ${parts}[0]
    ${expected_value}=    Strip String    ${parts}[1]

    ${json_response}=    Get Response Json    ${response}
    Log Dictionary    ${json_response}    INFO    [DEBUG] Parsed JSON Response:

    ${actual_value}=    Get Dictionary Value    ${json_response}    ${expected_key}
    Log To Console    [INFO] Actual value for key "${expected_key}": "${actual_value}"
    Should Be Equal As Strings    ${actual_value}    ${expected_value}

Get Response Json
    [Documentation]    Attempts to parse response text as JSON and returns the dictionary. Fails if not valid JSON.
    [Arguments]    ${response}
    # Using 'json' module via Evaluate for parsing string to dict.
    ${json_dict}=    Evaluate    json.loads('''${response.text}''')    json
    [Return]    ${json_dict}

*** Test Cases ***
Create Session for Q-Vision Platform API
    [Tags]    setup
    Log To Console    [STEP] 1. Creating API session.
    Create API Session
    Log To Console    [INFO] API Session established.

Ingest_PASSED_Report
    [Documentation]    1. Send POST to ingest 2. Check 201 3. Status is PASSED
    [Tags]    q-vision-platform    Sprint2    POST
    ${response}=    Send POST Request    /api/v1/quality-reports/ingest    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}    201
    Verify Response Body Contains Key Value    ${response}    status: PASSED

Ingest_FAILED_Report
    [Documentation]    1. Send POST with failed > 0 2. Check 201 3. Status is FAILED
    [Tags]    q-vision-platform    Sprint2    POST
    ${response}=    Send POST Request    /api/v1/quality-reports/ingest    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 100, "failed": 90, "duration": 10.0}    201
    Verify Response Body Contains Key Value    ${response}    status: FAILED

Get_Project_History
    [Documentation]    1. GET by project name 2. Check 200 3. Body has project name
    [Tags]    q-vision-platform    Sprint2    GET
    ${response}=    Send GET Request    /api/v1/quality-reports/E-Commerce    200
    Verify Response Body Contains Key Value    ${response}    projectName: E-Commerce

Get_Project_History
    [Documentation]    1. GET API 2. Check 404 3. Body has project name
    [Tags]    q-vision-platform    Sprint2    GET
    ${response}=    Send GET Request    /api/v1/quality-reportssss/E-Commerce    404
    Verify Response Body Contains Key Value    ${response}    apiName: quality-reportssss
