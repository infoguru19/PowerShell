# ✅ Step-by-Step Guide
## 🎯 Prerequisites
- Azure subscription
- Resource group containing the Dev VMs
- List of VM names (assume these are known)
- Owner or Contributor access to manage Automation Accounts

## 🔧 Step 1: Create an Automation Account
Go to the Azure Portal.
Search for `Automation Accounts` and click `Create`.

**Fill in:**
- Name: DevVM-AutoManage
- Resource Group: Select your RG
- Region: Choose your region
- Leave defaults and click Create

## 🔐 Step 2: Assign a Managed Identity to Automation Account
- Open the `Automation Account` → go to `Identity`.
- Enable System Assigned Identity → Save.
- Go to the Resource Group or individual VMs → Access Control (IAM).
### Add Role Assignment:
Role: Virtual Machine Contributor
Assign to: Automation Account’s System Assigned Identity

## 📜 Step 3: Create PowerShell Runbooks
### 3.1 Start VM Runbook
In Automation Account → Runbooks → Create a Runbook

- Name: Start-DevVMs

- Type: PowerShell

Paste this code:

```powershell
$vmNames = @("vm-dev-01", "vm-dev-02", "vm-dev-03")  # Replace with your VM names
$resourceGroup = "DevResourceGroup"                 # Replace with your RG

foreach ($vm in $vmNames) {
    Start-AzVM -ResourceGroupName $resourceGroup -Name $vm -ErrorAction Continue
}
```
Save → Publish the runbook.

### 3.2 Stop VM Runbook
Create another Runbook → Name: Stop-DevVMs

Paste this code:

``` powershell
$vmNames = @("vm-dev-01", "vm-dev-02", "vm-dev-03")  # Replace with your VM names
$resourceGroup = "DevResourceGroup"                 # Replace with your RG

foreach ($vm in $vmNames) {
    Stop-AzVM -ResourceGroupName $resourceGroup -Name $vm -Force -ErrorAction Continue
}
```
Save → Publish the runbook.

### 🕒 Step 4: Schedule the Runbooks
**4.1 Create Schedule to Start VMs at 8:00 A.M**
Go to `Start-DevVMs` runbook → `Schedules` → `Add` a schedule

- Create a new schedule:
- Name: StartDevVMs-Schedule
- Recurrence: Daily
Time: 08:00 A.M (in your time zone)
- Link it to the `Start-DevVMs` runbook.

**4.2 Create Schedule to Stop VMs at 6:00 P.M**
Go to Stop-DevVMs runbook → Schedules → Add a schedule
- Create a new schedule:
- Name: StopDevVMs-Schedule
- Recurrence: Daily
Time: 06:00 P.M
- Link it to the Stop-DevVMs runbook.

### ✅ Final Checklist
1. Automation Account created
2.  Managed Identity has Virtual Machine Contributor access
3.  Start/Stop runbooks are published
4.  Schedules linked to runbooks at correct times
5.  Time zone is correctly set

### Step: 5. ✅ Add Email Alerts for Runbook Success/Failure
We'll configure Azure Monitor Alerts on the Automation Account’s runbook jobs, which will trigger an email action group.

### 🔧 Step 1: Create an Action Group for Email
Go to Azure Portal → search "Action Groups" → click Create.

**Fill in:**

```
Subscription

Resource Group

Action Group Name: DevVM-Runbook-Alerts

Display Name: RunbookAlert

Under Notifications:

Click Add notification.

Name: EmailNotification

Type: Email

Enter your email address.

Click OK.

Click Review + Create.
```

### 🧠 Step 2: Create Alert Rules for Success and Failure
You’ll create two alert rules — one for failure, and optionally one for success.

🚨 Alert on Failure
Go to your Automation Account.

```
Go to Alerts → + New Alert Rule.

Scope: Select your Automation Account.

Condition: Click "Add condition"

Signal: Search "Job status"

Select "Job status (Microsoft.Automation/automationAccounts/jobs)"

Condition: Job Status equals Failed

Click Done

Action Group: Select the one you created earlier (DevVM-Runbook-Alerts)

Alert rule name: Alert-On-Runbook-Failure

Severity: Choose severity (e.g., Sev 2 or 3)

Enable Rule: Yes

Click Create
```

### ✅ (Optional) Alert on Success
Repeat the same steps, but in `Step 4`, set:

Condition: Job Status equals Completed

Alert rule name: Alert-On-Runbook-Success

📨 Result
You’ll now receive email notifications whenever:

The runbook fails

(Optional) The runbook succeeds

