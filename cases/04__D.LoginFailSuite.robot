*** Settings ***
Documentation   Suite data drive to check the login procedure 

Library   SeleniumLibrary 

Resource  ../resources/common.resource
Resource  ../resources/common_${ENV}.resource

Resource  ../resources/pageObject/loginPage.resource

Test Template   Check login not permitted 

Suite setup     Open Browser and go to Home page 
Test Setup      Check Login Form
# Test Teardown    Logout if test fail
Test Teardown   Close browser if login fail 
Suite Teardown   Close All Browsers

*** Variables ***
${hamburgerMenu_loc}   id:react-burger-menu-btn
${logoutMenuItem_loc}  id:logout_sidebar_link

*** Test Cases ***
##  [Arguments]   ${_userName}  ${_password}
# Login at standard_user               standard_user             secret_sauce
Loging Without User Name             ${EMPTY}                  standard_user     Epic sadface: Username is required
Loging Without User Password         standard_user             ${EMPTY}          Epic sadface: Password is required
Loging Without Data                  ${EMPTY}                  s${EMPTY}         Epic sadface: Username is required
Login at standard_user wrong PWD     standard_user             standard_user     Epic sadface: Username and password do not match any user in this service
Login at admin                       admin                     admin             Epic sadface: Username and password do not match any user in this service
Login at root                        root                      root              Epic sadface: Username and password do not match any user in this service
Login at locked_out_user             locked_out_user           secret_sauce      Epic sadface: Sorry, this user has been locked out.    
Login at problem_user                problem_user              secret_sauce      Epic sadface: Sorry, this user has been locked out.    
Login at locked_out_user 2           locked_out_user           secret_sauce      Epic sadface: Sorry, this user has been locked out.    
Loging Without User Name 2            ${EMPTY}                  standard_user    Pipmpirimmpettenuse 
Loging Without User Password 2        standard_user             ${EMPTY}          Epic sadface: Password is required
Loging Without Data 2                 ${EMPTY}                  s${EMPTY}         Epic sadface: Username is required
# Login at performance_glitch_user     performance_glitch_user   secret_sauce
# Login at error_user                  error_user                secret_sauce
# Login at visual_user                 visual_user               secret_sauce

*** keywords ***
Check login not permitted 
    [Arguments]   ${_userName}  ${_password}  ${_errorMessage}
    Type Username  ${_userName}  
    Type Password   ${_password}
    Click login button 

    # check Resutls  (THEN)
    Location Should be  https://${URL}/
    Check login form Is Present 
    Error message area is visible 
    Error message displayed should be  ${_errorMessage}


Check Login Form
    [Documentation]  It opens the browser, go to home page and check the login form
    # check precondition (GIVEN)
    # Open Browser and go to Home page 
    Reload Page
    Location Should Be  https://${URL}/
    Check login form Is Present 


Logout 
    Wait Until Element Is Visible   ${hamburgerMenu_loc} 
    Click Element   ${hamburgerMenu_loc} 
    Wait Until Element Is Visible   ${logoutMenuItem_loc} 
    Click Element   ${logoutMenuItem_loc} 


Logout if test fail
    Run Keyword If Test Failed   Logout 

Close browser if login fail 
    Run Keyword If Test Failed  Close browser 
    Run Keyword If Test Failed  Open Browser and go to Home page 