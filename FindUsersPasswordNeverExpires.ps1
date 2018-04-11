#this script finds users set with PASSWORD NEVER Expires and emails to samanage


$SearchBase = "OU=End_Users,DC=contoso,DC=com"
$date = Get-Date -Format FileDateTime 
$file = "$date"


$Users = Search-ADAccount -PasswordNeverExpires -Searchbase $SearchBase | 
    Foreach -Begin {$i=0} -Process {
        $i++
        # formatting below
        "<p><b>{0:D2}. {1} </b> | {2} <br></p>" -f $i,$_.name,$_.DistinguishedName
    } |
    Out-String



$mailProperties = @{
    To = "support@support.contoso.com"
    From = "IT Automation <automation@constoso.com>"
    BodyAsHTML = $true
    Body = $Users
    Port = 587
    Subject = "End Users Passwords to Never Expire "
    SmtpServer = "mail.constoso.com"
    
}

if(!$Users) {
    $emptyMessage = "No users have passwords set to Never Expire"
    $emptyMessage | out-file C:\ScriptLogs\PasswordNeverExpires\$file"Users_NeverExpire.txt"
} else {
    Send-MailMessage @mailProperties
    $Users | out-file C:\ScriptLogs\PasswordNeverExpires\$file"Users_NeverExpire.txt"
}

