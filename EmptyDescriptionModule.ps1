function Get-EmptyDescriptionInfo {

        [CmdletBinding()]

        Param (
            [Parameter(
                Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                HelpMessage="OU disstinguished name"
                )]
            [string]$OrganizationalUnit
        )

        BEGIN {
            Write-Verbose "begin"
        }

        PROCESS {
            foreach ($account in $Accounts) {
                try {
                    Write-Verbose "try"
                    $filter = "(&(!description=*))"
                    $useraccount = Get-ADUser -Searchbase $OrganizationalUnit -LDAPFilter $filter -Properties name
                    $properties = @{
                        Account = $account
                        Description = $useraccount.description
                    }
                }
                catch {
                    $properties = @{
                        Account = $null
                        Description = $null
                    
                    }
                }
                finally {
                    $object = New-Object -TypeName psobject -Property $properties
                    Write-Output $object
                }
            }
        }

        END {}
    }

Get-EmptyDescriptionInfo
