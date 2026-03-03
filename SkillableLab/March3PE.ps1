$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"

if (Get-ADOrganizationalUnit -Identity $OUPath -ErrorAction SilentlyContinue) {
    Write-Host "The London OU already exists."
}
else { (New-ADOrganizationalUnit -Name $OUName -Path $DomainDN)
        Write-Host "A New OU named London has been created"
}