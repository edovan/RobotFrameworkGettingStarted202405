*** Settings ***
Documentation   Prima suite di test: in questa suite verifichiamo il funzionamento di base del framework 

Library   SeleniumLibrary 

Resource  common.resource
Resource  common_${ENV}.resource

*** Variables ***
# ${URL}  www.saucedemo.com
${BROWSER}   chrome
${USERNAME}   standard_user
${PASSWORD}   secret_sauce  


${pageSecondaryTitle}  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title']

*** Test Cases ***
Site is Reachable  
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser  https://${URL}  ${BROWSER} 
    Location Should Be  https://${URL}/

Check redirect from http to https
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser  http://${URL}/  ${BROWSER} 
    Location Should Be  https://${URL}/

This should be failed
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser  http://${URL}/  ${BROWSER} 
    Location Should Be  https://www.libero.it

Do a login 
    [Documentation]  it checks that user can log in
    # check precondition (GIVEN)
    Open Browser  https://${URL}  ${BROWSER} 
    Location Should Be  https://${URL}/
    # Perform action - compile login (WHEN) 
    # Input Text  name:user-name  ${USERNAME}
    # Input Password  name:password  ${PASSWORD}
    # #Submit Form  
    # Click Element  id:login-button

    # Insert Username
    # Insert Password 
    Type Username  ${USERNAME}
    Type Password   
    Click login button 

    # check Resutls  (THEN)
    Location Should be  https://${URL}/inventory.html
    # //span[@data-test='title']
    # //div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title' and text()='Products']
    # Page should contain  Products 
    # Page should contain Element  xpath://span[@data-test='title']
    # Page should contain Element  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title' and text()='Products']
    # Element Text Should be  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title']  Products  
    # Element Text Should be  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title']  products   ignore_case=${True}
    
    The page title must be Products
    In the main content page must be shown a containter for elements to be sold
    There must me an list of elemnt to be sold    
    In the item list there must be at least one element 



*** keywords ***
The page title must be Products
    Element Text Should be  ${pageSecondaryTitle}  Products  
    Element Text Should be  ${pageSecondaryTitle}  products   ignore_case=${True}

In the main content page must be shown a containter for elements to be sold
    Page Should Contain Element  id:inventory_container
    Page Should Contain Element  xpath://div[@id='contents_wrapper']//div[@data-test='inventory-container']

There must me an list of elemnt to be sold
    [Documentation]  there must be a list of items 
    Page Should Contain Element  xpath://div[@id='contents_wrapper']//div[@data-test='inventory-container']//div[@data-test='inventory-list']

In the item list there must be at least one element 
    [Documentation]  The item list must contains more than one element 
    ${countDiv}=  Get Element count  xpath://div[@data-test='inventory-item']
    Should Be True	${countDiv} > 1
    [RETURN]  ${countDiv}


Insert Username
    Input Text  name:user-name  ${USERNAME}

Type Username 
    [Arguments]  ${_username}
    Input Text  name:user-name  ${_username}

Insert Password 
    Input Password  name:password  ${PASSWORD}

Type Password 
    [Arguments]  ${_password}=${PASSWORD}
    Input Password  name:password  ${_password}


Click login button 
    #Submit Form  
    Click Element  id:login-button