*** Settings ***
Library     Collections
Library     RequestsLibrary
Force Tags  GitHub

*** Variables ***
${baseUri}         https://api.github.com  
${requestUri}      /user
${VALID_USER}      %{USERNAME}
${ACCESS_TOKEN}    %{ACCESS_TOKEN}

# Create a dictionary and add key value pair
&{headers}
...  User-Agent=Robot-Testing

*** Test Cases ***
Access an api request as unauthorised user
    Given user's name "Griz"
    When fetching the profile via the GitHub api
    Then request is forbidden

Access an api request as authorised user
    [Tags]  robot:skip-on-failure
    Given user's name "${VALID_USER}"
    And user is authorized
    When fetching the profile via the GitHub api
    Then the user profile is retrieved


*** Keywords ***
user's name "${name}"
    Set Suite Variable     ${expected_name}    ${name} 

fetching the profile via the GitHub api
    Create Session      github    ${baseUri}    headers=${headers}    verify=true
    ${resp}=            GET On Session    github    ${requestUri}    expected_status=any
    Set Suite Variable  ${github_response}     ${resp} 

request is forbidden
    Status Should Be    401
    Dictionary Should Contain Value    ${github_response.json()}    Requires authentication

user is authorized
    Set To Dictionary    ${headers}    Authorization    bearer ${ACCESS_TOKEN} 
    
the user profile is retrieved
    Request Should Be Successful
    Log    ${github_response.json()}    level=DEBUG
    Dictionary Should Contain Value    ${github_response.json()}    ${expected_name}

