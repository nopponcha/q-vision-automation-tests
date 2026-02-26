***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create HTTP Session For API Testing

***Variables***
${BASE_URL}    https://loops-arm-kim-twins.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session For API Testing
    Evaluate    urllib3.disable_warnings()    modules=urllib3
    Create Session    q_vision_platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    Session 'q_vision_platform' created with URL: ${BASE_URL}

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Test Case: Ingest PASSED Report ---
    Log To Console    Step 1: Preparing payload for POST request.
    &{payload} =    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=90
    ...    failed=1
    ...    duration=1
    Log To Console    Step 2: Sending POST request to /api/v1/quality-reports/ingest
    ${response}=    POST On Session    q_vision_platform    /api/v1/quality-reports/ingest    json=${payload}
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Log To Console    Step 3: Verifying response status code is 201
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Step 4: Verifying response body contains "PASSED"
    Should Contain    ${response.text}    PASSED
    Log To Console    Test Case 'Ingest PASSED Report' PASSED.

Checking Missing API
    Log To Console    --- Test Case: Checking Missing API ---
    Log To Console    Step 1: Sending GET request to a missing API endpoint /api/v1/quality-reportsss
    ${response}=    GET On Session    q_vision_platform    /api/v1/quality-reportsss    expected_status=any
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Log To Console    Step 2: Verifying response status code is 404
    Should Be Equal As Strings    ${response.status_code}    404
    Log To Console    Step 3: Verifying response body contains "Not Found"
    Should Contain    ${response.text}    Not Found
    Log To Console    Test Case 'Checking Missing API' PASSED.