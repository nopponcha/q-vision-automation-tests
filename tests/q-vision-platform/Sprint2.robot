***Settings***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary

***Variables***
${BASE_URL}    http://localhost:3000
&{HEADERS}     Content-Type=application/json

***Test Cases***
Ingest PASSED Report
    Create Session    api_session    ${BASE_URL}
    ${payload_dict}=    Evaluate    json.loads('''{"projectName": "E-Commerce", "sprintName": "Sprint2", "featureName": "Login", "passed": 100, "failed": 0, "duration": 15}''')    json
    ${response}=    POST On Session    api_session    /api/v1/quality-reports/ingest    json=${payload_dict}    headers=${HEADERS}
    Log To Console    Response Status: ${response.status_code}
    Log To Console    Response Body: ${response.text}
    Status Code Should Be Equal    ${response}    201
    ${json_response}=    Convert String To Json    ${response.text}
    ${actual_status}=    Get Json Value    ${json_response}    $.status
    Should Be Equal    ${actual_status}    PASSED
