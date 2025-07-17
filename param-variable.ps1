param (
    [string] $resourceGroup = "MyRG",
    [string] $aksName = "myAKSCluster"
)

Write-Output "You are great: $resourceGroup"
Write-Output ("Hello: $($aksName)")
"my name is $($resourceGroup)"
