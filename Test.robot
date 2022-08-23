*** Settings ***
Suite Setup       Start Browser    ${url}    ${browser}
Suite Teardown    Close Browser
Test Teardown
Resource          Base.robot    # Reusable Functions
Resource          Configuration.robot    # Configuration Parameters, Utility
Resource          Locators.robot    # WebElement, Locators
Library           SeleniumLibrary    # Selenium Library
Library           Collections
Library           OperatingSystem

*** Test Cases ***
Check Unique Items
    [Tags]    Test1
    [Template]
    #-----Get all Items in an List------------------
    ${allItemList}=    Get Elements in List    ${itemXpath}    @{items}
    #-----Find Unique Items in the Items List-------
    ${uniqueItems}    Remove Duplicates    ${allItemList}
    Log    /n different items are .................
    Log    ${uniqueItems}

Check Item with less than 5 units
    [Tags]    Test2
    #-----Get all Units in an List------------------
    ${allUnitList}=    Get Elements in List    ${unitXpath}    @{units}
    #-----Get all Items in an List------------------
    ${allItemList}=    Get Elements in List    ${itemXpath}    @{items}
    #-----Count elements in Unit List---------------
    ${countUnit} =    Get length    ${allUnitList}
    #-----Check if there are items less than 5 units---------------
    ${unitLessThan}=    Create List
    FOR    ${i}    IN RANGE    ${countUnit}
        ${unit} =    Get From List    ${allUnitList}    ${i}
        IF    ${unit} < 5
        ${item} =    Get From List    ${allItemList}    ${i}
        Append To List    ${unitLessThan}    ${item}
    END
    END
    LOG    /n Items with less than 5 units are.................
    LOG    ${unitLessThan}

Check_pencil with less than 5 units
    [Tags]    Test3
    #-----Get all Items in an List------------------
    ${allItemList}=    Get Elements in List    ${itemXpath}    @{items}
    #-----Get all Units in an List------------------
    ${allUnitList}=    Get Elements in List    ${unitXpath}    @{units}
    #-----Count elements in Item List---------------
    ${countItem} =    Get length    ${allItemList}    #TC03    Pencil
    #-----Check if there is pencil less than 5 units---------------
    ${unitLessThan}=    Create List
    FOR    ${i}    IN RANGE    ${countItem}
        ${unit} =    Get From List    ${allUnitList}    ${i}
        ${item} =    Get From List    ${allItemList}    ${i}
        ${flag}    Set Variable If    ${unit} < 5 and '${item}' == 'Pencil'    1    0
    END
    IF    ${flag} == 1
    LOG    /n There is a Pencil with Less than 5 Units.................
    ELSE
    LOG    /n There is No Pencil with Less than 5 Units.................
    END

Check Expensive Item
    [Tags]    Test4
    [Template]
    #-----Get all Costs in an List------------------
    ${allCostList}=    Get Elements in List    ${costXpath}    @{costs}
    #-----Get all Items in an List------------------
    ${allItemList}=    Get Elements in List    ${itemXpath}    @{items}
    #-----Count elements in Cost List---------------
    ${countCost} =    Get length    ${allCostList}
    #-----Check Expensive Item----------------------
    FOR    ${i}    IN RANGE    ${countCost}
        ${cost} =    Get From List    ${allCostList}    ${i}
        ${item} =    Get From List    ${allItemList}    ${i}
        IF    ${max} < ${cost}
        ${max}    Set Variable    ${cost}
        ${maxItem}    Set Variable    ${item}
        LOG    ${max}
    END
    END
    Log    /n Expensive Item is .................
    Log    ${maxItem}
    Log    ${max}

Download File
    [Tags]    Test5
    #-----Wait Until Table is Visible----------------------
    Run Keyword And Ignore Error    Scroll Element Into View    ${scrollElementLink}
    #-----Download File----------------------
    Click Link    ${downloadLinkXpath}
    Sleep    5s
    LOG    File Downloaded
