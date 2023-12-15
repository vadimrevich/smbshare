/* ********************************************************
 * IE_Atavi_Run.js
 *
 * This Script will Run an Internet Explorer Application
 * with Command Line at aSite Home Page
 * 
 * PARAMETERS:  NONE
 * RETURN:      Always 0
 * *******************************************************/

/**********************************************************
 * IE_RUN_Site
 * This Function Run the Internet Explorer Application
 * 
 * PARAMETERS:  aSite as String is a Home Page
 * RETURNS:     Always 0
******************************************************** */
function IE_RUN_Site( aSite) {
    var objIE;
    // Define Internet Explorer COM Application
    objIE = new ActiveXObject("InternetExplorer.Application");
    // Set a Home Page
    objIE.Navigate(aSite);
    // Set a Page Visible
    objIE.Visible = 1;
    // Return Zero
    return 0;
}

// Define Variables
var iFlag, aSite;
aSite = "https://www.atavi.com/";

// Run Payload
iFlag = IE_RUN_Site(aSite);

// Return a Script Value
WScript.Quit(iFlag);
