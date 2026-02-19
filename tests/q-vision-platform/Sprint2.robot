*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}          https://7d8a-49-237-45-161.ngrok-free.app
${SESSION_ALIAS}     q-vision-platform_api
# ประกาศ Headers เป็น Global Variable แบบ Dictionary
&{GLOBAL_HEADERS}    Content-Type=application/json

*** Keywords ***
Create API Session
    Log To Console    Setting up API session with base URL: ${BASE_URL}
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}

Send POST Request And Verify Status And JSON
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_key}    ${expected_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    # ใช้ &{GLOBAL_HEADERS} ที่ประกาศไว้ข้างบน
    ${response}=    POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload_dict}    headers=${GLOBAL_HEADERS}
    Log To Console    Response Status Code: ${response.status_code}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${json_response}    ${expected_key}    ${expected_value}

*** Test Cases ***
Ingest PASSED Report
    Create API Session
    ${payload_dict}=    Create Dictionary    projectName=E-Commerce    sprintName=Sprint2    featureName=Login    passed=${100}    failed=${0}    duration=${15.5}
    Send POST Request And Verify Status And JSON    /api/v1/quality-reports/ingest    ${payload_dict}    201    status    PASSED