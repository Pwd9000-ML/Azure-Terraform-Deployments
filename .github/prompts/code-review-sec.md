---
mode: 'agent'
description: 'Perform a Terraform security and code quality review on the provided code.'
tools: ['*']
---

Perform a Terraform security and code quality review:

* Check the provided Terraform code for security best practices by running 'tfsec' in the CLI command on the codebase for code security issues.
* Validate all user inputs and sanitize data.
* For any critical security issues create a github issue on my repo with the title prefixed 🚨 [CRITICAL SECURITY].
