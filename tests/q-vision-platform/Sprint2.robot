***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${BASE_URL}        https://excluded-largely-motorola-backgrounds.trycloudflare.com
&{HEADERS}         Content-Type=application/json

***Test Cases***
Ingest PASSED Report - Sprint2
    [Documentation]    Test Step: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    [Setup]    Create Session    q_vision_platform_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}

    Log To Console    --- Test Case: Ingest PASSED Report - Sprint2 ---
    Log To Console    1. Preparing payload for POST request.
    &{PAYLOAD}    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=99
    ...    failed=1
    ...    duration=10

    Log To Console    Payload created: ${PAYLOAD}
    Log To Console    2. Sending POST request to ${BASE_URL}/api/v1/quality-reports/ingest
    ${response}    POST On Session    q_vision_platform_session    /api/v1/quality-reports/ingest    json=${PAYLOAD}    headers=${HEADERS}

    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}

    Log To Console    3. Verifying HTTP status code is 201.
    Should Be Equal As Strings    ${response.status_code}    201

    Log To Console    4. Verifying response body contains "PASSED".
    Should Contain    ${response.text}    PASSED
    Log To Console    Test "Ingest PASSED Report - Sprint2" Completed Successfully.
