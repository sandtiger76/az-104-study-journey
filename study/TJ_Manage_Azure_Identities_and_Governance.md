# Manage Azure Identities and Governance (AZ-104)

### “Identity First, Access Next.”

Identity First → Enable Managed Identity on the resource (VM, Function, etc.).
Access Next → Assign RBAC role to that identity on the target resource (Resource Group, Storage, etc.).

If you see a question about a resource needing to manage other resources:

Enable Managed Identity.
Grant permissions via RBAC.



```mermaid
flowchart TD
    A[TD-VM1 🐬 <br/> Enable Managed Identity] --> B["Assign RBAC Role <br/> (Contributor")]
    B --> C[TD-RG1 🌊 <br/> Resource Group]
```

