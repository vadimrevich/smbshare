/* ********************************************************
 * parse_ip.js
 * A JSCRIPT file with functions to parse IPv4 addresses
 * from a string
**********************************************************/

function TestIPv4( aString ) {
    var ipv4Regex = /^(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    var bRes;
    bRes = ipv4Regex.test(aString);
    return bRes;
}

function ExtractIPv4(aString) {
    var ipv4RegexG = /(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)/g;
    var strRes;
    strRes = aString.match(ipv4RegexG);
    return strRes;
}

function TestIPv6(aString) {
    var regex = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/;
    var bRes;
    bRes = regex.test(aString);
    return bRes;
}

function ExtractIPv6(aString) {
    var ipv6RegexG = /^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/g;
    var strRes;
    strRes = aString.match(ipv6RegexG);
    return strRes;
}

/* ********************************************************
 * This Function will return a first argiment
 * of CScript
 * *******************************************************/

function GetFirstArg() {
    var args = WScript.Arguments;
    var argsLen = args.length;
    if( argsLen == 0 ) {
        return "";
    }
    else {
        return args.Item(0);
    }
}

function ReadAllTextFile() {
    var fso, content, file;
    var arg = GetFirstArg();
    if( arg.length == 0) {
        return "";
    }
    else {
        fso = new ActiveXObject("Scripting.FileSystemObject");
        if( ! fso.FileExists(arg)) {
            return "";
        }
        else {
            file = fso.OpenTextFile(arg, 1, true);
            content = file.ReadAll();
            return content;
        }
    }
}

/* *******************************************************
 * runCommnd
 * This function is Run a Command and Return
 * a Full Output of a Command
 * ******************************************************/

function runCommand(command) {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wshShell = new ActiveXObject("WScript.Shell");
    do {
      var tempName = fso.BuildPath(fso.GetSpecialFolder(2), fso.GetTempName());
    } while ( fso.FileExists(tempName) );
    var cmdLine = fso.BuildPath(fso.GetSpecialFolder(1), "cmd.exe") + ' /C ' + command + ' > "' + tempName + '"';
    wshShell.Run(cmdLine, 0, true);
    var result = "";
    try {
      var ts = fso.OpenTextFile(tempName, 1, false);
      result = ts.ReadAll();
      ts.Close();
    }
    catch(err) {
    }
    if ( fso.FileExists(tempName) )
      fso.DeleteFile(tempName);
    return result;
  }
  
  var output = runCommand("dir");
  WScript.Echo(output);

// ********************************************************

function parse_ip000() {
    var arg = GetFirstArg();
    var bRes;
    if( arg.length == 0 ) {
        WScript.Echo("false");
        WScript.Quit(1);
    }
    bRes = TestIPv4(arg);
    if( bRes ) {
        WScript.Echo("true");
        WScript.Quit(0);
    }
    else {
        WScript.Echo("false");
        WScript.Quit(1);
    }
}

function parse_ip001() {
    var content = ReadAllTextFile();
    var anIPv4;
    if(content.length == 0) {
        WScript.Echo("");
        WScript.Quit(1);
    }
    else {
        anIPv4 = ExtractIPv4(content);
        if( anIPv4 == null || anIPv4.length == 0) {
                WScript.Echo("");
                WScript.Quit(1);
            }
        else {
            WScript.Echo(anIPv4);
            WScript.Quit(0);
        }
    }
}

function parse_ip002() {
    var content = ReadAllTextFile();
    if(content.length == 0) {
        WScript.Echo("false");
        WScript.Quit(1);
    }
    else {
        WScript.Echo(content);
        WScript.Quit(0);
    }
}

parse_ip001();
