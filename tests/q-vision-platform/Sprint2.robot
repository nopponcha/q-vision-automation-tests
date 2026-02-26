***Settings***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create API Session

***Variables***
${BASE_URL}    https://foam-lee-herald-scotia.trycloudflare.com
&{HEADERS}     Content-Type=application/json

***Keywords***
Create API Session
    Log To Console    Establishing API session for ${BASE_URL}
    Create Session    q_vision_platform    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    API session 'q_vision_platform' created successfully.

Perform POST Request And Verify Response
    [Arguments]    ${endpoint}    ${payload_dict}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending POST request to endpoint: ${endpoint}
    Log To Console    Request payload: ${payload_dict}
    ${response}=    POST On Session    q_vision_platform    ${endpoint}    json=${payload_dict}    expected_status=${expected_status}
    Log To Console    Received response with status code: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Status Should Be    ${expected_status}    ${response}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Assertion passed: Response body contains value '${expected_result_value}'.

Perform GET Request And Verify Negative Response
    [Arguments]    ${endpoint}    ${expected_status}    ${expected_result_value}
    Log To Console    Sending GET request to endpoint: ${endpoint}
    ${response}=    GET On Session    q_vision_platform    ${endpoint}    expected_status=any
    Log To Console    Received response with status code: ${response.status_code}
    Log To Console    Response body: ${response.text}
    Status Should Be    ${expected_status}    ${response}
    Should Contain    ${response.text}    ${expected_result_value}
    Log To Console    Assertion passed: Response body contains value '${expected_result_value}'.

***Test Cases***
TC_QVP_S2_001_Ingest_PASSED_Report
    Log To Console    Test Case: Ingest PASSED Report - Verifying successful ingestion of a passed quality report.
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Login
    ...    passed=${100}
    ...    failed=${0}
    ...    duration=${1}
    Perform POST Request And Verify Response
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    PASSED
    Log To Console    Test case TC_QVP_S2_001_Ingest_PASSED_Report finished.

TC_QVP_S2_002_Ingest_FAILED_Report
    Log To Console    Test Case: Ingest FAILED Report - Verifying successful ingestion of a failed quality report.
    ${payload}=    Create Dictionary
    ...    projectName=E-Commerce
    ...    sprintName=Sprint2
    ...    featureName=Payment
    ...    passed=${10}
    ...    failed=${90}
    ...    duration=${20.0}
    Perform POST Request And Verify Response
    ...    /api/v1/quality-reports/ingest
    ...    ${payload}
    ...    201
    ...    FAILED
    Log To Console    Test case TC_QVP_S2_002_Ingest_FAILED_Report finished.

TC_QVP_S2_003_Checking_Missing_API
    Log To Console    Test Case: Checking Missing API - Verifying 404 Not Found for a non-existent endpoint.
    Perform GET Request And Verify Negative Response
    ...    /api/v1/quality-reportsss
    ...    404
    ...    Not Found
    Log To Console    Test case TC_QVP_S2_003_Checking_Missing_API finished.
