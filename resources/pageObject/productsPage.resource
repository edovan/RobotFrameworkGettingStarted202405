*** Settings ***
Documentation  Rappresentazione della pagina di lista prodotti 

*** Variables ***
${pageTitle}    Products  

${pageSecondaryTitle}  xpath://div[@id='contents_wrapper']//div[@class='header_secondary_container']/span[@data-test='title']

${mainPageContainer_loc}  id:inventory_container
${productListContainer_loc}  //div[@id='contents_wrapper']//div[@data-test='inventory-container']
${productList_loc}  xpath://div[@id='contents_wrapper']//div[@data-test='inventory-container']//div[@data-test='inventory-list']

${shoppingCartIcon}  xpath://div[@id='shopping_cart_container']
${shoppingCartLink}  xpath://a[@data-test='shopping-cart-link']
# ${shoppingCartIcon}  id:shopping_cart_container
${shoppingCartIconBadge}  xpath://span[@data-test='shopping-cart-badge']

### CARD ITEM 
${singleProductInList_loc}  xpath://div[@data-test='inventory-item']
${singleProductInList-Image_loc}  xpath://div[@data-test='inventory-item']//*[contains(@data-test,'-img-link')]
${singleProductInList-DescriptionBlock_loc}  xpath://div[@data-test='inventory-item']//div[@data-test='inventory-item-description'] 
${singleProductInList-DescriptionBlock-Title_loc}  xpath://div[@data-test='inventory-item']//div[@data-test='inventory-item-name']
${singleProductInList-DescriptionBlock-TitleLink_loc}  xpath://div[@data-test='inventory-item']//div[@data-test='inventory-item-name']/..
${singleProductInList-DescriptionBlock-Description_loc}  xpath://div[@data-test='inventory-item']//div[@data-test='inventory-item-desc']
${singleProductInList-Pricebar-Price_loc}  xpath://div[@data-test='inventory-item']//div[@data-test='inventory-item-price']
${singleProductInList-Pricebar-Button_loc}  xpath://div[@data-test='inventory-item']//*[contains(@data-test,'remove-') or contains(@data-test,'add-to-')]
${singleProductInList-Pricebar-ButtonAdd_loc}  xpath://div[@data-test='inventory-item']//*[contains(@data-test,'add-to-')]
${singleProductInList-Pricebar-ButtonRemove_loc}  xpath://div[@data-test='inventory-item']//*[contains(@data-test,'remove-')]




*** Keywords ***
Check landing on default product list page 
    The page title must be Products   
    In the main content page must be shown a containter for elements to be sold 
    There must me an list of elemnt to be sold
    Element Should Be Visible  ${shoppingCartIcon}
    Element Should Be Visible  ${shoppingCartLink}
    Page should not Contain Element  ${shoppingCartIconBadge}
    ${elements}=  Get Element Count  ${singleProductInList_loc} 
    should be equal  ${elements}   ${6}



The page title must be Products
    Element Text Should be  ${pageSecondaryTitle}  ${pageTitle}  
    # Element Text Should be  ${pageSecondaryTitle}  products   ignore_case=${True}

In the main content page must be shown a containter for elements to be sold
    Page Should Contain Element  ${mainPageContainer_loc}
    Page Should Contain Element  ${productListContainer_loc}

There must me an list of elemnt to be sold
    [Documentation]  there must be a list of items 
    Page Should Contain Element  ${productList_loc}

In the item list there must be at least one element 
    [Documentation]  The item list must contains more than one element 
    ${countDiv}=  Get Element count  ${singleProductInList_loc}
    Should Be True	${countDiv} > 1
    RETURN  ${countDiv}