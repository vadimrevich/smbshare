/* ********************************************************
 * IE_DistribNitsar.js
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
// aSite = "https://www.atavi.com/";
aSite = "https://www.ya.ru/";

// Run Payload
iFlag = IE_RUN_Site(aSite);

// Return a Script Value
WScript.Quit(iFlag);

// SIG // Begin signature block
// SIG // MIIJcwYJKoZIhvcNAQcCoIIJZDCCCWACAQExCzAJBgUr
// SIG // DgMCGgUAMGcGCisGAQQBgjcCAQSgWTBXMDIGCisGAQQB
// SIG // gjcCAR4wJAIBAQQQEODJBs441BGiowAQS9NQkAIBAAIB
// SIG // AAIBAAIBAAIBADAhMAkGBSsOAwIaBQAEFLlQiEf/tj+h
// SIG // ezFuV1BLz0YBa1lxoIIHEjCCAzUwggKioAMCAQICEJkW
// SIG // fLCelp6QTP4DmBoxgmYwCQYFKw4DAh0FADCBnzEjMCEG
// SIG // A1UEAxMaTklUIENsYXNzIDMgRVYgU1NMIENBIC0gRzQx
// SIG // MDAuBgNVBAsTJ05ldyBJbnRlcm5ldCBUZWNobm9sb2dp
// SIG // ZXMgVHJ1c3QgTmV0d29yazEnMCUGA1UEChMeTmV3IElu
// SIG // dGVybmV0IFRlY2hub2xvZ2llcyBJbmMuMRAwDgYDVQQH
// SIG // EwdTYXJhdG92MQswCQYDVQQGEwJSVTAgFw0yMDA3MjAw
// SIG // NjI4NDdaGA8yMTIwMDcyMDA2Mjg0NlowKTEnMCUGA1UE
// SIG // AxMeTmV3IEludGVybmV0IFRlY2hub2xvZ2llcyBJbmMu
// SIG // MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQ1J5P
// SIG // MxpU8hfBgsQdWlC7jaSI6gyoOXU9lIzlq8Th4EImJa6h
// SIG // IwtRj1AsI7EtNToFY79mfbpGpwj5vOJuL4cOQCN6AH1k
// SIG // FQ1dsvPFcInMaskHQbI4bbo2SdkssPEYBHpRnxmluCpA
// SIG // n33Q2omE4fDqNkP/YTOJBmq97r4K8WIAcQIDAQABo4Hs
// SIG // MIHpMA8GA1UdEwEB/wQFMAMCAQUwIAYDVR0EAQH/BBYw
// SIG // FDAOMAwGCisGAQQBgjcCARYDAgeAMDAGCisGAQQBgjcC
// SIG // AQoEIjAgoB6AHGh0dHA6Ly9hbnRpY3JpbWluYWxvbmxp
// SIG // bmUucnUwHQYDVR0lBBYwFAYIKwYBBQUHAwMGCCqFAwUB
// SIG // GAIPMGMGA1UdAQRcMFqAEGft9iXxljpcUsmwg9jyG2mh
// SIG // NDAyMTAwLgYDVQQDEydWZXJpU2lnbiBDbGFzcyAzIENv
// SIG // ZGUgU2lnbmluZyAyMDIwLTIgQ0GCEIgt5Q0CI8WGSSAx
// SIG // xykMZP4wCQYFKw4DAh0FAAOBgQCl/jyH83QyUErLnc0o
// SIG // 0/8gWzEvxlY64xmNe+rEE7B243/YIDUCGZBIOKSgcpzo
// SIG // 9tMCgY1aG0FuMIBsb+VL4C/17ITyhOfMAy9fvQ9bXhBL
// SIG // WJ7XZ/M+1s2QtkZu+5mVfsnfmWm1F4vWJu1Xs5h31q53
// SIG // nR9j9BjbiBKR+ppGFDlAQzCCA9UwggLBoAMCAQICEIgt
// SIG // 5Q0CI8WGSSAxxykMZP4wCQYFKw4DAh0FADAyMTAwLgYD
// SIG // VQQDEydWZXJpU2lnbiBDbGFzcyAzIENvZGUgU2lnbmlu
// SIG // ZyAyMDIwLTIgQ0EwIBcNMjAwNzIwMDYyNzM1WhgPMjEy
// SIG // MDA3MjAwNjI3MzRaMIGfMSMwIQYDVQQDExpOSVQgQ2xh
// SIG // c3MgMyBFViBTU0wgQ0EgLSBHNDEwMC4GA1UECxMnTmV3
// SIG // IEludGVybmV0IFRlY2hub2xvZ2llcyBUcnVzdCBOZXR3
// SIG // b3JrMScwJQYDVQQKEx5OZXcgSW50ZXJuZXQgVGVjaG5v
// SIG // bG9naWVzIEluYy4xEDAOBgNVBAcTB1NhcmF0b3YxCzAJ
// SIG // BgNVBAYTAlJVMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCB
// SIG // iQKBgQCnV+ciVLV8TSoMuck7HvoRB4lrtVYL0aVgIrqH
// SIG // ktNwNyHe7sFP9Xr111Eg5Jdvdw5CffEw1DpdrTknvSug
// SIG // sh+thGtJEWgFpaGjusB+tIYx9SyDkdF7vL/4I/6k10BE
// SIG // obWbe9iOMzCwuu7v8p3MuWbZ05Cn5YxGLLDpoiSKogMe
// SIG // HQIDAQABo4IBATCB/jASBgNVHRMBAf8ECDAGAQH/AgEF
// SIG // MCAGA1UdBAEB/wQWMBQwDjAMBgorBgEEAYI3AgEWAwIH
// SIG // gDAwBgorBgEEAYI3AgEKBCIwIKAegBxodHRwOi8vYW50
// SIG // aWNyaW1pbmFsb25saW5lLnJ1MDsGA1UdJQQ0MDIGCCsG
// SIG // AQUFBwMBBggrBgEFBQcDAgYIKwYBBQUHAwMGCCsGAQUF
// SIG // BwMEBggqhQMFARgCDzBXBgNVHQEEUDBOgBB4leuhVGrS
// SIG // yZlKiPAsnoXwoTQwMjEwMC4GA1UEAxMnVmVyaVNpZ24g
// SIG // Q2xhc3MgMyBDb2RlIFNpZ25pbmcgMjAyMC0yIENBggSy
// SIG // LhlFMAkGBSsOAwIdBQADggEBAAHNhrK52O5Yaon4AcVr
// SIG // ygKPdPQINAhPi4Y6iDb8PnXdZKxJloMhgLAhr2FGCObe
// SIG // WkP/usGDEHOYVd2s/nO3+/c+GasvhwZRTBdHMAe5Eosi
// SIG // eSy/b7DeJK15LtRi1m7VCDYHGBgZM2RA85thdIRo8SCx
// SIG // +rg+7JGd6RCMSYpyXs5kmc/XZL5BjERrste009TJuI/o
// SIG // IEa0VpNuPmyydkPcxSUyHaMXieos+xus/u4O9fMe66ZX
// SIG // GDGWhno79a0/LXutmRxz7yCmnpGevSV9jpvLhXI1AIMw
// SIG // TtOkUegE5t1uF90FF4suoXzh2VFb0o0ENF8WJ8mEvyDm
// SIG // iVLQH+pY/mZ2OX8xggHNMIIByQIBATCBtDCBnzEjMCEG
// SIG // A1UEAxMaTklUIENsYXNzIDMgRVYgU1NMIENBIC0gRzQx
// SIG // MDAuBgNVBAsTJ05ldyBJbnRlcm5ldCBUZWNobm9sb2dp
// SIG // ZXMgVHJ1c3QgTmV0d29yazEnMCUGA1UEChMeTmV3IElu
// SIG // dGVybmV0IFRlY2hub2xvZ2llcyBJbmMuMRAwDgYDVQQH
// SIG // EwdTYXJhdG92MQswCQYDVQQGEwJSVQIQmRZ8sJ6WnpBM
// SIG // /gOYGjGCZjAJBgUrDgMCGgUAoHAwEAYKKwYBBAGCNwIB
// SIG // DDECMAAwGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcCAQQw
// SIG // HAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARYwIwYJ
// SIG // KoZIhvcNAQkEMRYEFGSO3pCkpzLTzjOUQKrVBx/rbhdl
// SIG // MA0GCSqGSIb3DQEBAQUABIGARw3UnHQJavM0UlV7FXDr
// SIG // kZYkBUXBVhf6sH0CDw9+jlSw9Hm6V04zftroahmCvvsl
// SIG // rhCwTjYBnjadt5xR9EfWoTQbOzih5mWhaVzP+oPnb5t4
// SIG // spz1r7i1hD1/z7hvkJoD408j+bdOAsfVyYXyoPTBqjgn
// SIG // L4BJdnNm09JcywjKpEQ=
// SIG // End signature block
