#finding computer with certain name

$name = "Windows*server*"

GET-ADComputer -Filter { OperatingSystem -Like $name } -Properties OperatingSystem,description |
  Select Name,OperatingSystem,description |
  sort-object -property name | ft

