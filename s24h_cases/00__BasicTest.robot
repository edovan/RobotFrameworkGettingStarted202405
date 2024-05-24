*** Settings ***
Documentation   Prima suite di test: in questa suite verifichiamo il funzionamento di base del framework 

Library   SeleniumLibrary 

Resource  ../s24h_resources/common.resource

Suite teardown   Close all Browsers

*** Variables ***
${logoS24h_loc}   //div[@id='header']//a[contains(@class,'hsole')]

${acceptCookies_loc}   //button[@id='onetrust-accept-btn-handler']
${userLoginIcon_loc}   //div[@id='header']//span[contains(@class, 'icon-user')]

# login modal
${loginModal_loc}      //div[@id='modal-login']
${userNameInput_loc}   id:login-username
${passwordInput_loc}   id:login-password

*** Keywords ***
check logo in home page 
    Wait Until Element Is Visible   ${logoS24h_loc}  error=Ciao andrea

*** Test Cases ***
Site is Reachable  
    [Documentation]  It checks if it is possible to navigate to ${URL}
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    # Check login form Is Present 
    check logo in home page 

Check redirect from http to https
    [Documentation]  It checks if it is possible to navigate to ${URL}
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    # Check login form Is Present 
    check logo in home page 

Accept cookies 
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    # Check login form Is Present 
    check logo in home page 
    Wait until element is Visible   ${acceptCookies_loc} 
    Click element   ${acceptCookies_loc} 
    Wait until element is not Visible   ${acceptCookies_loc} 

Perform login 
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    # Check login form Is Present 
    check logo in home page 
    Wait until element is Visible   ${acceptCookies_loc} 
    Click element   ${acceptCookies_loc} 
    Wait until element is not Visible   ${acceptCookies_loc} 
    Wait until element is Visible   ${userLoginIcon_loc}
    Click element  ${userLoginIcon_loc}
    Wait until element is Visible   ${loginModal_loc}  
    Wait until element is Visible   ${userNameInput_loc} 
    Input text   ${userNameInput_loc}   mario.rossi@example.com
    Wait until element is Visible   ${passwordInput_loc} 
    Input password   ${passwordInput_loc}  mario.rossi@example.com
    Capture Element Screenshot  ${loginModal_loc}
    Capture Element Screenshot  ${loginModal_loc}//div[@class='modal-content']
    Capture Page Screenshot 


# This should be failed
#     [Documentation]  It checks if it is possible to navigate to ${URL}
#     Open Browser and go to Home page 
#     Location Should Be  https://www.libero.it
