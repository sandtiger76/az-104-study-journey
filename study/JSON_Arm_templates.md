# JSON Arm templates

## What is JSON?
JSON **(JavaScript Object Notation)** is a lightweight data-interchange format that uses human-readable text to transmit data objects. It is language-independent and a popular choice for transferring data between a server and a web application, as well as for configuration files and APIs. JSON's format is based on a subset of the JavaScript programming language and is easy for both humans to read and machines to parse. 

### Example:
```
{
  "name": "Joe",
  "age": 16,
  "hobbies": ["dance", "books"]
}
```

## What are JSON arm templates?
Azure Resource Manager (ARM) templates are JSON (JavaScript Object Notation) files used to define the infrastructure and configuration for Azure deployments. They enable an infrastructure-as-code approach, allowing organizations to repeatedly and reliably deploy Azure resources across different environments.

* **ARM templates** are **declarative** JSON files used to define and deploy Azure resources.

* **Azure Resource Manager** templates are **idempotent**. 
This means that if you run a template with no changes a second time.
Azure Resource Manager doesn't make any changes to the deployed resources.

#### Key Point: 
**Idempotency** ensures repeated deployments don’t duplicate or delete resources—they maintain the desired state.