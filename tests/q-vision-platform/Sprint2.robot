***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}    http://localhost:3000

***Test Cases***
Get User Profile Success
    Create Session    qvision_api    ${BASE_URL}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    GET On Session    qvision_api    /api/v1/users/123    headers=${headers}    expected_status=200
    Status Code Should Be    200    ${resp}
    Dictionary Should Contain Key    ${resp.json()}    username

Get User ID Not Found - ID 11
    Create Session    qvision_api    ${BASE_URL}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    GET On Session    qvision_api    /api/v1/users/11    headers=${headers}    expected_status=404
    Status Code Should Be    404    ${resp}
    Dictionary Should Contain Item    ${resp.json()}    message    User not found

Get User ID Not Found - ID 2000
    Create Session    qvision_api    ${BASE_URL}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    GET On Session    qvision_api    /api/v1/users/2000    headers=${headers}    expected_status=404
    Status Code Should Be    404    ${resp}
    Dictionary Should Contain Item    ${resp.json()}    message    User not found

Get User ID Not Found - ID 3000
    Create Session    qvision_api    ${BASE_URL}
    &{headers}=    Create Dictionary    Content-Type=application/json
    ${resp}=    GET On Session    qvision_api    /api/v1/users/3000    headers=${headers}    expected_status=404
    Status Code Should Be    404    ${resp}
    Dictionary Should Contain Item    ${resp.json()}    message    User not found
