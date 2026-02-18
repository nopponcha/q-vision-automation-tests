***Settings***
Library    RequestsLibrary
Suite Setup    Create User API Session

***Variables***
${BASE_URL}    http://localhost:3000

***Keywords***
Create User API Session
    Create Session    q-vision-api    ${BASE_URL}

***Test Cases***
Get User Profile - Valid ID
    [Tags]    User    Success
    ${response}=    GET On Session    q-vision-api    /api/v1/users/123
    Should Be Equal    ${response.status_code}    ${200}
    Dictionary Should Contain Key    ${response.json()}    username

Get User Profile - ID 1 Not Found
    [Tags]    User    NotFound
    ${response}=    GET On Session    q-vision-api    /api/v1/users/1
    Should Be Equal    ${response.status_code}    ${404}
    Dictionary Should Contain Item    ${response.json()}    message    User not found

Get User Profile - ID 8 Not Found
    [Tags]    User    NotFound
    ${response}=    GET On Session    q-vision-api    /api/v1/users/8
    Should Be Equal    ${response.status_code}    ${404}
    Dictionary Should Contain Item    ${response.json()}    message    User not found

Get User Profile - ID 9 Not Found
    [Tags]    User    NotFound
    ${response}=    GET On Session    q-vision-api    /api/v1/users/9
    Should Be Equal    ${response.status_code}    ${404}
    Dictionary Should Contain Item    ${response.json()}    message    User not found
