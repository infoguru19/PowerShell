$vmNames = @("vm-dev-01", "vm-dev-02", "vm-dev-03")  # Replace with your VM names
$resourceGroup = "DevResourceGroup"                 # Replace with your RG

foreach ($vm in $vmNames) {
    Start-AzVM -ResourceGroupName $resourceGroup -Name $vm -ErrorAction Continue
}