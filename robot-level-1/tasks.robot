*** Settings ***
Documentation     Insert the sales data for the week and export it as a PDF.
Library           RPA.Browser.Selenium  auto_close=${FALSE}
Library           RPA.Robocorp.Vault


*** Tasks ***
Insert the sales data for the week and export it as a PDF
    Open the intranet website
    Log in
    Fill and submit the form


*** Keywords ***
Open the intranet website
    Open Available Browser    https://robotsparebinindustries.com/

Log in
    ${secret}=  Get Secret  credentials
    Input Text  username    ${secret}[username]
    Input Password  password    ${secret}[password]
    Submit Form
    # Some websites use lazy loading. It means that some content of the page
    # might not be there immediately when you open a page, so the robot needs to
    # wait for things to become available before interacting with them.
    Wait Until Page Contains Element    id:sales-form

Fill and submit the form
    Input Text  firstname   John
    Input Text  lastname    Smith
    Input Text  salesresult    123
    # The sales target is a select HTML element.
    Select From List By Value   salestarget    10000
    Click Button    Submit


    