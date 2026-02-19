*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}          https://4ada-49-237-23-111.ngrok-free.app
${SESSION_ALIAS}     q-vision-platform_api
# สร้าง headers ไว้ตรงนี้เพื่อให้เรียกใช้ได้จากทุกที่
&{HEADERS}           Content-Type=application/json

*** Keywords ***
Create API Session
    Log To Console    Setting up API session with base URL: ${BASE_URL}
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}

Send POST Request And Verify Status And JSON
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_key}    ${expected_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Payload: ${payload_dict}
    # เรียกใช้ &{HEADERS} ที่ประกาศไว้ข้างบน
    ${response}=   POST On Session    ${SESSION_ALIAS}    ${endpoint}    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${json_response}    ${expected_key}    ${expected_value}