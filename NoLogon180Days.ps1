
#End Users - getting list of users

$ou = "Distinguished name"

$Users = Get-AdUser -filter {Enabled -eq $TRUE} -Searchbase $ou  -Properties SamAccountName,whenChanged,lastLogonDate,displayname,whenCreated,distinguishedname | 
    Where-Object {
        ($_.lastLogonDate -lt (Get-Date).AddDays(-180)) -and
        ($_.whenCreated -lt (Get-Date).AddDays(-180)) } | 
    Select-Object SamAccountName,whenChanged,lastLogonDate,displayname,whenCreated,distinguishedname


