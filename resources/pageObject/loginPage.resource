*** Settings ***
Documentation  Rappresentazione della pagina di login, contiene tutte le variabili e le keyword necessare ad interagire con la pagina

Resource  ../credentials.resource

*** Variables ***
${userNameInput_loc}   name:user-name
${passewordInput_loc}  name:password
${buttonLogin_loc}     id:login-button
${errorArea_loc}       xpath://div[@data-test='login-container']//*[@data-test='error']

*** Keywords ***
Check login form Is Present 
    [Documentation]  verifica la presenza in pagina del form di login 
    Wait Until Element Is Visible  ${userNameInput_loc}   error=Il login form non è apparso
    Page should contain Element   ${userNameInput_loc} 
    Page should contain Element   ${passewordInput_loc} 
    Page should contain Element   ${buttonLogin_loc} 

Check login form Is Not Present 
    [Documentation]  verifica la presenza in pagina del form di login 
    Wait Until Element Is Not Visible  ${userNameInput_loc}   error=Il login form non è apparso
    Page Should Not Contain Element   ${userNameInput_loc} 
    Page Should Not Contain Element   ${passewordInput_loc} 
    Page Should Not Contain Element   ${buttonLogin_loc} 

Insert Username
    Input Text   ${userNameInput_loc}  ${USERNAME}

Type Username 
    [Arguments]  ${_username}
    Input Text  ${userNameInput_loc}  ${_username}

Insert Password 
    Input Password  ${passewordInput_loc}  ${PASSWORD}

Type Password 
    [Arguments]  ${_password}=${PASSWORD}
    Input Password  ${passewordInput_loc}  ${_password}

Click login button 
    #Submit Form  
    Click Element  ${buttonLogin_loc} 


Get Login error message 
    [documentation]  it retrieves the erro message shown in the login form 
    ${errorMessage}=  Get Text  ${errorArea_loc}
    log to console  ${errorMessage} 
    RETURN  ${errorMessage}

Error message area is visible 
    [documentation]  it check if the error message area is Visible
    Wait Until Element Is Visible  ${errorArea_loc}   error=messaggio di errore non visualizato

Error message displayed should be 
    [Arguments]  ${expectedErrroMessage}
    ${errorMessage}=  Get Login error message 
    Should be equal  ${errorMessage}   ${expectedErrroMessage}