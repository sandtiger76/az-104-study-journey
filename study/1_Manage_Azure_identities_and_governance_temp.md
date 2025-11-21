## 1.1 Manage Microsoft Entra ID users and groups

### Create users and groups

The first thing we want to learn about is creating users and groups.
The three different types of users are: cloud, hybrid, and guest.
You need to know what they are, when you would use them, and all of that.
Be aware of the Entra portal: entra.microsoft.com. Get to know that one as well.

### Manage user and group properties

Interpret access management.
Be aware of your manage and user group properties.

### Manage licenses in Microsoft Entra ID

Entra has licenses. Know the difference between these licenses.
When we think about PIM and identity protection, that means you’ll need a P2 license.
Self-service password reset means you need a P1 license.

### Manage external users

Know external users. When you invite a guest, what happens with that guest account?
How do you invite a guest? What is considered a guest?
Anybody that’s not part of your tenant is a guest.
You’ll see questions where they might ask you about giving a customer access—know that you invite them.
Once you invite those guests, how do you manage them?

[### Lab 01: Manage Microsoft Entra ID Identities](https://github.com/sandtiger76/az-104-study-journey/blob/main/labs/Instructions/Labs/LAB_01-Manage_Entra_ID_Identities.md)

### Configure self-service password reset

Finally, be aware of the self-service password reset.
Requires a P1 license (not P2—hint, trick question).


## 1.2 Manage access to Azure resources

### Manage built-in Azure roles

Know the built-in roles: User Access Administrator, Contributor, and Owner.
These are the three roles you’ll see on the exam.
Understand scenarios: if Bob needs to create something, does he need Owner or Contributor?
If he needs to delete or give someone else access, know the differences.
Be aware that there are custom roles you can create using JSON templates.

### Assign roles at different scopes

One of the big ones: scoping. Also called hierarchy.
Know at what levels you can scope permissions: management group, subscription, resource group, or role.
Scoping applies to permissions and policies.
All scopes are inheritable, and you cannot break inheritance.

### Interpret access assignments

Interpret access management.
Know the difference between Entra roles (administrator-type roles) and Azure roles (resource-type roles).
Be aware of scoping for both.


## 1.3 Manage Azure subscriptions and governance

### Implement and manage Azure Policy

Policies are about scoping.
Know the difference between a policy and an initiative definition:

Policy = single
Initiative definition = grouping of policies


These show up in governance and compliance questions.

### Configure resource locks

Two resource locks: Delete and ReadOnly.
Know what happens with each.

### Apply and manage tags on resources

Be aware of tagging.
Tagging is critical for organization and metadata.

### Manage resource groups

Resource groups are like containers.
They cannot be nested—Azure has a flat structure.
All resources must be part of a resource group.
You can move resources between resource groups.
Resource groups can span multiple regions.

### Manage subscriptions

Subscriptions are your billing capability.
Know the different types of subscriptions and when to use them.
Without a subscription, you cannot build a resource.

### Manage costs by using alerts, budgets, and Advisor recommendations

Understand cost optimization tools.
You might get questions about creating a budget—part of cost management.

### Configure management groups

Management groups are for managing multiple subscriptions.
Great for security and policy capability.
Would you use a management group for one subscription? No.
