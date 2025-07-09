# Pipeline: Output of one command is input of another command.
# Command1 | Command2 | Command3

"Hello World" | ForEach-Object{$_.ToUpper()}
Get-Process | Where-Object{$_.Name -eq "Wininit"} | Select-Object Id, Name
Get-Service | Where-Object{$_.Status -eq "Running"}
Get-ChildItem -Path "C:\Users\ravic\Downloads" | Where-Object{$_.Length -gt 100MB}
