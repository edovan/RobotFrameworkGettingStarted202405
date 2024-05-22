*** Settings ***
Documentation   Suite data drive to check the login procedure 

Library   SeleniumLibrary 

Resource  ../resources/common.resource
Resource  ../resources/common_${ENV}.resource

Resource  ../resources/pageObject/loginPage.resource
Resource  ../resources/pageObject/productsPage.resource

Test Template   Check login 

Suite setup     Open Browser and go to Home page 
Test Setup      Check Login Form
Test Teardown   Logout 
Suite Teardown   Close All Browsers

*** Variables ***
${hamburgerMenu_loc}   id:react-burger-menu-btn
${logoutMenuItem_loc}  id:logout_sidebar_link

*** Test Cases ***
##  [Arguments]   ${_userName}  ${_password}
Login at standard_user               standard_user             secret_sauce
# Login at locked_out_user             locked_out_user           secret_sauce
Login at problem_user                problem_user              secret_sauce
Login at performance_glitch_user     performance_glitch_user   secret_sauce
Login at error_user                  error_user                secret_sauce
Login at visual_user                 visual_user               secret_sauce

*** keywords ***
Check login 
    [Arguments]   ${_userName}  ${_password}
    Type Username  ${_userName}  
    Type Password   ${_password}
    Click login button 

    # check Resutls  (THEN)
    Location Should be  https://${URL}/inventory.html
    Check login form Is Not Present 
    Check landing on default product list page 


Check Login Form
    [Documentation]  It opens the browser, go to home page and check the login form
    # check precondition (GIVEN)
    # Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    Check login form Is Present 


Logout 
    Wait Until Element Is Visible   ${hamburgerMenu_loc} 
    Click Element   ${hamburgerMenu_loc} 
    Wait Until Element Is Visible   ${logoutMenuItem_loc} 
    Click Element   ${logoutMenuItem_loc} 