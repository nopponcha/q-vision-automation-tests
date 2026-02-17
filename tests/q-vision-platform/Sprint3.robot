***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    http://localhost:3000

***Test Cases***
Get User Profile Success
    [Tags]    UserManagement    Success
    Create Session    mysession    ${BASE_URL}
    ${resp}=    GET On Session    mysession    /api/v1/users/123
    Status Should Be    200    ${resp}
    ${json_body}=    Convert To Json    ${resp.content}
    Dictionary Should Contain Key    ${json_body}    username
    # Further verification could be added here, e.g., value of username

Get User ID Not Found - ID 6666
    [Tags]    UserManagement    NotFound    Error
    Create Session    mysession    ${BASE_URL}
    ${resp}=    GET On Session    mysession    /api/v1/users/6666
    Status Should Be    404    ${resp}
    ${json_body}=    Convert To Json    ${resp.content}
    Dictionary Should Contain Item    ${json_body}    message=User not found

Get User ID Not Found - ID 7777
    [Tags]    UserManagement    NotFound    Error
    Create Session    mysession    ${BASE_URL}
    ${resp}=    GET On Session    mysession    /api/v1/users/7777
    Status Should Be    404    ${resp}
    ${json_body}=    Convert To Json    ${resp.content}
    Dictionary Should Contain Item    ${json_body}    message=User not found

Get User ID Not Found - ID 8888
    [Tags]    UserManagement    NotFound    Error
    Create Session    mysession    ${BASE_URL}
    ${resp}=    GET On Session    mysession    /api/v1/users/8888
    Status Should Be    404    ${resp}
    ${json_body}=    Convert To Json    ${resp.content}
    Dictionary Should Contain Item    ${json_body}    message=User not found