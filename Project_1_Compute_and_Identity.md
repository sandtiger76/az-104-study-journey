# Project 1: Azure Compute and Identity Management


## Table of Contents
- [Summary](#summary)
- [AZ-104 Modules Covered](#az-104-modules-covered)
- [Step 1: Resource Group and VM Creation](#step-1-resource-group-and-vm-creation)
- [Step-by-Step: Create a Virtual Machine in Azure Portal](#step-by-step-create-a-virtual-machine-in-azure-portal)
- [Optional - SSH Key Management](#optional---ssh-key-management)
- [Optional - CLI to create Virtual Machine (Alternative Method)](#optional---cli-to-create-virtual-machine-alternative-method)



## Summary
This project demonstrates how to deploy and manage a virtual machine in Azure, apply role-based access control (RBAC), enforce governance using Azure Policies, encrypt sensitive data, and monitor costs. All resources are themed around the Harry Potter universe to make learning fun and memorable.

## AZ-104 Modules Covered

| AZ-104 Module                                     | Notes |
|---------------------------------------------------|-------|
| **Manage Azure identities and governance**        | Group creation, RBAC, Key Vault |
| **Implement and manage storage**                  | OS disk used, data disk optional |
| **Deploy and manage Azure compute resources**     | VM creation, SSH, Bastion |
| **Configure and manage virtual networking**       | NSG and Bastion used |
| **Monitor and back up Azure resources**           | Cost Management next |
| **Manage Azure subscriptions and governance**     | Azure Policy and budget setup |


---

## Step 1: Resource Group and VM Creation

This table summarizes the configuration details of the Hogwarts-themed Azure resource group and virtual machine used in Project 1.


| Component               | Property              | Value                          |
|------------------------|-----------------------|--------------------------------|
| Resource Group         | Name                  | rg-hogwarts                    |
|                        | Location              | eastus                         |
| Virtual Machine        | Name                  | hogwarts-web-vm                |
|                        | OS                    | Ubuntu 24.04 LTS               |
|                        | Size                  | Standard_B1s (Free Tier Eligible) |
|                        | Admin Username        | hogwarts-web-vm-admin          |
|                        | Tags                  | owner: harry.potter            |
|                        |                       | house: gryffindor              |
|                        |                       | environment: dev               |
|                        |                       | project: az104-study           |
|                        |                       | theme: harrypotter             |
| VM Configuration       | Disk Size             | 30 GB                          |
|                        | OS Disk Type          | Standard_LRS                   |
|                        | SSH Access            | Public key authentication only |
|                        | Patch Settings        | Automatic by platform          |
|                        | VM Agent              | Enabled                        |


***

## Step-by-Step: Create a Virtual Machine in Azure Portal

### 1.1 Navigate to VM Creation

Go to **Azure Portal** > **Virtual Machines** > **Create**.

### 1.2 Configure Basic Settings

Select:
   *   **Subscription**
   *   **Resource Group**
   *   **Region**
   *   **VM Size** (e.g., Standard\_B1s for free tier)
   *   **Operating System** (Windows or Linux)

### 1.3 Set Administrator Credentials

Choose one of the following:
   *   **Username and Password**
   *   **SSH Public Key**

### 1.4 Add a Data Disk (Optional)

During VM creation:
   *   Choose **Create a new disk** > Select **None**.
   *   Alternatively, select **Storage Blob** to reuse disks from outside Azure or upload custom configurations.

### 1.5 Configure Networking

   *   Assign a **Static Private IP** via the **Advanced Networking** section.
   *   Choose a **Network Security Group (NSG)** option:
   *   **None**: Use if managing NIC setup manually or attaching an existing NIC.
   *   **Basic**: Suitable for quick test environments or small-scale apps.
   *   **Advanced**: Ideal for production workloads or custom network setups.

### 1.6 Finalize and Deploy

Click **Review + Create**.
After validation, click **Create** to deploy the VM.

### 1.7 Download SSH Private Key

If using SSH authentication, download the private key securely and store it (e.g., in Azure Key Vault).


***

## Optional - CLI to create Virtual Machine (Alternative Method)

```
az vm create
  --resource-group rg-hogwarts
  --name hogwarts-web-vm
  --image UbuntuLTS
  --size Standard_B1s
  --admin-username hogwarts-web-vm-admin
  --ssh-key-values ~/.ssh/id_rsa.pub
  --tags owner=harry.potter house=gryffindor environment=dev project=az104-study theme=harrypotter
```
***

## 🛡️ Step 2: Identity and Access Management

### 🧙 Step 2.1: Create the Key Vault
🔧 Portal Instructions:

Go to Azure Portal > Key Vaults > Create.
Use the following settings:

Name: vault-of-secrets
Resource Group: rg-hogwarts
Region: Same as your VM (eastus)


Click Review + Create, then Create.

cli command:
```bash
az keyvault create \
  --name vault-of-secrets \
  --resource-group rg-hogwarts \
  --location eastus
```

### 🧙 Step 2.2: Create an Entra ID Group
🔧 Portal Instructions:

Go to Microsoft Entra ID > Groups > New Group.
Use the following settings:

Group Type: Security
Group Name: OrderOfPhoenix
Description: "Admins of Hogwarts resources"
Membership Type: Assigned
Members: Add yourself


Click Create.

CLI alternative:
```bash
az ad group create \
  --display-name "OrderOfPhoenix" \
  --mail-nickname "OrderOfPhoenix"
```

### 🧙 Step 2.3: Assign Key Vault Role to Group
🔧 Portal Instructions:

Go to vault-of-secrets > Access Control (IAM) > Add Role Assignment.
Role: Key Vault Administrator
Assign to: OrderOfPhoenix
Click Review + Assign

CLI alternative:
```bash
az role assignment create \
  --assignee <group-object-id> \
  --role "Key Vault Administrator" \
  --scope "/subscriptions/<subscription-id>/resourceGroups/rg-hogwarts/providers/Microsoft.KeyVault/vaults/vault-of-secrets"
```

### 🧙 Step 2.4: Upload SSH Key to Key Vault
Assuming you have a .pem or .pub file, here’s the CLI command:
```bash
az keyvault secret set \
  --vault-name vault-of-secrets \
  --name hogwarts-ssh-key \
  --value "$(cat ~/.ssh/id_rsa.pub)"
```

### 🧙 Step 2.5: Assign VM Role to Group
🔧 Portal Instructions:

Go to hogwarts-web-vm > Access Control (IAM) > Add Role Assignment
Role: Virtual Machine Contributor
Assign to: OrderOfPhoenix
Click Review + Assign

CLI alternative:

```bash
az role assignment create \
  --assignee <group-object-id> \
  --role "Virtual Machine Contributor" \
  --scope "/subscriptions/<subscription-id>/resourceGroups/rg-hogwarts/providers/Microsoft.Compute/virtualMachines/hogwarts-web-vm"
```

***

## 🧪 Step 3: SSH Access to VM

If public IP is assigned:

```bash
az vm list-ip-addresses \
  --name hogwarts-web-vm \
  --resource-group rg-hogwarts \
  --query "[].virtualMachine.network.publicIpAddresses[].ipAddress" \
  --output tsv
```

Then connect:

```bash
ssh -i ~/.ssh/id_rsa hogwarts-web-vm-admin@<VM_PUBLIC_IP>
```

***

## 📎 Appendix: Retrieving Subscription ID and Object ID

### 🔍 Get Subscription ID

```bash
az account show --query id --output tsv
```

### 🔍 Get Your Object ID

```bash
az ad signed-in-user show --query objectId --output tsv
```

### 🔍 Get Group Object ID

```bash
az ad group show --group "OrderOfPhoenix" --query objectId --output tsv
```

***

✅ Step 3: SSH into the VM
This step verifies secure access to the VM using SSH and confirms NSG rules.

🔧 CLI Commands

3.1 Get VM Public IP
```bash
az vm list-ip-addresses \
  --name hogwarts-web-vm \
  --resource-group rg-hogwarts \
  --query "[].virtualMachine.network.publicIpAddresses[].ipAddress" \
  --output tsv
```
3.2 SSH into the VM
```bash
ssh -i ~/.ssh/id_rsa hogwarts-web-vm-admin@<VM_PUBLIC_IP>
```
Replace <VM_PUBLIC_IP> with the IP from the previous command.

3.3 Test NSG Rules
Try accessing the IP in a browser:
```bash
http://<VM_PUBLIC_IP>
```

✅ Step 4: Apply Azure Policy
This step enforces governance using Azure Policy initiatives.

🔧 CLI Commands
4.1 Create Policy Initiative
```bash
az policy set-definition \
  --name hogwarts-policy-initiative \
  --display-name "Hogwarts Policy Initiative" \
  --description "Enforce tag inheritance and allowed resource types" \
  --definition-group-name "hogwarts-group" \
  --definitions '[{"policyDefinitionId":"/providers/Microsoft.Authorization/policyDefinitions/your-policy-id"}]' \
  --params '{ "allowedResourceTypes": { "value": ["Microsoft.Compute/virtualMachines"] } }'
```

Note: Replace your-policy-id with actual policy definition IDs.

4.2 Assign Initiative to Subscription
```bash
az policy set-definition \
az policy assignment create \
  --name hogwarts-policy-assignment \
  --display-name "Hogwarts Policy Assignment" \
  --scope "/subscriptions/<your-subscription-id>" \
  --policy-set-definition hogwarts-policy-initiative
```

✅ Step 5: Monitor and Manage Costs

🔧 CLI Commands

5.1 Create Budget
```bash
az consumption budget create \
  --amount 50 \
  --category cost \
  --name hogwarts-budget \
  --time-grain monthly \
  --start-date 2025-11-01 \
  --end-date 2026-11-01 \
  --notifications \
    '{"Actual_GreaterThan_50": {"enabled": true, "operator": "GreaterThan", "threshold": 50, "contactEmails": ["youremail@domain"]}}'
```

2. View Cost Analysis
```bash
az costmanagement query \
  --type ActualCost \
  --timeframe MonthToDate \
  --dataset '{"granularity":"Daily"}'
```

