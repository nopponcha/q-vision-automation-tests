***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    http://localhost:3000
${API_VERSION}    v1

***Test Cases***
Get User Profile Success
    [Documentation]    Verifies that a valid user profile can be retrieved successfully.
    [Tags]             API    Users    GET    Success
    Create Session     q-vision-session    ${BASE_URL}
    ${response}=       GET On Session    q-vision-session    /api/${API_VERSION}/users/123
    Should Be Equal    ${response.status_code}    ${200}
    Dictionary Should Contain Key    ${response.json()}    username
    Log To Console     User Profile for ID 123: ${response.json()}

Get User ID Not Found
    [Documentation]    Verifies that an attempt to retrieve a non-existent user results in a 404 error.
    [Tags]             API    Users    GET    NotFound    Error
    Create Session     q-vision-session    ${BASE_URL}
    ${response}=       GET On Session    q-vision-session    /api/${API_VERSION}/users/9999
    Should Be Equal    ${response.status_code}    ${404}
    ${error_message}=  Get From Dictionary    ${response.json()}    message
    Should Be Equal    ${error_message}    User not found
    Log To Console     Error response for non-existent ID 9999: ${response.json()}