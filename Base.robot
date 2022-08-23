*** Settings ***
Library           SeleniumLibrary    # Selenium Library
Library           Collections

*** Keywords ***
Start Browser
    [Arguments]    ${webUrl}    ${webBrowser}
    Open browser    ${webUrl}    ${webBrowser}
    Maximize Browser Window
    Sleep    10s
    Select Frame    //iframe[@id='gdpr-consent-notice']
    LOG    Inside the frame
    Click Element    xpath://*[@id="save"]/span[1]/div

Get Elements in List
    [Arguments]    ${elementXpath}    @{elementArray}
    @{itemList}=    Get WebElements    ${elementXpath}
    ${elementArray}=    Create List
    FOR    ${element}    IN    @{itemList}
        ${text}=    Get Text    ${element}
        Append To List    ${elementArray}    ${text}
    END
    ${uniqueList}=    Remove From List    ${elementArray}    0
    [Return]    ${elementArray}
