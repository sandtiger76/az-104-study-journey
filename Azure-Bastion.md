# Azure Bastion setup

***

## ⚡ Summary
Azure Bastion is a managed service that provides secure access to your Azure virtual machines (VMs) via RDP or SSH without needing to expose them to the public internet.
To make the learning process engaging and memorable, we use the Harry Potter universe as our example Bastion.

---

## 🏰 Scenario
We need to find a way to connect to a VM without using a public IP.\
Azure Bastion provides a secure gateway for SSH/RDP directly through the Azure Portal.

---

## ✅ Steps Performed

### 1. Created Bastion Subnet
Azure Bastion requires a dedicated subnet named `AzureBastionSubnet` in the same VNet as the VM.

```bash
RG="rg-hogwarts"
LOCATION="eastus"
BASTION_NAME="hogwarts-bastion"
VNET_NAME="vnet-eastus"
SUBNET_NAME="AzureBastionSubnet"
PUBLIC_IP_NAME="hogwarts-bastion-ip"

# Create Bastion subnet
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name $VNET_NAME \
  --name $SUBNET_NAME \
  --address-prefixes 172.16.2.0/27
````

***

### 2. Created Public IP for Bastion

Bastion needs a **Standard SKU Public IP**.

```bash
az network public-ip create \
  --resource-group $RG \
  --name $PUBLIC_IP_NAME \
  --sku Standard \
  --location $LOCATION
```

***

### 3. Created Bastion Host

Finally, we deployed the Bastion host in the same VNet.

```bash
az network bastion create \
  --name $BASTION_NAME \
  --resource-group $RG \
  --location $LOCATION \
  --vnet-name $VNET_NAME \
  --public-ip-address $PUBLIC_IP_NAME
```

***

### 4. Verified Bastion Status

```bash
az network bastion show \
  --name $BASTION_NAME \
  --resource-group $RG \
  --query "{Name:name, Status:provisioningState}"
```

Expected output:

```json
{
  "Name": "hogwarts-bastion",
  "Status": "Succeeded"
}
```

***

### 5. Connected to VM via Bastion

*   Go to **Azure Portal → VM → Connect → Bastion**.
*   Enter:
    *   Username: `hogwarts-web-vm-admin`
    *   SSH private key (downloaded during VM creation).
*   Click **Connect** — and you’re inside Hogwarts VM securely!

***

## 🧙 Lessons Learned

*   Bastion is like a magical gateway: secure, no public IP needed.
*   Requires **Standard SKU Public IP** (not free, but minimal cost if used briefly).
*   Always create `AzureBastionSubnet` with `/27` prefix.

***




```
