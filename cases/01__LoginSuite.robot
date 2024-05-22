*** Settings ***
Documentation   Suite di per la verifica della login 

Library   SeleniumLibrary 

Resource  ../resources/common.resource
Resource  ../resources/common_${ENV}.resource

Resource  ../resources/pageObject/loginPage.resource
Resource  ../resources/pageObject/productsPage.resource

*** Variables ***
${pageSecondaryTitle}  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title']

*** Test Cases ***

Do a Success login 
    [Documentation]  it checks that user can log in
    # check precondition (GIVEN)
    Open Browser  https://${URL}  ${BROWSER} 
    Location Should Be  https://${URL}/
    Check login form Is Present 

    # Perform action - compile login (WHEN) 
    Type Username  ${USERNAME}
    Type Password   
    Click login button 

    # check Resutls  (THEN)
    Location Should be  https://${URL}/inventory.html
    Check login form Is Not Present 
    Check landing on default product list page 
    # The page title must be Products
    # In the main content page must be shown a containter for elements to be sold
    # There must me an list of elemnt to be sold    
    # In the item list there must be at least one element 

Check Login not permitted 
    [Documentation]  it checks that locked out user can not log in
    # check precondition (GIVEN)
    Open Browser  https://${URL}  ${BROWSER} 
    Location Should Be  https://${URL}/
    Check login form Is Present 

    # Perform action - compile login (WHEN) 
    Type Username  ${USERNAME_LOCKED_OUT}
    Type Password  ${PASSSWORD_LOCKED_OUT}
    Click login button 

    # check Resutls  (THEN)
    Location Should be  https://${URL}/
    Check login form Is Present 
    Error message area is visible 
    # ${errorMessage}=  Get Login error message 
    # Should be equal  ${errorMessage}   Epic sadface: Sorry, this user has been locked out.
    Error message displayed should be  Epic sadface: Sorry, this user has been locked out.

*** keywords ***

