## Infrastructure as Code in Azure: VM Deployment via CLI, PowerShell, ARM JSON & Bicep

---
### Create a Resource Group & Deploy a VM using Azure CLI

**Create resource group**
```bash
az group create --name TD-RG1 --location "UK South"
```

**Create VM with Standard B1s, Standard HDD, Ubuntu LTS**
```bash
az vm create \
  --resource-group TD-RG1 \
  --name TD-VM1 \
  --image Ubuntu2204 \
  --size Standard_B1s \
  --admin-username azureuser \
  --generate-ssh-keys \
  --storage-sku Standard_LRS \
  --public-ip-address ""
```

**Delete the entire resource group and all resources inside**
```bash
az group delete --name TD-RG1 --yes --no-wait  
```
  
---

### PowerShell

**Run PowerShell:**
```bash
pwsh
```

**Log in to Azure PowerShell:**
```bash
Connect-AzAccount
```

**Delete the resource group**
```bash
Remove-AzResourceGroup -Name "TD-RG1" -Force
```

**Create the resource group**
```bash
New-AzResourceGroup -Name "TD-RG1" -Location "UK South"
```

**Create VM with Standard B1s, Standard HDD, Ubuntu LTS**
```bash
az vm create `
  --resource-group TD-RG1 `
  --name TD-VM1 `
  --image Ubuntu2204 `
  --size Standard_B1s `
  --admin-username azureuser `
  --generate-ssh-keys `
  --storage-sku Standard_LRS `
  --public-ip-address ""
  ```

---

### ARM JSON Template (vm-template.json):

**create template with following code**
```bash
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {
    "vmName": { "type": "string", "defaultValue": "TD-VM1" },
    "adminUsername": { "type": "string", "defaultValue": "azureuser" },
    "sshKeyData": { "type": "string" }
  },
  "resources": [
    {
      "type": "Microsoft.Network/virtualNetworks",
      "apiVersion": "2024-07-01",
      "name": "[concat(parameters('vmName'), '-vnet')]",
      "location": "uksouth",
      "properties": {
        "addressSpace": { "addressPrefixes": [ "10.0.0.0/16" ] },
        "subnets": [
          { "name": "default", "properties": { "addressPrefix": "10.0.0.0/24" } }
        ]
      }
    },
    {
      "type": "Microsoft.Network/networkInterfaces",
      "apiVersion": "2024-07-01",
      "name": "[concat(parameters('vmName'), '-nic')]",
      "location": "uksouth",
      "dependsOn": [
        "[concat('Microsoft.Network/virtualNetworks/', parameters('vmName'), '-vnet')]"
      ],
      "properties": {
        "ipConfigurations": [
          {
            "name": "ipconfig1",
            "properties": {
              "subnet": {
                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', concat(parameters('vmName'), '-vnet'), 'default')]"
              },
              "privateIPAllocationMethod": "Dynamic"
            }
          }
        ]
      }
    },
    {
      "type": "Microsoft.Compute/virtualMachines",
      "apiVersion": "2024-07-01",
      "name": "[parameters('vmName')]",
      "location": "uksouth",
      "dependsOn": [
        "[concat('Microsoft.Network/networkInterfaces/', parameters('vmName'), '-nic')]"
      ],
      "properties": {
        "hardwareProfile": { "vmSize": "Standard_B1s" },
        "storageProfile": {
          "imageReference": {
            "publisher": "Canonical",
            "offer": "UbuntuServer",
            "sku": "16_04-lts-gen2",
            "version": "latest"
          },
          "osDisk": {
            "createOption": "FromImage",
            "managedDisk": { "storageAccountType": "Standard_LRS" },
            "diskSizeGB": 30
          }
        },
        "osProfile": {
          "computerName": "[parameters('vmName')]",
          "adminUsername": "[parameters('adminUsername')]",
          "linuxConfiguration": {
            "disablePasswordAuthentication": true,
            "ssh": {
              "publicKeys": [
                {
                  "path": "/home/azureuser/.ssh/authorized_keys",
                  "keyData": "[parameters('sshKeyData')]"
                }
              ]
            }
          }
        },
        "networkProfile": {
          "networkInterfaces": [
            {
              "id": "[resourceId('Microsoft.Network/networkInterfaces', concat(parameters('vmName'), '-nic'))]"
            }
          ]
        }
      }
    }
  ]
}
```

---
### Deploy ARM JSON template with Azure CLI

**Create resource group with Azure CLI**
```bash
az group create --name TD-RG1 --location "UK South"
```

**Deploy ARM JSON template with Azure CLI**
```bash
az deployment group create \
  --resource-group TD-RG1 \
  --template-file vm-template.json \
  --parameters sshKeyData="$(cat ~/.ssh/id_rsa.pub)"
  ```

**Delete the entire resource group and all resources inside**
```bash
az group delete --name TD-RG1 --yes --no-wait
```

---

##### Deploy ARM JSON template with Powershell

**Create the resource group**
```bash
New-AzResourceGroup -Name "TD-RG1" -Location "UK South"
```

**Deploy VM with ARM JSON template**
```bash
New-AzResourceGroupDeployment `
  -ResourceGroupName "TD-RG1" `
  -TemplateFile "vm-template.json" `
  -sshKeyData (Get-Content ~/.ssh/id_rsa.pub)
  ```

**Delete the resource group**
```bash
Remove-AzResourceGroup -Name "TD-RG1" -Force
```

---

### VM setup (TD‑VM1, Standard B1s, Ubuntu 16.04 Gen2 in UK South, NIC + VNet) written in Bicep:

**Create Bicep file vm-template.bicep**
```bash
param vmName string = 'TD-VM1'
param adminUsername string = 'azureuser'
param sshKeyData string

resource vnet 'Microsoft.Network/virtualNetworks@2024-07-01' = {
  name: '${vmName}-vnet'
  location: 'uksouth'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: '${vmName}-nic'
  location: 'uksouth'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: 'uksouth'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '16_04-lts-gen2'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        diskSizeGB: 30
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/azureuser/.ssh/authorized_keys'
              keyData: sshKeyData
            }
          ]
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
```

---

### Deploying Bicep with Azure Azure CLI

**Create resource group with Azure CLI**
```bash
az group create --name TD-RG1 --location "UK South"
```

**Deploying Bicep with Azure Azure CLI**
```bash
az deployment group create \
  --resource-group TD-RG1 \
  --template-file vm-template.bicep \
  --parameters sshKeyData="$(cat ~/.ssh/id_rsa.pub)"
```  
  
**Delete the entire resource group and all resources inside**
```bash
az group delete --name TD-RG1 --yes --no-wait
```

---

### Deploy Bicep template with Powershell

**Run PowerShell:**
```
pwsh
```

**Create the resource group**
```bash
New-AzResourceGroup -Name "TD-RG1" -Location "UK South"
```

**Deploy VM with Bicep template**
```bash
New-AzResourceGroupDeployment `
  -ResourceGroupName "TD-RG1" `
  -TemplateFile "vm-template.bicep" `
  -sshKeyData (Get-Content ~/.ssh/id_rsa.pub)
  ```

**Delete the resource group**
```bash
Remove-AzResourceGroup -Name "TD-RG1" -Force
```

---
