#Build a Script that Inventories Local Users and Groups
$ComputerName = Read-Host "Enter the Computer Name:"
Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    $Users = Get-LocalUser
    foreach ($User in $Users) {
        Write-Host "Name: $($User.name)" -ForegroundColor Green
        Write-Host "Enabled: $($User.enabled)" -ForegroundColor Cyan
        Write-Host "Last Logon: $($User.lastlogon)" -ForegroundColor Magenta
        Write-Host "====================================================" -ForegroundColor White
    }
    $Groups = Get-LocalGroup
    foreach ($Group in $Groups) {
        try {
            $MemberCount = (Get-LocalGroupMember -Group $Group.name).Count
        }
        catch {
            $MemberCount = "Unknown"
        }
        if ($Group.name -match "Admin|Remote|Backup") {
            $Flag = "***Review***"
        } else {
            $Flag = "------"
        }
        Write-Host "Group Name: $($Group.name)" -ForegroundColor Green
        Write-Host "Group Description: $($Group.description)" -ForegroundColor Cyan
        Write-Host "Group SID: $($Group.SID)" -ForegroundColor Magenta
        Write-Host "Members: $MemberCount" -ForegroundColor DarkYellow
        Write-Host "$Flag" -ForegroundColor Red
        Write-Host "====================================================" -ForegroundColor White
    }
}
#Allows an Administrator to remotely access the local users and groups on a machine.
#For users, the Administrator can view key details like last logon date and enabled
#to verify which accounts are active, disabled, etc. From there, the Administrator
#can perform other actions to delete old/unused accounts, enable/disable accounts,
#or other actions. From a group perspective, the Administrator can identify unknown
#or unused groups. He can also check groups containing key words: Admin (privileges)
#backup (file access) or remote (remote access).