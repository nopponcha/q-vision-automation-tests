***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    http://localhost:3000

***Test Cases***

Get User Profile Success
    Create Session    mysession    ${BASE_URL}
    ${response}=      GET On Session    mysession    /api/v1/users/123
    Status Should Be    200    ${response}
    # Verify Body contains username as a key in the JSON response
    Dictionary Should Contain Key    ${response.json()}    username

Get User ID Not Found - 111
    Create Session    mysession    ${BASE_URL}
    ${response}=      GET On Session    mysession    /api/v1/users/111
    Status Should Be    404    ${response}
    # Verify message is 'User not found'
    Should Be Equal    ${response.json()}[message]    User not found

Get User ID Not Found - 222
    Create Session    mysession    ${BASE_URL}
    ${response}=      GET On Session    mysession    /api/v1/users/222
    Status Should Be    404    ${response}
    Should Be Equal    ${response.json()}[message]    User not found

Get User ID Not Found - 333
    Create Session    mysession    ${BASE_URL}
    ${response}=      GET On Session    mysession    /api/v1/users/333
    Status Should Be    404    ${response}
    Should Be Equal    ${response.json()}[message]    User not found
