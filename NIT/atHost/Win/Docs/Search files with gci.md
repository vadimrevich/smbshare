```powershell
$(gci -Path .  -Filter *.ps1).FullName
```

```powershell
$(gci -Path . -Recurse -Filter *passw*d*.txt).FullName
```

```powershell
gci -Path C:\Users\user -Recurse -Filter *passw*d*.txt
```

### Search with selected string

```powershell
gci -Path d:\yuden\Download -Recurse -Filter descript.ion | Select-String .*password.* | fl *
```

```powershell
gci -Path . -Recurse -Filter *passw*d*.txt | Select-String brod | fl Path,Line
```

