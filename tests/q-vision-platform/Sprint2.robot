***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    http://localhost:3000

***Test Cases***
Get User Profile Success
    [Documentation]    Verifies that a successful GET request to the user profile endpoint returns status 200 and contains username.
    Create Session    q_vision_api    ${BASE_URL}
    ${resp}=    GET On Session    q_vision_api    /api/v1/users/123
    Should Be Equal As Strings    ${resp.status_code}    200
    ${resp_json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${resp_json}    username

Get User ID Not Found
    [Documentation]    Verifies that a GET request with an invalid user ID returns status 404 and 'User not found' message.
    Create Session    q_vision_api    ${BASE_URL}
    ${resp}=    GET On Session    q_vision_api    /api/v1/users/6666
    Should Be Equal As Strings    ${resp.status_code}    404
    ${resp_json}=    Set Variable    ${resp.json()}
    Dictionary Should Contain Key    ${resp_json}    message
    Should Be Equal As Strings    ${resp_json['message']}    User not found
