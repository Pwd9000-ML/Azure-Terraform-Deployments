---
mode: 'ask'
description: 'Perform a Terraform security and code quality review on the provided code.'
tools: ['*']
---
Perform a Terraform security and code quality review:

* Check the provided Terraform code for security best practices from https://github.com/terraform-linters/tflint.
* Provide a summary of findings and suggestions for improvement.
* If you find any issues, suggest specific changes to the code.
* Validate all user inputs and sanitize data.
