#Inventory Shared Folders and Review Permissions
$Shares = Get-SMBShare | Where-Object {$_.ShareType -eq "FileSystemDirectory"}
foreach ($Share in $Shares) {
    Write-Host "Name: $($Share.name)" -ForegroundColor Green
    Write-Host "Path: $($Share.path)" -ForegroundColor Cyan
    Write-Host "Description: $($Share.Description)" -ForegroundColor Magenta
    Write-Host "Scope Name: $($Share.scopename)" -ForegroundColor DarkYellow
    Write-Host "----------------------------------------------------" -ForegroundColor White
}
