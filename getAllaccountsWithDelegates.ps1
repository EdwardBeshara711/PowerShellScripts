#GET ALL users with delegates

Get-ADUser -Properties msExchDelegateListLink -LDAPFilter "(msExchDelegateListLink=*)" |
    Select @{n='Distinguishedname';e={$_.distinguishedname}},@{n= 'alternate';e={$_.msExchDelegateListLink}} |
    Sort distinguishedname