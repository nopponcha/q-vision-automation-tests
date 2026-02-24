***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create API Session

***Variables***
${BASE_URL}    https://drinking-cloudy-choices-produce.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Setting up API session with base URL: ${BASE_URL}
    Create Session    q-vision-platform_session    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session for 'q-vision-platform' created successfully.

***Test Cases***
TC001 - Ingest PASSED Report for E-Commerce Login Feature
    [Documentation]    Test Step: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    Log To Console    --- Starting Test Case: TC001 - Ingest PASSED Report for E-Commerce Login Feature ---

    Log To Console    Step 1: Creating payload for the ingest report.
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=100
    ...    failed=0
    ...    duration=15.5
    Log To Console    Payload created: ${payload}

    Log To Console    Step 2: Sending POST request to /api/v1/quality-reports/ingest
    ${response}=    POST On Session    q-vision-platform_session    /api/v1/quality-reports/ingest    json=${payload}
    Log To Console    Received response status code: ${response.status_code}
    Log To Console    Received response body: ${response.text}

    Log To Console    Step 3: Verifying expected status code '201'
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Status code '201' verified successfully.

    Log To Console    Step 4: Verifying response body contains expected result 'PASSED'
    Should Contain    ${response.text}    PASSED
    Log To Console    Response body verified to contain 'PASSED'.
    Log To Console    --- Test Case: TC001 - Ingest PASSED Report for E-Commerce Login Feature Completed ---