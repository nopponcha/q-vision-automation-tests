***Settings***
Library    RequestsLibrary
Library    Collections
Suite Setup    Create API Session

***Variables***
${BASE_URL}    https://foam-lee-herald-scotia.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Setting up API session to ${BASE_URL}
    Create Session    q-vision-platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session 'q-vision-platform' created.

Ingest Quality Report
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    1. Sending POST request to ${endpoint} with payload:
    Log To Console    ${payload_dict}
    ${response}=    POST On Session    q-vision-platform    ${endpoint}    json=${payload_dict}    expected_status=${expected_status}
    Log To Console    Received response status: ${response.status_code}
    Log To Console    Received response body: ${response.text}

    Log To Console    2. Checking expected status code: ${expected_status}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}

    Log To Console    3. Verifying response contains: ${expected_result_value}
    Should Contain    ${response.text}    ${expected_result_value}

***Test Cases***
Ingest PASSED Report
    Log To Console    Starting Test Case: Ingest PASSED Report
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=2
    ...    failed=1
    ...    duration=1
    Ingest Quality Report
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    PASSED
    Log To Console    Test Case: Ingest PASSED Report completed successfully.
