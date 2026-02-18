***Settings***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

***Variables***
${BASE_URL}    http://localhost:3000
${SESSION_ALIAS}    qvision_api

***Keywords***
Create API Session
    Create Session    ${SESSION_ALIAS}    ${BASE_URL}    verify=False    timeout=30

Get User Profile By ID
    [Arguments]    ${user_id}
    ${endpoint}=    Set Variable    /api/v1/users/${user_id}
    ${response}=    GET On Session    ${SESSION_ALIAS}    ${endpoint}
    [Return]    ${response}

Verify User Profile Success Response
    [Arguments]    ${response}
    Status Code Should Be    200    ${response}
    ${json_body}=    Get Json From Response    ${response}
    JSON Should Contain Key    ${json_body}    username

Verify User Not Found Response
    [Arguments]    ${response}
    Status Code Should Be    404    ${response}
    ${json_body}=    Get Json From Response    ${response}
    Dictionary Should Contain Item    ${json_body}    message    User not found

***Test Cases***
Get User Profile Success - b3ddff19
    [Documentation]    Test Case ID: b3ddff19-a847-4adc-b060-fb9b2253f520
    Create API Session
    ${response}=    Get User Profile By ID    123
    Verify User Profile Success Response    ${response}

Get User ID Not Found - 15993705
    [Documentation]    Test Case ID: 15993705-291c-4096-8d01-e03c68cf4619
    Create API Session
    ${response}=    Get User Profile By ID    11
    Verify User Not Found Response    ${response}

Get User ID Not Found - 660a14cd
    [Documentation]    Test Case ID: 660a14cd-ad53-4dc9-bd29-6d7087be461c
    Create API Session
    ${response}=    Get User Profile By ID    22
    Verify User Not Found Response    ${response}

Get User ID Not Found - 8c8048ad
    [Documentation]    Test Case ID: 8c8048ad-d2e7-4f60-9659-0c7ae4cf2c12
    Create API Session
    ${response}=    Get User Profile By ID    33
    Verify User Not Found Response    ${response}

Get User Profile Success - 8d7c4c95
    [Documentation]    Test Case ID: 8d7c4c95-9172-41e9-a861-00c5fb1a4a89
    Create API Session
    ${response}=    Get User Profile By ID    123
    Verify User Profile Success Response    ${response}
