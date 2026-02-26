***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create HTTP Session

***Variables***
${BASE_URL}    https://foam-lee-herald-scotia.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create HTTP Session
    Log To Console    Initializing HTTP session to Quality Reports API at ${BASE_URL}
    Create Session    q_vision_api    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    Session 'q_vision_api' created successfully with base URL ${BASE_URL}

***Test Cases***
Ingest PASSED Report
    Log To Console    --- Test Case: Ingest PASSED Report ---
    Log To Console    Step 1: Preparing payload for PASSED report ingestion.
    ${PAYLOAD}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${1}
    
    Log To Console    Step 2: Sending POST request to ingest quality report.
    ${response}=    POST On Session    q_vision_api    /api/v1/quality-reports/ingest    json=${PAYLOAD}
    
    Log To Console    Step 3: Verifying the response status code.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Expected status code 201 received.

    Log To Console    Step 4: Verifying the report status in the response.
    Should Contain    ${response.text}    PASSED
    Log To Console    Response indicates 'PASSED' status successfully.
    Log To Console    --- End Test Case: Ingest PASSED Report ---

Ingest FAILED Report
    Log To Console    --- Test Case: Ingest FAILED Report ---
    Log To Console    Step 1: Preparing payload for FAILED report ingestion.
    ${PAYLOAD}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    
    Log To Console    Step 2: Sending POST request to ingest quality report.
    ${response}=    POST On Session    q_vision_api    /api/v1/quality-reports/ingest    json=${PAYLOAD}
    
    Log To Console    Step 3: Verifying the response status code.
    Should Be Equal As Strings    ${response.status_code}    201
    Log To Console    Expected status code 201 received.

    Log To Console    Step 4: Verifying the report status in the response.
    Should Contain    ${response.text}    FAILED
    Log To Console    Response indicates 'FAILED' status successfully.
    Log To Console    --- End Test Case: Ingest FAILED Report ---