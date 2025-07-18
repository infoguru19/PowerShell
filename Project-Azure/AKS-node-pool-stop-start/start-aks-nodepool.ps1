param (
    [string] $resourceGroup = "myResourceGroup",
    [string] $aksName = "myAKSCluster",
    [int] $nodeCount = 1  # Set desired number
)

$nodePools = az aks nodepool list --resource-group $resourceGroup --cluster-name $aksName --query "[].name" -o tsv

foreach ($pool in $nodePools) {
    Write-Output "Scaling up node pool: $pool"
    az aks nodepool update --resource-group $resourceGroup --cluster-name $aksName --name $pool --node-count $nodeCount
}