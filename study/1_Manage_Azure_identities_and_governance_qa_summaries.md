# Manage Microsoft Entra ID users and groups QA Summaries

### Understand Microsoft Entra ID

✅ Key Points from Questions

* Restrict app access to your tenant → Configure Authentication/Authorization blade in Azure App Service and specify your Microsoft Entra tenant. 

* Entra ID P2 exclusive features → Identity Protection (risk-based sign-in detection, automated remediation) + Privileged Identity Management (PIM). 

* Difference between Entra ID and AD DS → Entra ID uses service principals for app management; AD DS uses GPOs and Kerberos.
* Detect irregular sign-ins → Use Identity Protection, not Conditional Access.
* Single tenant for multiple services → Enables centralized authentication and authorization.
* Limitation of Entra ID vs AD DS → No Group Policy Objects (GPOs).
* MFA availability:

* Free tier → Basic MFA via Security Defaults.
    P1 → MFA + Conditional Access.
    P2 → Adds Identity Protection + PIM.


* Feature unique to Entra ID → Self-service password reset (SSPR).
* Bridge on-prem AD DS with Entra ID → Microsoft Identity Manager (and Azure AD Connect for sync).


✅ Quick Comparison Cheat Sheet

| **Entra License**                                             | **Feature** |
| ------------------------------------------------------- | -------- | 
| Entra ID Free | Basic identity, limited MFA. |
| Entra ID P1 | Conditional Access, MFA, cloud app management. |
| Entra ID P2 | P1 + Identity Protection + PIM. |
| AD DS | Kerberos, GPOs, on-premises only. |
| Entra ID | OAuth/OpenID Connect, service principals, cloud-native. |

## Create, configure, and manage identities

