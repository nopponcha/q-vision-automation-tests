***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Initialize API Session

***Variables***
${BASE_URL}     https://loops-arm-kim-twins.trycloudflare.com
&{HEADERS}      Content-Type=application/json

***Keywords***
Initialize API Session
    Log To Console    Setting up API session...
    Evaluate  urllib3.disable_warnings()  modules=urllib3
    Create Session    q-vision-platform-session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session initialized successfully.

Verify Response Status And Content
    [Arguments]    ${response}    ${expected_status}    ${expected_content}
    Log To Console    Verifying response status code: ${response.status_code}
    Log To Console    Verifying response body for content: ${expected_content}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Contain    ${response.text}    ${expected_content}
    Log To Console    Response status and content verified.

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Test Case: Ingest PASSED Report ---
    Log To Console    Step 1: Creating payload for POST request.
    ${payload} =    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${1}
    Log To Console    Payload created: ${payload}
    Log To Console    Step 2: Sending POST request to ingest data.
    ${response} =    POST On Session    q-vision-platform-session    /api/v1/quality-reports/ingest    json=${payload}
    Log To Console    Step 3: Checking for 201 status and 'PASSED' in response body.
    Verify Response Status And Content    ${response}    201    PASSED
    Log To Console    Ingest PASSED Report test completed.

Checking Missing API
    Log To Console    --- Test Case: Checking Missing API ---
    Log To Console    Step 1: Sending GET request to a non-existent API endpoint.
    ${response} =    GET On Session    q-vision-platform-session    /api/v1/quality-reportsss    expected_status=any
    Log To Console    Step 2: Checking for 404 status and 'Not Found' in response body.
    Verify Response Status And Content    ${response}    404    Not Found
    Log To Console    Checking Missing API test completed.
