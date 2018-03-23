
#script gets old devices that still have activeSynceDevicePartnership



$ou = "*OU=oldUsers, OU=users, DC=CONTOSO, dc=com"

Get-CASMailbox –Filter {(HasActiveSyncDevicePartnership -eq $true) -AND
    (distinguishedName -like $ou ) -AND
    (name -notlike "Admin*") -AND
    (name -notlike "AnotherString*")} |
    ForEach-Object {Get-MobileDeviceStatistics -Mailbox $_.Identity |
    Where-Object {$_.LastSuccessSync -le ((Get-Date).AddDays("-1"))}} |
    Select-Object Identity,LastSuccessSync,devicemodel | ft






