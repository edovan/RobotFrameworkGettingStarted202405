*** Settings ***
Documentation   Prima suite di test: in questa suite verifichiamo il funzionamento di base del framework 

Library   SeleniumLibrary 

*** Variables ***
${ENV}  PRD
${BROWSER}   chrome

${windowsWidth}      1024
${windowsHeight}     768

*** Keywords ***
Open Browser and go to Home page 
    Open Browser  http://${URL}/  ${BROWSER} 
    Set Window Size   ${windowsWidth}   ${windowsHeight} 