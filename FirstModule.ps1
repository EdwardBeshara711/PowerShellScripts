
function GetOSInfo {
    
    #  this allows for -verbose
    [CmdletBinding()]
    
    param (
        #this makes it mandatory to put int the -computername name
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$True,
            HelpMessage="The. Computer. Name"
            )]
            
            [Alias('Hostname','cn')]
            
            # this is a parameter for the function and the extra [] allows for multiple strings
            [string[]]$ComputerName 
            )
            
            BEGIN {}
            
            PROCESS {
                
                #this will go through each query for each computer name and run it once
                foreach ($Computer in $ComputerName) {
                    
                    # error catching
                    # we want the script to stop on the new cim session
                    #  error action stop will stop the script there if there are any errors
                    try {
                        #when using the -verbose param on this function this will display
                        Write-Verbose "Retrieving data from $computer"
                        
                        #creating a cim session so we dont have to connect to computer more than once
                        $session = New-CimSession -ComputerName $Computer -ErrorAction Stop
                        
                        $os = Get-CimInstance -ClassName win32_operatingsystem -CimSession $session
                        $cs = Get-CimInstance -ClassName win32_computersystem -CimSession $session
                        
                        #hashtable below for object
                        $properties = @{
                            Status = 'Connected'
                            ComputerName = $Computer
                            SPVersion = $os.ServicePackMajorVersion
                            OSVersion = $os.Version
                            Model = $cs.Model
                            Mfgr = $cs.Manufacturer
                        }
                    }
                    #this will still out put the object with null data if it cannot connect to a machine
                    catch {
                        
                        $properties = @{
                            Status = 'Cannot Connect'
                            ComputerName = $Computer
                            SPVersion = $null
                            OSVersion = $null
                            Model = $null
                            Mfgr = $null
                        }
                    }
                    # this will run after try if there is no error , or it will run after catch if there is a error
                    finally {
                        #creating a variable here lets you manipulate this object before you output
                        $obj = New-Object -TypeName psobject -Property $properties
                        
                        #output object --- this is explicit so we can find where we are outputting
                        Write-Output $obj
                    }
                }
                
            }
            
            END {}
            
        }