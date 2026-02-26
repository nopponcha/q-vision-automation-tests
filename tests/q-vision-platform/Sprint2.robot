***Settings***
Library    RequestsLibrary
Library    Collections
Test Setup    Create API Session

***Variables***
${BASE_URL}    https://foam-lee-herald-scotia.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Initializing API session for q-vision-platform...
    Create Session    q-vision-platform-sprint2    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session 'q-vision-platform-sprint2' created successfully.

***Test Cases***
Ingest PASSED Report
    Log To Console    Test Case: Ingest PASSED Report
    Log To Console    Executing step: 1. Send POST to ingest 2. Check 201 3. Status is PASSED
    ${payload} =    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${99}
    ...    failed=${1}
    ...    duration=${1}
    Log To Console    Prepared payload: ${payload}
    ${endpoint} =    Set Variable    /api/v1/quality-reports/ingest
    Log To Console    Sending POST request to ${BASE_URL}${endpoint}
    ${response} =    POST On Session    q-vision-platform-sprint2    ${endpoint}    json=${payload}    expected_status=201
    Log To Console    Response Status Code: ${response.status_code}
    Log To Console    Response Text: ${response.text}
    Status Should Be    201    ${response}
    Should Contain    ${response.text}    PASSED
    Log To Console    Assertion successful: Report status is PASSED.
