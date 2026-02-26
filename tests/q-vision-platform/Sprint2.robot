*** Settings ***
Library    RequestsLibrary
Library    Collections

Suite Setup    Create HTTP Session

*** Variables ***
${BASE_URL}    https://loops-arm-kim-twins.trycloudflare.com
&{HEADERS}    Content-Type=application/json

*** Keywords ***
Create HTTP Session
    Log To Console    Creating HTTP session with Base URL: ${BASE_URL}
    Create Session    my_alias    ${BASE_URL}    headers=${HEADERS}    verify=${FALSE}
    Log To Console    HTTP session 'my_alias' created successfully.

Get Expected Value For Assertion
    [Documentation]    Extracts a clean expected value from a result string for assertion.
    [Arguments]    ${expected_result_string}
    ${clean_value}=    Set Variable    ${EMPTY}
    ${status_prefix}=    Set Variable    status: 
    ${body_contains_prefix}=    Set Variable    Body contains "

    IF    "${expected_result_string}" == "${EMPTY}"
        Log To Console    No expected result string provided for assertion.
        Return    ${EMPTY}
    ELSE IF    "${expected_result_string}" contains "${status_prefix}"
        ${clean_value}=    Get Substring    ${expected_result_string}    ${LENGTH(${status_prefix})}
    ELSE IF    "${expected_result_string}" contains "${body_contains_prefix}"
        ${start_index}=    Find    ${expected_result_string}    "    ${LENGTH(${body_contains_prefix})}
        ${end_index}=      Find    ${expected_result_string}    "    ${start_index + 1}
        ${clean_value}=    Get Substring    ${expected_result_string}    ${start_index+1}    ${end_index}
    ELSE
        Log To Console    WARNING: Unrecognized Expected_Result pattern: "${expected_result_string}". Attempting to use as-is, but this may violate assertion rules (e.g., presence of ':' or '"').
        ${clean_value}=    Set Variable    ${expected_result_string}
    END
    Log To Console    Extracted clean expected value for assertion: "${clean_value}"
    RETURN    ${clean_value}

Create Payload Dictionary From String
    [Documentation]    Converts a JSON string into a Robot Framework dictionary using Create Dictionary.
    [Arguments]    ${json_string_payload}
    Log To Console    Parsing JSON string payload: ${json_string_payload}
    ${temp_dict}=    Evaluate    json.loads('''${json_string_payload}''')    modules=json
    &{final_payload}=    Create Dictionary
    FOR    ${key}    ${value}    IN DICTIONARY    ${temp_dict}
        Set To Dictionary    ${final_payload}    ${key}=${value}
    END
    Log To Console    Created payload dictionary: ${final_payload}
    RETURN    ${final_payload}

*** Test Cases ***
Ingest PASSED Report
    [Tags]    q-vision-platform    Sprint2    POST    Success
    Log To Console    Test Step: 1. Send POST request to ingest a quality report with PASSED status.
    ${payload}=    Create Payload Dictionary From String    {"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 90, "failed": 1, "duration": 1}
    ${response}=    POST On Session    my_alias    /api/v1/quality-reports/ingest    json=${payload}    headers=${HEADERS}

    Log To Console    Test Step: 2. Check if the response status code is 201 Created.
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    201

    Log To Console    Test Step: 3. Verify that the ingested report's status in the response body is PASSED.
    ${expected_assert_value}=    Get Expected Value For Assertion    status: PASSED
    Should Contain    ${response.text}    ${expected_assert_value}

Checking Missing API
    [Tags]    q-vision-platform    Sprint2    GET    Negative
    Log To Console    Test Step: 1. Send GET request to a non-existent API endpoint to trigger a 404 Not Found error.
    ${response}=    GET On Session    my_alias    /api/v1/quality-reportsss    headers=${HEADERS}    expected_status=any

    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Should Be Equal As Strings    ${response.status_code}    404

    Log To Console    Test Step: 2. Verify that the response body contains the "Not Found" error message.
    ${expected_assert_value}=    Get Expected Value For Assertion    404, Body contains "Not Found"
    Should Contain    ${response.text}    ${expected_assert_value}