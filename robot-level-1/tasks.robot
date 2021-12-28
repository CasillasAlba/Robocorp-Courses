*** Settings ***
Documentation     Insert the sales data for the week and export it as a PDF.
Library           RPA.Browser.Selenium  auto_close=${FALSE}
Library           RPA.Robocorp.Vault
Library           RPA.HTTP
Library           RPA.Excel.Files

*** Tasks ***
Insert the sales data for the week and export it as a PDF
    Open the intranet website
    Log in
    Download the Excel file
    Fill the form using data from the Excel file
    Collect the results

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


Download the Excel file
    Download    https://robotsparebinindustries.com/SalesData.xlsx    overwrite=True

Fill and submit the form for one person
    [Arguments]    ${sales_rep}
    Input Text  firstname   ${sales_rep}[First Name]
    Input Text  lastname    ${sales_rep}[Last Name]
    Input Text  salesresult    ${sales_rep}[Sales]
    # The sales target is a select HTML element.
    Select From List By Value   salestarget    ${sales_rep}[Sales Target]
    Click Button    Submit

Fill the form using data from the Excel file
    Open Workbook   SalesData.xlsx
    # sales_reps may contain something like: ${sales_reps} = Table(columns=['First Name', Last Name', Sales', 'Sales Target'], rows=50)
    ${sales_reps}=    Read Worksheet As Table    header=True
    Close Workbook
    FOR    ${sales_rep}    IN    @{sales_reps}
        Fill and submit the form for one person    ${sales_rep}
    END

Collect the results
    # The css:div.sales-summary locator means: find me a div element that has the sales-summary CSS class.
    # We use it due to we don't have a id HTML tag but we have the CSS class
    # Our path for the file will be:  ${OUTPUT_DIR}${/}sales_summary.png
    # where  ${OUTPUT_DIR} is a special Robot Framework runtime variable that represents the output directory.
    # and ${/} is a built-in variable for the directory path separator (works in any operating system).
    Screenshot    css:div.sales-summary    ${OUTPUT_DIR}${/}sales_summary.png




    