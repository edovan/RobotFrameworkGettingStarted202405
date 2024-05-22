*** Settings ***
Documentation   Prima suite di test: in questa suite verifichiamo il funzionamento di base del framework 

Library   SeleniumLibrary 

Resource  ../resources/common.resource
Resource  ../resources/common_${ENV}.resource

Resource  ../resources/pageObject/loginPage.resource

*** Variables ***

*** Test Cases ***
Site is Reachable  
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    Check login form Is Present 

Check redirect from http to https
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser and go to Home page 
    Location Should Be  https://${URL}/
    Check login form Is Present 

This should be failed
    [Documentation]  It checks if it is possible to navigate to www.saucedemo.com
    Open Browser and go to Home page 
    Location Should Be  https://www.libero.it
