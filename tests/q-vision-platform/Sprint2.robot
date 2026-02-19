*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session
Test Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}   https://d3a0-49-237-45-161.ngrok-free.app  # IMPORTANT: Update with your actual API base URL
&{HEADERS}    Content-Type=application/json

*** Test Cases ***
Ingest PASSED Report
    [Tags]    q-vision-platform    Sprint2    POST    Ingest
    Perform API POST Request
    ...    /api/v1/quality-reports/ingest
    ...    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ...    201
    ...    status: PASSED

Ingest FAILED Report
    [Tags]    q-vision-platform    Sprint2    POST    Ingest
    Perform API POST Request
    ...    /api/v1/quality-reports/ingest
    ...    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Payment", "passed": 50, "failed": 2, "duration": 10.0}
    ...    201
    ...    status: FAILED

*** Keywords ***
Create HTTP Session
    Create Session    mysession    ${BASE_URL}

Perform API POST Request
    [Arguments]    ${endpoint}    ${payload_json_string}    ${expected_status}    ${expected_result_check}
    Log    Sending POST request to: ${endpoint}
    Log    Payload JSON String received: ${payload_json_string}

    # The 'Payload_Body' from the test specifications is provided as a JSON string.
    # To use it with 'json=${payload_dict}' in RequestsLibrary, it must be a Python dictionary.
    # As per rules, 'JSONLibrary' is forbidden. 'Create Dictionary' keyword is used to build a dictionary
    # from explicit key-value pairs, it cannot parse a JSON string directly.
    # Therefore, 'Evaluate json.loads' is used here to parse the JSON string into a Python dictionary.
    # This uses Python's standard 'json' module, not the forbidden 'JSONLibrary'.
    &{payload_dict}=    Evaluate    json.loads('''${payload_json_string}''')    modules=json
    Log    Converted Payload Dictionary: ${payload_dict}

    ${response}=    POST On Session    mysession    ${endpoint}    headers=${HEADERS}    json=${payload_dict}
    Log    Response Status Code: ${response.status_code}
    Log    Response Body: ${response.text}

    # Verify Status Code
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}

    # Parse response body as JSON
    &{response_json}=    ${response.json()}
    Log    Parsed Response JSON: ${response_json}

    # Verify expected result (e.g., "status: PASSED")
    @{expected_parts}=    Split String    ${expected_result_check}    : 
    ${expected_key}=    Set Variable    @{expected_parts}[0]
    ${expected_value}=    Set Variable    @{expected_parts}[1]
    ${expected_key}=    Set Variable    ${expected_key.strip()}
    ${expected_value}=    Set Variable    ${expected_value.strip()}

    Dictionary Should Contain Key    ${response_json}    ${expected_key}
    Should Be Equal As Strings    ${response_json.${expected_key}}    ${expected_value}
