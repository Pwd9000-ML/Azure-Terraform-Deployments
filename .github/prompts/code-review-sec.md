---
mode: 'ask'
description: 'Perform a Terraform security and code quality review on the provided code.'
tools: ['*']
---
Perform a Terraform security and code quality review:

* Check the provided Terraform code in my #codebase for security best practices by running 'tfsec' in the CLI command on the codebase and 'tflint' for code quality and analyse the results.
* Provide a summary of findings and suggestions for improvement.
* If you find any issues, suggest specific changes to the code.
* Validate all user inputs and sanitize data.
* For any high security issues create a github issue on my repo marked as [HIGH SECURITY ALERT] in the title.
