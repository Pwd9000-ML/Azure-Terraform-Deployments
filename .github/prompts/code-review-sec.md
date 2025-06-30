---
mode: 'ask'
description: 'Perform a Terraform security and code quality review on the provided code.'
tools: ['*']
---
Perform a Terraform security and code quality review:

* Check the provided Terraform code for security best practices.
* Ensure it adheres to the team's custom instructions.
* Use tools like `tflint` and `tfsec` to identify potential issues.
* Provide a summary of findings and suggestions for improvement.
* If you find any issues, suggest specific changes to the code.
* Validate all user inputs and sanitize data.