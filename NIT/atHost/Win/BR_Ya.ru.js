/* ********************************************************
 * BR_DocNIT.js
 *
 * This Script will Open Internet Link aSite
 * at Current Browser
 * 
 * PARAMETERS:  NONE
 * RETURN:      Always 0
 * *******************************************************/

/**********************************************************
 * BR_RUN_Site
 * This Function Run the Current Browser
 * 
 * PARAMETERS:  aSite as String is a Home Page
 * RETURNS:     Always 0
******************************************************** */
function BR_RUN_Site( aSite) {
    var wsh;
    wsh = new ActiveXObject("WScript.Shell");
    wsh.Run( aSite, 1, false);
    return 0;
}

// Set aSite URL
var aSite, iFlag;
aSite="https://ya.ru/";

iFlag = BR_RUN_Site( aSite );

WScript.Quit(iFlag);
