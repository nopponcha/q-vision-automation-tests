***Settings***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

***Variables***
${BASE_URL}    http://localhost:3000

***Test Cases***
Get User Profile Success
    Create Session    q_vision_platform_session    ${BASE_URL}
    ${response}=    GET On Session    q_vision_platform_session    /api/v1/users/123
    Should Be Equal As Strings    ${response.status_code}    200
    ${json_body}=    Convert String To Json    ${response.content}
    Should Not Be Empty    ${json_body.username}    msg=Response body should contain 'username'

Get User ID 7 Not Found
    Create Session    q_vision_platform_session    ${BASE_URL}
    ${response}=    GET On Session    q_vision_platform_session    /api/v1/users/7
    Should Be Equal As Strings    ${response.status_code}    404
    ${json_body}=    Convert String To Json    ${response.content}
    Should Be Equal As Strings    ${json_body.message}    User not found

Get User ID 8 Not Found
    Create Session    q_vision_platform_session    ${BASE_URL}
    ${response}=    GET On Session    q_vision_platform_session    /api/v1/users/8
    Should Be Equal As Strings    ${response.status_code}    404
    ${json_body}=    Convert String To Json    ${response.content}
    Should Be Equal As Strings    ${json_body.message}    User not found

Get User ID 9 Not Found
    Create Session    q_vision_platform_session    ${BASE_URL}
    ${response}=    GET On Session    q_vision_platform_session    /api/v1/users/9
    Should Be Equal As Strings    ${response.status_code}    404
    ${json_body}=    Convert String To Json    ${response.content}
    Should Be Equal As Strings    ${json_body.message}    User not found