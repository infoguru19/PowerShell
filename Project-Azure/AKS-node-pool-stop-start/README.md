# AKS Nodepool Stop Start
- To automatically stop and start an Azure Kubernetes Service (AKS) cluster at specific times (e.g., stop at 5 PM and start at 9 AM), you can schedule this using Azure Automation Account + Runbooks and optionally Logic Apps or Azure Functions for more control.

`⚠️ Note: Stopping and starting an AKS cluster in Azure doesn't mean powering it off (since AKS control plane is managed by Azure), but scaling node pools to 0 (stop) and scaling back to a desired count (start).`

# ✅ Step-by-step: Scheduled AKS Start/Stop using Automation Account
## 🔧 1. Create an Azure Automation Account
```
Go to Azure Portal → Automation Accounts → Create
Choose resource group, name, region
```

## 🔑 2. Assign Permissions to the Automation Account
Automation Account needs to manage AKS and VM Scale Sets:

```
Go to your AKS Resource Group → Access Control (IAM) → Add Role Assignment
Role: Contributor
Assign to: Automation Account’s Managed Identity
```

## 🧾 3. Create Runbooks for Start and Stop
### 🛑 Stop-AKSCluster Runbook (PowerShell)
```powershell

param (
    [string] $resourceGroup = "myResourceGroup",
    [string] $aksName = "myAKSCluster"
)

$nodePools = az aks nodepool list --resource-group $resourceGroup --cluster-name $aksName --query "[].name" -o tsv

foreach ($pool in $nodePools) {
    Write-Output "Scaling down node pool: $pool"
    az aks nodepool update --resource-group $resourceGroup --cluster-name $aksName --name $pool --node-count 0
}
```
### ▶️ Start-AKSCluster Runbook (PowerShell)
```powershell
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
```
**🛠 Make sure az CLI is installed in Hybrid Worker or switch to AzureRM module and use ARM templates.**

## 🕐 4. Create Schedules
```
Go to Automation Account → Schedules:
Stop-AKSCluster Schedule → 5 PM (set timezone)
Start-AKSCluster Schedule → 9 AM
Attach each to its respective Runbook.
```

**🎯 Use azurerm_automation_schedule and azurerm_automation_runbook resources in Terraform to deploy everything as code.**

### 🧠 Summary
Task	Time	Action
Start	9 AM	Run PowerShell to scale up nodes
Stop	5 PM	Run PowerShell to scale down