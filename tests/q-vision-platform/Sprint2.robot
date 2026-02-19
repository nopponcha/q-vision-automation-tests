***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}          http://localhost:3000
${SESSION_ALIAS}     q-vision-platform_api

***Keywords***
Create API Session
    Log To Console    Setting up API session with base URL: ${BASE_URL}
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}
    ${headers}=    Create Dictionary    Content-Type=application/json

Send POST Request And Verify Status And JSON
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_key}    ${expected_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Payload: ${payload_dict}
    ${response}=   POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload_dict}    headers=${headers}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${json_response}    ${expected_key}    ${expected_value}
    Log To Console    Verification successful for endpoint: ${endpoint}

***Test Cases***
Ingest PASSED Report
    [Tags]    q-vision-platform    Sprint2    POST    Ingest
    Create API Session
    ${payload_string}=    Set Variable    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15.5}
    ${payload_dict}=    Evaluate    json.loads('''${payload_string}''')    json
    ${expected_status}=    Set Variable    201
    ${endpoint}=    Set Variable    /api/v1/quality-reports/ingest
    ${expected_key}=     Set Variable    status
    ${expected_value}=   Set Variable    PASSED
    Send POST Request And Verify Status And JSON    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_key}    ${expected_value}
