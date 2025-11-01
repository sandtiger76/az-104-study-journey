## Step 1: User & Group Creation

---
## Table of Contents

- [Overview](#1-user--group-creation-overview)
- [Table of Groups & Users](#2-user--group-creation-summary)
- [User & Group creation using Azure Portal](#3-user--group-creation-using-azure-portal)
- [User & Group creation using Azure CLI](#4-user--group-creation-using-azure-cli)
- [Automating User & Group Creation with Azure CLI (Linux Bash Scripts)](#automating-user--group-creation-with-azure-cli-linux-bash-scripts)


---
## 1. User & Group Creation Overview

In this step of the **Identity and Governance** section of the AZ-104 study journey, we focus on creating users and groups using tools that are most relevant for the exam.\
The goal is to gain hands-on experience with identity management in Azure Active Directory (Azure AD) using a variety of tools that are commonly referenced in the AZ-104 exam.

To make the learning process engaging and memorable, we use characters from the Harry Potter universe as our example users.\
Each user is assigned a role, group, and additional metadata to simulate real-world scenarios.

We are using the following tools for user and group creation:

- **Azure Portal** – for GUI-based management
- **Azure CLI** – for command-line automation
- **Azure PowerShell** – for scripting and automation
- **Bicep** – for Infrastructure as Code (IaC) deployments
The table below summarizes the users, their roles, groups, and the tool used for their creation.

---

## 2. User & Group Creation Summary

| Name                | Role           | Group               | House       | Additional Info                          | Tool Used     |
|---------------------|----------------|----------------------|-------------|-------------------------------------------|---------------|
| Harry Potter        | Student        | Gryffindor Students  | Gryffindor  | Dumbledore's Army, Quidditch Seeker       | Azure Portal  |
| Hermione Granger    | Student        | Gryffindor Students  | Gryffindor  | Prefect, Dumbledore's Army                | Azure CLI     |
| Ron Weasley         | Student        | Gryffindor Students  | Gryffindor  | Prefect, Dumbledore's Army                | Azure CLI     |
| Draco Malfoy        | Student        | Slytherin Students   | Slytherin   | Prefect, Inquisitorial Squad              | Azure CLI     |
| Luna Lovegood       | Student        | Ravenclaw Students   | Ravenclaw   | Dumbledore's Army                         | Azure CLI     |
| Neville Longbottom  | Student        | Gryffindor Students  | Gryffindor  | Dumbledore's Army                         | Azure CLI     |
| Ginny Weasley       | Student        | Gryffindor Students  | Gryffindor  | Quidditch Chaser, Dumbledore's Army       | Azure CLI     |
| Cho Chang           | Student        | Ravenclaw Students   | Ravenclaw   | Quidditch Seeker                          | Azure CLI     |
| Cedric Diggory      | Student        | Hufflepuff Students  | Hufflepuff  | Triwizard Champion                        | Azure CLI     |
| Severus Snape       | Teacher        | Hogwarts Staff       | Slytherin   | Potions Master, Head of Slytherin         | Azure CLI     |
| Minerva McGonagall  | Teacher        | Hogwarts Staff       | Gryffindor  | Transfiguration, Head of Gryffindor       | Azure CLI     |
| Albus Dumbledore    | Headmaster     | Hogwarts Staff       | Gryffindor  | Order of the Phoenix                      | Azure CLI     |
| Rubeus Hagrid       | Groundskeeper  | Hogwarts Staff       | Gryffindor  | Keeper of Keys and Grounds                | PowerShell    |
| Filius Flitwick     | Teacher        | Hogwarts Staff       | Ravenclaw   | Charms Professor, Head of Ravenclaw       | PowerShell    |
| Pomona Sprout       | Teacher        | Hogwarts Staff       | Hufflepuff  | Herbology, Head of Hufflepuff             | PowerShell    |
| Lord Voldemort      | Dark Wizard    | Death Eaters         | Slytherin   | Founder of Death Eaters                   | PowerShell    |
| Bellatrix Lestrange | Dark Witch     | Death Eaters         | Slytherin   | Loyal to Voldemort                        | Bicep         |
| Lucius Malfoy       | Dark Wizard    | Death Eaters         | Slytherin   | Draco's father                            | Bicep         |
| Sirius Black        | Order Member   | Order of the Phoenix | Gryffindor  | Animagus, Harry's godfather               | Bicep         |
| Remus Lupin         | Teacher        | Hogwarts Staff       | Gryffindor  | Werewolf, Order of the Phoenix            | Bicep         |
| Molly Weasley       | Parent         | Order of the Phoenix |             | Mother of Ron, fierce protector           | Bicep         |
| Arthur Weasley      | Ministry Worker| Order of the Phoenix |             | Works in Misuse of Muggle Artifacts       | Bicep         |

---
## 3. User & Group creation using Azure Portal

## 🎯 Objective

Create a user and a Microsoft 365 group in Microsoft Entra ID using the Azure Portal.\
This step demonstrates manual identity management tasks relevant to the AZ-104 exam.

## Create a User

To create a User in Azure Portal:

1. Navigate to **Azure Active Directory** > **Users** > **+ New user**.
2. Fill in the required details such as name, username, and password.
3. Click **Create**.

![User Creation - Harry Potter](https://github.com/sandtiger76/az-104-study-journey/blob/master/assets/screenshots/user_creation_harry_potter.png)

## Create a Group

To create a Group in Azure Portal:

1. Go to **Azure Active Directory** > **Groups** > **+ New group**.
2. Choose the group type, name it (e.g., Gryffindor Students), and assign members.
3. Click **Create**.

![Group Creation - Harry Potter](https://github.com/sandtiger76/az-104-study-journey/blob/master/assets/screenshots/group_creation_gryffindor_students.png)

✅ Why Azure Portal?

- **Visual clarity**: Ideal for understanding layout and options
- **Exam relevance**: AZ-104 expects familiarity with GUI-based tasks
- **Quick validation**: Easy to verify user and group creation
- **Real-world usage**: Often used by admins for one-off tasks

## 📝 Observations

- The user was created before the group existed, so no group was assigned initially.
- The group was created as a Microsoft 365 group, allowing assignment of an owner and members during creation.
- Harry Potter was assigned both as **owner** and **member** of the Gryffindor Students group.

---

## 4. User & Group creation using Azure CLI

🎯 Objective
Create users and groups in Microsoft Entra ID using Azure CLI. This step demonstrates command-line identity management tasks relevant to the AZ-104 exam.

---


✅ Step 1: Create Groups
Use the following commands to create groups representing Hogwarts houses and staff:
```
az ad group create --display-name "Slytherin Students" --mail-nickname "slytherinstudents"
az ad group create --display-name "Ravenclaw Students" --mail-nickname "ravenclawstudents"
az ad group create --display-name "Hufflepuff Students" --mail-nickname "hufflepuffstudents"
az ad group create --display-name "Hogwarts Staff" --mail-nickname "hogwartsstaff"Show more lines
```

✅ Step 2: Create Users
Use the following format to create users. Replace 'yourdomainname' with your actual domain name.
```
az ad user create \
  --display-name "Hermione Granger" \
  --user-principal-name "hermione.granger@yourdomainname" \
  --password "P@ssword1234" \
  --mail-nickname "hermionegranger"
```

Repeat this command for each user using your own domain name.
```
az ad user create --display-name "Ron Weasley" --user-principal-name "ron.weasley@yourdomainname" --password "P@ssword1234" --mail-nickname "ronweasley"
az ad user create --display-name "Draco Malfoy" --user-principal-name "draco.malfoy@yourdomainname" --password "P@ssword1234" --mail-nickname "dracomalfoy"
az ad user create --display-name "Luna Lovegood" --user-principal-name "luna.lovegood@yourdomainname" --password "P@ssword1234" --mail-nickname "lunalovegood"
az ad user create --display-name "Neville Longbottom" --user-principal-name "neville.longbottom@yourdomainname" --password "P@ssword1234" --mail-nickname "nevillelongbottom"
az ad user create --display-name "Ginny Weasley" --user-principal-name "ginny.weasley@yourdomainname" --password "P@ssword1234" --mail-nickname "ginnyweasley"
az ad user create --display-name "Cho Chang" --user-principal-name "cho.chang@yourdomainname" --password "P@ssword1234" --mail-nickname "chochang"
az ad user create --display-name "Cedric Diggory" --user-principal-name "cedric.diggory@yourdomainname" --password "P@ssword1234" --mail-nickname "cedricdiggory"
az ad user create --display-name "Severus Snape" --user-principal-name "severus.snape@yourdomainname" --password "P@ssword1234" --mail-nickname "severussnape"
az ad user create --display-name "Minerva McGonagall" --user-principal-name "minerva.mcgonagall@yourdomainname" --password "P@ssword1234" --mail-nickname "minervamcgonagall"
az ad user create --display-name "Albus Dumbledore" --user-principal-name "albus.dumbledore@yourdomainname" --password "P@ssword1234" --mail-nickname "albusdumbledore"
```

✅ Step 3: Add Users to Groups

To assign users to their respective groups, use the following format:
```
az ad group member add --group "<Group Name>" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

To Find the actual Object ID of the user, user the following command
```
az ad user show \
    --id <user-principal-name> \
    --query id -o tsv
```
Update 'yourdomainname' with your own domain for each user.
```
az ad user show --id hermione.granger@yourdomainname --query id -o tsv
az ad user show --id ron.weasley@yourdomainname --query id -o tsv
az ad user show --id draco.malfoy@yourdomainname --query id -o tsv
az ad user show --id luna.lovegood@yourdomainname --query id -o tsv
az ad user show --id neville.longbottom@yourdomainname --query id -o tsv
az ad user show --id ginny.weasley@yourdomainname --query id -o tsv
az ad user show --id cho.chang@yourdomainname --query id -o tsv
az ad user show --id cedric.diggory@yourdomainname --query id -o tsv
az ad user show --id severus.snape@yourdomainname --query id -o tsv
az ad user show --id minerva.mcgonagall@yourdomainname --query id -o tsv
az ad user show --id albus.dumbledore@yourdomainname --query id -o tsv
```

Gryffindor Students (Replace the member-id with the actual Object ID of the user)
```
az ad group member add --group "Gryffindor Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Hermione Granger
az ad group member add --group "Gryffindor Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Ron Weasley
az ad group member add --group "Gryffindor Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Neville Longbottom
az ad group member add --group "Gryffindor Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Ginny Weasley
```

Slytherin Students (Replace the member-id with the actual Object ID of the user)
```
az ad group member add --group "Slytherin Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Draco Malfoy
```

Hogwarts Staff (Replace the member-id with the actual Object ID of the user)
```
ad group member add --group "Hufflepuff Students" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Cedric DiggoryShow more lines
```

Hogwarts Staff (Replace the member-id with the actual Object ID of the user)
```
az ad group member add --group "Hogwarts Staff" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Severus Snape
az ad group member add --group "Hogwarts Staff" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Minerva McGonagall
az ad group member add --group "Hogwarts Staff" --member-id xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx  # Albus Dumbledore
```

### Automating User & Group Creation with Azure CLI (Linux Bash Scripts)
Automated Scripts to streamline the proces.\
When using the scripts, remember to update the domain name (if needed).


- [`delete-azure-cli-users.sh`](https://github.com/sandtiger76/az-104-study-journey/tree/master/scripts/delete-azure-cli-users.sh) - Delete Azure Users
- [`create-azure-cli-users.sh`](https://github.com/sandtiger76/az-104-study-journey/tree/master/scripts/create-azure-cli-users.sh) - Create Azure Users
- [`delete-azure-cli-groups.sh`](https://github.com/sandtiger76/az-104-study-journey/tree/master/scripts/delete-azure-cli-groups.sh) - Delete Azure Groups
- [`create-azure-cli-groups.sh`](https://github.com/sandtiger76/az-104-study-journey/tree/master/scripts/create-azure-cli-groups.sh) - Create Azure Groups




✅ Why Azure CLI?

Scriptable: Ideal for automation and repeatable tasks.\
Exam relevance: AZ-104 expects familiarity with CLI-based operations.\
Efficient: Faster than GUI for bulk operations.\
Real-world usage: Common in DevOps and infrastructure-as-code workflows.


📝 Observations

Users were created with a consistent password for simplicity.\
Groups were created before assigning members.\
Object IDs were used to ensure accurate group membership assignment.



---

## 5. User & Group creation using PowerShell

Open PowerShell
```
pwsh
```
Connect to Microsoft Graph
```
Connect-MgGraph -Scopes "User.ReadWrite.All", "Group.ReadWrite.All"
```
Import the Required Module
```
Import-Module Microsoft.Graph.Groups
```

Create Resource Groups Named After Their Groups (subscription dependant)
```
New-AzResourceGroup -Name "HogwartsStaff-RG" -Location "UK South"
New-AzResourceGroup -Name "DeathEaters-RG" -Location "UK South"
```

Secure Password Setup - Azure AD requires passwords to be passed as a SecureString.\
Use the following command:
```
$securePassword = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force
```
Convert plain text password to SecureString
```
$securePassword = ConvertTo-SecureString "P@ssword123!" -AsPlainText -Force
```
Create the user
```
New-AzADUser -DisplayName "Rubeus Hagrid" `
             -UserPrincipalName "rubeus.hagrid@yourdomain" `
             -Password $securePassword `
             -MailNickname "rubeushagrid" `
             -AccountEnabled $true
```

Assign Roles to Users  (subscription dependant)
```
New-AzRoleAssignment -ObjectId "<Hagrid's ObjectId>" `
                     -RoleDefinitionName "Reader" `
                     -Scope "/subscriptions/<your-subscription-id>/resourceGroups/HogwartsStaff-RG"
```


---
