$SearchBase = "OU=Disabled Users,DC=Contoso,DC=com"
$date = Get-Date -Format FileDateTime 
$file = "$date"

$users = get-aduser -filter * -SearchBase $SearchBase  -properties samaccountname,msExchHideFromAddressLists |
    Where-Object {$_.msExchHideFromAddressLists -eq  $false} |
    Select-Object samaccountname,msExchHideFromAddressLists 

#making a pretty list below to insert into email [needs to be a string]

$i=0

$list = Foreach ($user in $users){
    $i++
    "{0:D2}. {1} </b> | HIDDEN FROM GAL: {2}" -f $i,$user.Samaccountname,$user.msExchHideFromAddressLists
}

$StringList = $list | Out-String

#splatting mail properties for send-mailmessage
$mailProperties = @{
    To = "support@contoso.com"
    From = "automation@contoso.com"
    BodyAsHTML = $true
    Body = $StringList
    Port = 587
    Subject = "These Disabled Users were removed from GAL"
    SmtpServer = "mail.contoso.com"
}


if(!$users) {
    #creating log file
    $emptyMessage = "No Users Removed From GAL"
    $emptyMessage | out-file C:\ScriptLogs\GALCleanUP\$file"Removed_FromGAL.txt"

} else {

    #doing the remove from GAL action and creating log
	$users | out-file C:\ScriptLogs\GALCleanUP\$file"Removed_FromGAL.txt"
	
    Foreach ($account in $users){
        $username = $account.samaccountname
        Set-aduser -identity $username -Replace @{msExchHideFromAddressLists="TRUE"}
    }
    
    Send-MailMessage @mailProperties
}

Clear-Variable $users