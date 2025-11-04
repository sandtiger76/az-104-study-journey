It looks like there was an issue generating the file directly, but I can still provide you with the full Markdown content here. You can copy and save it as a `.md` file (e.g., `azure_user_management.md`) for future use.

***

````markdown
# Azure CLI User Management Guide

This document provides a quick reference for managing users in Azure Active Directory (Azure AD) using the Azure Command-Line Interface (Azure CLI).

## Prerequisites

- Azure CLI installed: Install Azure CLI
- Logged in to your Azure account:
  ```bash
  az login
````

*   Set the correct subscription (if needed):
    ```bash
    az account set --subscription "<subscription-name-or-id>"
    ```

***

## 1. Create a User

```bash
az ad user create \
  --display-name "John Doe" \
  --user-principal-name johndoe@yourdomain.com \
  --password "StrongPassword123!" \
  --force-change-password-next-login true \
  --mail-nickname johndoe
```

### Parameters:

*   `--display-name`: Full name of the user.
*   `--user-principal-name`: The user's login name (must be unique).
*   `--password`: Initial password.
*   `--force-change-password-next-login`: Forces the user to change password on first login.
*   `--mail-nickname`: Alias for the user.

***

## 2. Delete a User

```bash
az ad user delete --id johndoe@yourdomain.com
```

### Parameters:

*   `--id`: The user's UPN or object ID.

***

## 3. Update/Modify a User

To update user properties such as display name or usage location:

```bash
az ad user update \
  --id johndoe@yourdomain.com \
  --display-name "Johnathan Doe" \
  --usage-location "US"
```

### Common Updatable Fields:

*   `--display-name`
*   `--usage-location`
*   `--account-enabled` (true/false)

***

## 4. List Users

```bash
az ad user list --output table
```

To filter by name or email:

```bash
az ad user list --filter "startswith(displayName,'John')" --output table
```

***

## 5. Show User Details

```bash
az ad user show --id johndoe@yourdomain.com
```

***

## Notes

*   Always ensure you have the necessary permissions to manage users in Azure AD.
*   Consider using service principals or managed identities for automation.

***

## References

*   Azure CLI `az ad user` Docs

```

---

Would you like me to generate and download this as a `.md` file for you now?
```

