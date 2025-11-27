
# ✅ PowerShell Summary & AZ-104 Cheat Sheet

### **Section 1: What is PowerShell?**
PowerShell is a **cross-platform automation and configuration tool** developed by Microsoft.  
It uses a **command-line shell** and a **scripting language** built on .NET, designed for:
- Automating administrative tasks
- Managing system configurations
- Working with objects instead of plain text (unlike traditional shells)

---

### **Section 2: How to Use PowerShell on Linux**
1. **Install PowerShell Core (`pwsh`)**:
   - On Ubuntu/Debian:
     ```bash
     sudo apt update
     sudo apt install -y powershell
     ```
   - On Fedora:
     ```bash
     sudo dnf install -y powershell
     ```
   - On Arch:
     ```bash
     sudo pacman -S powershell
     ```

2. **Run PowerShell**:
   ```bash
   pwsh
    ```
## Key Learnings from the Two Questions

### 1. Locate a Command in PowerShell

✅ Correct:
PowerShellGet-Command 'name of command'Show more lines

Why?
Get-Command finds cmdlets, functions, scripts, and executables available in your session.

**Examples:**
```bash
Get-Command Get*
Get-Command -Module Az*
Get-Command -Noun File*
```


### 2. Search for Commands Related to Files

✅ Correct:
PowerShellGet-Command -Noun File*Show more lines

Why?
PowerShell cmdlets follow Verb-Noun naming. Using -Noun File* matches all commands with nouns starting with "File" (e.g., File, FileSystem).


**Pro Tips**

Use Get-Help <cmdlet> 
Example:
```
Get-Help Get-Process
```

For full details, use:
```
Get-Help Get-Process -Full
```

Or for examples only:
```
Get-Help Get-Process -Examples
```

Combine filters with Get-Command
```
Get-Command -Verb Get -Noun File*
```


✅ In short:

PowerShell is powerful for automation and works on Linux via pwsh.
Use Get-Command to locate commands and filter by -Noun or -Verb for specific tasks.   


