$date = (Get-date).AddDays(-180)
$fileDate = Get-date -Format FileDateTime
$file = "$fileDate"

#monthly get disabled users to delete
$list = Get-Aduser -filter {ObjectClass -eq "user"} -Properties SamAccountName,whenChanged,lastLogonDate,displayname,cn,givenname,sn,distinguishedname | 
        Where-Object {($_.whenChanged -lt $date) -and ($_.distinguishedname -like "*OU=Disabled Users,DC=contoso,DC=com*") } |
        Select-Object SamAccountName,whenChanged,lastLogonDate,displayname,cn,givenname,sn,distinguishedname 

if (!$list) {
    
    $noUserMessage = " No users found "
    $noUserMessage | Out-File Y:\Scriptlogs\DisabledUsersLog\$file"disabledUsers.txt"

} else {

    $list | Export-Csv -NoTypeInformation Y:\DisabledUsersToClean\$file"DisabledUsers180Days.csv"

}
