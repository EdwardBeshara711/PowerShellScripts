
function Get-Servers {

        [CmdletBinding()]

        Param (
                                   
        )

        BEGIN {}

        PROCESS {
            
            $filter = @{
                Filter = "OperatingSystem -Like 'Windows*Server*'"
            }

            $serverList = GET-ADComputer @filter -Properties Name,OperatingSystem,description | Select-Object Name,OperatingSystem,description | sort name

            foreach ($server in $serverList) {

                try {
                    

                    $properties = @{
                        ServerName = $server.name
                        OperatingSystem = ($server.OperatingSystem).Replace("Windows Server","")
                        Description = $server.description
                    }
                    
                }
                catch {
                    
                    $properties = @{
                        ServerName = $null
                        OperatingSystem = $null
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

