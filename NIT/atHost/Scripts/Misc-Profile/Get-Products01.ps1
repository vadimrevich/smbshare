﻿Get-WMIObject -Class Win32_Product | Where-Object -Property Vendor -Match "New Internet" | Select-Object -Property Name, IdentifyingNumber, Vendor, Version