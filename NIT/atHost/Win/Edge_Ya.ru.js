/* ********************************************************
 * Edge_Ya.ru.js
 *
 * This Script will Run an Microsoft Edge Application
 * with Command Line at aSite Home Page
 * 
 * PARAMETERS:  NONE
 * RETURN:      Always 0
 * *******************************************************/

/**********************************************************
 * IE_RUN_Site
 * This Function Run the Microsoft Edge Application
 * 
 * PARAMETERS:  aSite as String is a Home Page
 * RETURNS:     Always 0
******************************************************** */
function IE_RUN_Site( aSite) {
    var oShell, aStr;
    // Define Microsoft Edge COM Application
    oShell = new ActiveXObject("WScript.Shell");
    // Set a Home Page
    aStr = "microsoft-edge:"+aSite;
    oShell.Run("cmd.exe /C start " + aStr);

    // Return Zero
    return 0;
}

// Define Variables
var iFlag, aSite;
// aSite = "https://www.atavi.com/";
aSite = "https://www.ya.ru/";

// Run Payload
iFlag = IE_RUN_Site(aSite);

// Return a Script Value
WScript.Quit(iFlag);


