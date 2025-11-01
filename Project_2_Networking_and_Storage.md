# Project 2: Azure Networking and Storage


In this project, we'll look at Azure with secure networking and storage spells.
We'll try to keep it fun by using a Harry Potter theme for the names, we will build:

- A **Virtual Network (VNet)** to isolate your magical creatures (resources)
- **Network Security Groups (NSGs)** as protective charms against dark forces (unauthorized access)
- A **Storage Account** as your enchanted vault for potions and artifacts
- All encrypted with unbreakable curses
- Automated with **ARM Templates** – like scripting your own *Patronus Charm* for repeatable magic

---

**Topics Covered:**
Virtual Networks, NSGs, Storage Accounts, Encryption, Protocols, ARM Templates
**Time Estimate:** ~0.75 hours (or the length of a Quidditch match)

**Scenario:**
The *Ministry of Magic* (your company) needs a secure vault for confidential spellbooks, isolated networks to protect web-facing owls from *Death Eaters*, enforced encryption to safeguard against curses, and templates to summon resources instantly without wand-waving every time.

---

## Resource Naming (Harry Potter Theme)

| Resource Type         | Name Example                     | Notes |
|-----------------------|----------------------------------|-------|
| Resource Group        | `HogwartsResources`              | Create if not exists |
| Virtual Network       | `ForbiddenForestVNet`            | |
| Subnet (Web)          | `GryffindorWeb`                  | Public-facing |
| Subnet (Database)     | `SlytherinDatabase`              | Private + Storage endpoint |
| NSG                   | `PatronusNSG`                    | |
| Storage Account       | `hogwartsvault123`               | **Globally unique**, lowercase, no hyphens |

> Replace `hogwartsvault123` with your own unique name!

---

## Step 1: Create a Virtual Network (VNet) – Summon the Forbidden Forest

This step creates your VNet with two subnets for isolation. The `SlytherinDatabase` subnet will have **service endpoints** for secure storage access.

### Azure Portal Instructions

1. Go to **Azure Portal** > Search **"Virtual Networks"** > **Create**
2. **Basics tab**:
   - Resource Group: `HogwartsResources`
   - Name: `ForbiddenForestVNet`
   - Region: e.g., **East US**
3. **IP Addresses tab**:
   - Address space: `10.0.0.0/16`
   - **Add subnet**:
     - Name: `SlytherinDatabase`
     - Address range: `10.0.0.0/27`
     - **Service Endpoints**: `Microsoft.Storage`
   - **Add another subnet**:
     - Name: `GryffindorWeb`
     - Address range: `10.0.1.0/27`
4. **Review + Create** > **Create**

> Subnets in the same VNet communicate by default – no extra spells needed!

### Azure CLI Alternative

```bash
# Create VNet with first subnet
az network vnet create \
  --resource-group HogwartsResources \
  --name ForbiddenForestVNet \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name SlytherinDatabase \
  --subnet-prefix 10.0.0.0/27

# Add Storage service endpoint to database subnet
az network vnet subnet update \
  --resource-group HogwartsResources \
  --vnet-name ForbiddenForestVNet \
  --name SlytherinDatabase \
  --service-endpoints Microsoft.Storage

# Create web subnet
az network vnet subnet create \
  --resource-group HogwartsResources \
  --vnet-name ForbiddenForestVNet \
  --name GryffindorWeb \
  --address-prefixes 10.0.1.0/27

Step 2: Deploy a Network Security Group (NSG) – Cast Protective Charms
NSGs act like your Patronus, controlling inbound/outbound traffic. We’ll allow HTTPS and block everything else.
Azure Portal Instructions

Search "Network Security Groups" > Create
Basics:

Name: PatronusNSG
Resource Group: HogwartsResources
Region: Same as VNet


Review + Create > Create
Go to PatronusNSG > Subnets > Associate
→ VNet: ForbiddenForestVNet → Subnet: GryffindorWeb
Inbound security rules > Add:

Allow HTTPS:

Priority: 100
Service: HTTPS (port 443)
Action: Allow
Name: AllowHTTPS


Deny All Else:

Priority: 4096
Destination port: *
Action: Deny
Name: DenyAllInbound






Add SSH/RDP rules if needed (e.g., port 22/3389, priority 200)

Azure CLI Alternative
bash# Create NSG
az network nsg create \
  --resource-group HogwartsResources \
  --name PatronusNSG

# Associate with web subnet
az network vnet subnet update \
  --resource-group HogwartsResources \
  --vnet-name ForbiddenForestVNet \
  --name GryffindorWeb \
  --network-security-group PatronusNSG

# Allow HTTPS
az network nsg rule create \
  --resource-group HogwartsResources \
  --nsg-name PatronusNSG \
  --name AllowHTTPS \
  --priority 100 \
  --source-address-prefixes '*' \
  --destination-port-ranges 443 \
  --access Allow \
  --protocol Tcp

# Deny all other inbound
az network nsg rule create \
  --resource-group HogwartsResources \
  --nsg-name PatronusNSG \
  --name DenyAllInbound \
  --priority 4096 \
  --source-address-prefixes '*' \
  --destination-port-ranges '*' \
  --access Deny \
  --protocol '*'

Step 3: Create and Configure a Storage Account – Enchant the Vault
Your storage account is Gringotts Vault #713: secure, replicated, and encrypted.
Azure Portal Instructions

Search "Storage Accounts" > Create
Basics:

Name: hogwartsvault123 (unique!)
Resource Group: HogwartsResources
Region: Same as VNet
Replication: LRS or GRS


Advanced:

Encryption: Microsoft-managed keys


Networking:

Connectivity method: Private endpoint
Public network access: Disabled
Add private endpoint:

VNet: ForbiddenForestVNet
Subnet: SlytherinDatabase
Integrate with private DNS zone




Review + Create > Create

Azure CLI Alternative
bashaz storage account create \
  --resource-group HogwartsResources \
  --name hogwartsvault123 \
  --location eastus \
  --sku Standard_LRS \
  --kind StorageV2 \
  --encryption-services blob \
  --public-network-access Disabled

# Create private endpoint
az network private-endpoint create \
  --resource-group HogwartsResources \
  --vnet-name ForbiddenForestVNet \
  --subnet SlytherinDatabase \
  --name HogwartsVaultEndpoint \
  --private-connection-resource-id $(az storage account show -n hogwartsvault123 -g HogwartsResources --query id -o tsv) \
  --group-id blob \
  --connection-name VaultConnection

Step 4: Deploy Using ARM Templates – Script Your Summoning Charm
ARM Templates = Pre-written spells for automation.
Azure Portal Instructions

Export Templates:

Go to ForbiddenForestVNet > Automation > Export template > Download
Go to hogwartsvault123 > Automation > Export template > Download


Create Template Spec:

Search "Template specs" > Create
Name: ForbiddenForestTemplate
Upload template.json


Deploy:

Go to your template spec > Deploy
Fill parameters > Review + Create



Azure CLI Alternative
bash# Deploy exported template (example)
az deployment group create \
  --resource-group HogwartsResources \
  --template-file template.json \
  --parameters @parameters.json

Combine VNet + Storage into one template for full automation!


Step 5: Test Access and Encryption – Verify the Protective Spells
Generate a SAS token (temporary Portkey) and test access.
Azure Portal Instructions

Go to hogwartsvault123 > Shared access signature
Select:

Allowed services: Blob
Resource types: Service, Container, Object
Permissions: Read, Write, Delete, List, Create


Generate SAS and connection string
Test with Azure Storage Explorer:

Download: Azure Storage Explorer
Connect > Use a shared access signature (SAS) URI
Paste Blob service SAS URL
Create container: spellbooks
Upload/download a file


Test with AzCopy:
bashazcopy copy "local-spell.txt" "https://hogwartsvault123.blob.core.windows.net/spellbooks/local-spell.txt?[SAS-TOKEN]"


Azure CLI Alternative
bash# Generate SAS
az storage account generate-sas \
  --account-name hogwartsvault123 \
  --services b \
  --resource-types sco \
  --permissions rwdlac \
  --expiry 2025-11-02T00:00Z

# Upload via AzCopy
azcopy copy "local-spell.txt" "https://hogwartsvault123.blob.core.windows.net/spellbooks/local-spell.txt?[SAS]"

Congratulations, Young Wizard!
You've fortified your Azure domain with:

Isolated subnets
Protective NSGs
Encrypted private storage
Automated deployments

Next Steps:

Take screenshots
Save CLI outputs
Push to your GitHub repo: az-104-study-journey


“After all this time? Always.” — Keep studying!
Onward to Project 3! 🧙‍♂️✨
