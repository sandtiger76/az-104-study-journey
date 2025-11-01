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

---
## Optional - SSH Key Management

### SSH Key File

*   **Filename:** `<key-file-name>.pem`
*   **Location:** `<path-to-key-file>`

### Upload SSH Key to Azure Key Vault

#### Key Vault Details

*   **Name:** `<key-vault-name>`
*   **Location:** `<region>`
*   **Resource Group:** `<resource-group-name>`

#### CLI Command to Upload Key

```bash
az keyvault secret set
  --vault-name <key-vault-name>
  --name <secret-name>
  --value "$(cat <path-to-key-file>)"
```

### Role Assignment for Access

#### Steps to Assign Role

1.  Get the current signed-in user:
    ```bash
    az account show --query user.name
    ```

2.  Get the user's object ID:
    ```bash
    az ad signed-in-user show --query objectId
    ```

3.  Assign the **Key Vault Secrets Officer** role:
    ```bash
    az role assignment create
      --assignee <object-id>
      --role "Key Vault Secrets Officer"
      --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group-name>/providers/Microsoft.KeyVault/vaults/<key-vault-name>"
    ```

4.  Upload the SSH key as a secret:
    ```bash
    az keyvault secret set
      --vault-name <key-vault-name>
      --name <secret-name>
      --value "$(cat <path-to-key-file>)"
    ```

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
