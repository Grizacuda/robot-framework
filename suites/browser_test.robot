*** Settings ***
Library         SeleniumLibrary
Force Tags      Test

*** Variables ***
${BROWSER}		%{BROWSER}



*** Test Cases ***
Check that data can be found on Google
    Given the user is on "https://www.google.com"
    When the user searches for “Tesla”
    And there are results for “Top stories”
    Then the user can see “Existing Inventory”


Check that data can be found on Bing
    Given the user is on "https://www.bing.com"
    When the user searches for “Tesla”
    And there are results for “Top stories”
    Then the user can see “Cybertruck”


*** Keywords ***
the user is on "${url}"
    Open Browser    ${url}  ${BROWSER}

the user searches for “${query}”
    Input Text  name:q  ${query}
    Press Keys  name:q  ENTER

there are results for “${term}”
    Wait Until Page Contains  ${term}     timeout=15

the user can see “${result}”
    Page Should Contain Element     //*[text()='${result}']