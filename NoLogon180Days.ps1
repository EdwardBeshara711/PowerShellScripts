
#End Users - getting list of users

$ou = "OU=End_Users,DC=contoso,DC=com"

$Users = Get-AdUser -filter {Enabled -eq $TRUE} -Searchbase $ou  -Properties SamAccountName,
    whenChanged,
    lastLogonDate,
    displayname,
    whenCreated,
    distinguishedname,
    AccountExpirationdate,
    PasswordLastSet,
    LastLogonTimestamp,
    Manager  | 
    
    Where-Object {
        ($_.lastLogonDate -lt (Get-Date).AddDays(-180)) -and
        ($_.whenCreated -lt (Get-Date).AddDays(-180)) -and
        ($_.PasswordLastSet -lt (Get-Date).AddDays(-180)) } | 
    
    Select-Object SamAccountName,
    whenChanged,
    lastLogonDate,
    displayname,
    whenCreated,
    distinguishedname,
    AccountExpirationdate,
    PasswordLastSet,
    @{n='LastLogonTimestamp';e={[DateTime]::FromFileTime($_.LastLogonTimestamp)}},
    @{N='Manager';E={(Get-ADUser $_.Manager).sAMAccountName}}


