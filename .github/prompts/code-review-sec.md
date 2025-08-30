---
mode: 'ask'
description: 'Perform a Terraform security and code quality review on the provided code.'
tools: ['runCommand']
---

Perform a Terraform security and code quality review:

* Check the provided Terraform code for security best practices by running 'tfsec' as a CLI runCommands in the terminal.
* For any critical security issues create a github issue on this projects repo on github.com with the issue title prefixed 🚨 [CRITICAL SECURITY].
