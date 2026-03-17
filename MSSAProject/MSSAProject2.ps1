#List Ip Address for a Remote Host
$Computer = Read-Host "Enter the Remote Computer Name"
try { $IPInformation = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration `
    -Filter "IPEnabled = TRUE" -ComputerName $Computer -ErrorAction Stop
    Write-Host "IP Addresses for $Computer :" -ForegroundColor Green $IPInformation.IPAddress
}
catch {
    Write-Host "Unable to retrive IP Information for $computer" -ForegroundColor Red
}

