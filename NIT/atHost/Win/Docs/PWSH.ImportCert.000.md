## Import Certificate to Trusted Root but not to Personal \[Command Line\]

-   Вопрос
-   Лучший ответ
-   Ещё 4 ответа

Look at the documentation of certutil.exe and \-addstore option.I tried

`   certutil -addstore "Root" "c:\cacert.cer"   `

and it worked well (meaning The certificate landed in Trusted Root of LocalMachine store).EDIT:If there are multiple certificates in a pfx file (key + corresponding certificate and a CA certificate) then this command worked well for me:

`   certutil -importpfx c:\somepfx.pfx   `

EDIT2:To import CA certificate to Intermediate Certification Authorities store run following command

`   certutil -addstore "CA" "c:\intermediate_cacert.cer"   `

# Import-Certificate

Module:

[PKIClient Module](https://learn.microsoft.com/en-us/powershell/module/pki/?view=windowsserver2025-ps)

## In this article

1.  Syntax
    
    1.  [Syntax](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#syntax)
    2.  [Default (Default)](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#default)
    
2.  [Description](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#description)
3.  Examples
    
    1.  [Examples](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#examples)
    2.  [EXAMPLE 1](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-1)
    3.  [EXAMPLE 2](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-2)
    4.  [EXAMPLE 3](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-3)
    
4.  Parameters
    
    1.  [Parameters](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#parameters)
    2.  [\-CertStoreLocation](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-certstorelocation)
    3.  [\-Confirm](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-confirm)
    4.  [\-FilePath](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-filepath)
    5.  [\-WhatIf](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-whatif)
    6.  [CommonParameters](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#common-parameters)
    
5.  Inputs
    
    1.  [Inputs](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#inputs)
    2.  [String](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#input-1)
    
6.  Outputs
    
    1.  [Outputs](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#outputs)
    2.  [X509Certificate2](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#output-1)
    
7.  [Related Links](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#related-links)

Show 3 more

Imports one or more certificates into a certificate store.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#syntax)

## Syntax

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#default)

### Default (Default)

Syntax Copy

```
Import-Certificate
    [-FilePath] &lt;String&gt;
    [-CertStoreLocation &lt;String&gt;]
    [-WhatIf]
    [-Confirm]
    [&lt;CommonParameters&gt;]
```

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#description)

## Description

The `Import-Certificate` cmdlet imports one or more certificates into a certificate store.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#examples)

## Examples

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-1)

### EXAMPLE 1

PowerShell Copy

```
<span><span class="hljs-variable">$params</span> = @{
    FilePath = <span class="hljs-string">'C:\Users\Xyz\Desktop\BackupCert.cer'</span>
    CertStoreLocation = <span class="hljs-string">'Cert:\CurrentUser\Root'</span>
}
<span class="hljs-pscommand">Import-Certificate</span> @params
</span>
```

This example imports the certificate from the file into the root store of the current user.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-2)

### EXAMPLE 2

PowerShell Copy

```
<span><span class="hljs-pscommand">Set-Location</span><span class="hljs-parameter"> -Path</span> cert:\CurrentUser\My

<span class="hljs-pscommand">Import-Certificate</span><span class="hljs-parameter"> -Filepath</span> <span class="hljs-string">'C:\files\intermediate.cert'</span>
</span>
```

This example imports the certificate from the file into the current store.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#example-3)

### EXAMPLE 3

PowerShell Copy

```
<span><span class="hljs-variable">$params</span> = @{
    FilePath = <span class="hljs-string">'C:\Users\Xyz\Desktop\BackupCert.cer'</span>
    CertStoreLocation = <span class="hljs-string">'Cert:\LocalMachine\Root'</span>
}
<span class="hljs-pscommand">Import-Certificate</span> @params
</span>
```

This example imports the certificate from the file into the root store of the local machine.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#parameters)

## Parameters

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-certstorelocation)

### \-CertStoreLocation

Specifies the path to the certificate store where the certificates will be imported. If the path to the certificate store is not specified, then the current store is used. In order to get a list of valid **CertStoreLocation** values, open PowerShell and run `Get-ChildItem Cert:\`.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#certstorelocation-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="certstorelocation" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.string" data-linktype="absolute-path">String</a></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#certstorelocation-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 2"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-confirm)

### \-Confirm

Prompts you for confirmation before running the cmdlet.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#confirm-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="confirm" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter" data-linktype="absolute-path">SwitchParameter</a></td></tr><tr><td>Default value:</td><td>False</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>cf</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#confirm-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 4"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-filepath)

### \-FilePath

Specifies the path to a certificate file to be imported. Acceptable formats include `.sst`, `.p7b`, and `.cert` files. If the file contains multiple certificates, then each certificate will be imported to the destination store. The file must be in `.sst` format to import multiple certificates; otherwise, only the first certificate in the file will be imported.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#filepath-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="filepath" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.string" data-linktype="absolute-path">String</a></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>FullName</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#filepath-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 6"><tbody><tr><td>Position:</td><td>0</td></tr><tr><td>Mandatory:</td><td>True</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>True</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#-whatif)

### \-WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#whatif-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="whatif" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter" data-linktype="absolute-path">SwitchParameter</a></td></tr><tr><td>Default value:</td><td>False</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>wi</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#whatif-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 8"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#common-parameters)

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable, -ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about\_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#inputs)

## Inputs

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#input-1)

### [String](https://learn.microsoft.com/en-us/dotnet/api/system.string)

A **String** containing the file path.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#outputs)

## Outputs

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-certificate?view=windowsserver2025-ps#output-1)

### [X509Certificate2](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509certificate2)

The output is an array of **X509Certificate2\[\]** objects.

# Import-PfxCertificate

Module:

[PKIClient Module](https://learn.microsoft.com/en-us/powershell/module/pki/?view=windowsserver2025-ps)

## In this article

1.  Syntax
    
    1.  [Syntax](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#syntax)
    2.  [Default (Default)](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#default)
    
2.  [Description](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#description)
3.  Examples
    
    1.  [Examples](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#examples)
    2.  [EXAMPLE 1](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-1)
    3.  [EXAMPLE 2](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-2)
    4.  [EXAMPLE 3](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-3)
    
4.  Parameters
    
    1.  [Parameters](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#parameters)
    2.  [\-CertStoreLocation](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-certstorelocation)
    3.  [\-Confirm](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-confirm)
    4.  [\-Exportable](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-exportable)
    5.  [\-FilePath](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-filepath)
    6.  [\-Password](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-password)
    7.  [\-WhatIf](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-whatif)
    8.  [CommonParameters](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#common-parameters)
    
5.  Inputs
    
    1.  [Inputs](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#inputs)
    2.  [String](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#input-1)
    
6.  Outputs
    
    1.  [Outputs](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#outputs)
    2.  [X509Certificate2](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#output-1)
    
7.  [Related Links](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#related-links)

Show 3 more

Imports certificates and private keys from a Personal Information Exchange (PFX) file to the destination store.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#syntax)

## Syntax

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#default)

### Default (Default)

Syntax Copy

```
Import-PfxCertificate
    [-Exportable]
    [-Password &lt;SecureString&gt;]
    [[-CertStoreLocation] &lt;String&gt;]
    [-FilePath] &lt;String&gt;
    [-WhatIf]
    [-Confirm]
    [&lt;CommonParameters&gt;]
```

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#description)

## Description

The `Import-PfxCertificate` cmdlet imports certificates and private keys from a PFX file to the destination store. Certificates with and without private keys in the PFX file are imported, along with any external properties that are present.

Delegation may be required when using this cmdlet with Windows PowerShell remoting and changing user configuration.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#examples)

## Examples

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-1)

### EXAMPLE 1

PowerShell Copy

```
<span><span class="hljs-variable">$mypwd</span> = <span class="hljs-pscommand">Get-Credential</span><span class="hljs-parameter"> -UserName</span> <span class="hljs-string">'Enter password below'</span><span class="hljs-parameter"> -Message</span> <span class="hljs-string">'Enter password below'</span>

<span class="hljs-variable">$params</span> = @{
    FilePath = <span class="hljs-string">'C:\mypfx.pfx'</span>
    CertStoreLocation = <span class="hljs-string">'Cert:\LocalMachine\My'</span>
    Password = <span class="hljs-variable">$mypwd</span>.Password
}
<span class="hljs-pscommand">Import-PfxCertificate</span> @params
</span>
```

This example imports the PFX file `mypfx.pfx` with a private, non-exportable key into the My store for the machine account.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-2)

### EXAMPLE 2

PowerShell Copy

```
<span><span class="hljs-pscommand">Get-ChildItem</span><span class="hljs-parameter"> -Path</span> C:\mypfx.pfx |
    <span class="hljs-pscommand">Import-PfxCertificate</span><span class="hljs-parameter"> -CertStoreLocation</span> Cert:\CurrentUser\My<span class="hljs-parameter"> -Exportable</span>
</span>
```

This example imports the PFX file `mypfx.pfx` with a private, exportable key into the My store for the current user. The **Password** parameter is not required since this PFX file is not password protected.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#example-3)

### EXAMPLE 3

PowerShell Copy

```
<span><span class="hljs-pscommand">Set-Location</span><span class="hljs-parameter"> -Path</span> Cert:\LocalMachine\My

<span class="hljs-pscommand">Import-PfxCertificate</span><span class="hljs-parameter"> -FilePath</span> C:\mypfx.pfx
</span>
```

This example imports the PFX file `mypfx.pfx` into the My store for the machine account. The **Password** parameter is not required since this PFX file is protected using the domain account of this machine. This requires a Windows Server 2012 or later domain controller.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#parameters)

## Parameters

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-certstorelocation)

### \-CertStoreLocation

Specifies the path of the store to which certificates will be imported. If this parameter is not specified, then the current path is used as the destination store.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#certstorelocation-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="certstorelocation" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.string" data-linktype="absolute-path">String</a></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#certstorelocation-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 2"><tbody><tr><td>Position:</td><td>1</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-confirm)

### \-Confirm

Prompts you for confirmation before running the cmdlet.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#confirm-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="confirm" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter" data-linktype="absolute-path">SwitchParameter</a></td></tr><tr><td>Default value:</td><td>False</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>cf</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#confirm-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 4"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-exportable)

### \-Exportable

Specifies whether the imported private key can be exported. If this parameter is not specified, then the private key cannot be exported.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#exportable-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="exportable" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter" data-linktype="absolute-path">SwitchParameter</a></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#exportable-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 6"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-filepath)

### \-FilePath

Specifies the path for the PFX file.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#filepath-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="filepath" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.string" data-linktype="absolute-path">String</a></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>FullName</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#filepath-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 8"><tbody><tr><td>Position:</td><td>0</td></tr><tr><td>Mandatory:</td><td>True</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>True</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-password)

### \-Password

Specifies the password for the imported PFX file in the form of a secure string.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#password-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="password" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><span class="no-loc xref">System.SecureString</span></td></tr><tr><td>Default value:</td><td>None</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#password-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 10"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#-whatif)

### \-WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#whatif-properties)

#### Parameter properties

Expand table

<table data-chunk-ids="whatif" class="table table-sm margin-top-none" aria-label="Parameter properties"><tbody><tr><td>Type:</td><td><a class="no-loc" href="https://learn.microsoft.com/en-us/dotnet/api/system.management.automation.switchparameter" data-linktype="absolute-path">SwitchParameter</a></td></tr><tr><td>Default value:</td><td>False</td></tr><tr><td>Supports wildcards:</td><td>False</td></tr><tr><td>DontShow:</td><td>False</td></tr><tr><td>Aliases:</td><td>wi</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#whatif-sets)

#### Parameter sets

(All)

Expand table

<table class="table table-sm margin-top-none" aria-label="Table 12"><tbody><tr><td>Position:</td><td>Named</td></tr><tr><td>Mandatory:</td><td>False</td></tr><tr><td>Value from pipeline:</td><td>False</td></tr><tr><td>Value from pipeline by property name:</td><td>False</td></tr><tr><td>Value from remaining arguments:</td><td>False</td></tr></tbody></table>

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#common-parameters)

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutBuffer, -OutVariable, -PipelineVariable, -ProgressAction, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about\_CommonParameters](https://go.microsoft.com/fwlink/?LinkID=113216).

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#inputs)

## Inputs

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#input-1)

### [String](https://learn.microsoft.com/en-us/dotnet/api/system.string)

A **String** containing the path to the PFX file.

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#outputs)

## Outputs

[](https://learn.microsoft.com/en-us/powershell/module/pki/import-pfxcertificate?view=windowsserver2025-ps#output-1)

### [X509Certificate2](https://learn.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.x509certificate2)

The imported **X509Certificate2** object contained in the PFX file that is associated with private keys.

