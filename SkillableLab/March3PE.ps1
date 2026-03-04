#Creates an Organizational Unit (OU) named "London" if it does not exist. 
#If it does exist, write a message to the console stating that it already exists.
$LondonOUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$LondonOUPath = "OU=$OUName,$DomainDN" 

if (Get-ADOrganizationalUnit -Identity $LondonOUPath -ErrorAction SilentlyContinue) {
    Write-Host "The London OU already exists."
}
else { (New-ADOrganizationalUnit -Name $LondonOUName -Path $DomainDN)
        Write-Host "A New OU named London has been created"
}

#Inside the new "London" OU create a global security group named "London Users" 
$GSGroupName = "London Users"
$SalesOUName = "Sales"
$SalesOUPath = "OU=$SalesOUName,$DomainDN"

New-ADGroup -Name $GSGroupName -Path $LondonOUPath -GroupScope Global -GroupCategory Security
       Write-Host "$GSGroupName Global Security Group has been created." 

#Locate all users int the Sales OU that have an address in the city of London and move them into the London OU. 
Get-ADUser -Filter "City -EQ 'London'" -SearchBase $SalesOUPath |
        Move-ADObject -TargetPath $LondonOUPath
        Write-Host "Users successfully moved to London OU"

#Add the London OU users into the "London Users" security group. 
$Users = Get-ADUser -SearchBase $LondonOUPath -Filter *

ForEach ($user in $users) {
        Add-ADGroupMember -Identity $GSGroupName -Members $user
        Write-Host "Users sucessfully moved."
}
