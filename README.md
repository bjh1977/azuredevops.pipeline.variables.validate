
# Validate Azure Devops Variables

This extension checks the value of your variables and either warns or throws an error if they have not been fully-resolved.  This may happen if you reference a variable which has does not exist such as `Variable1: $(Variable2)` where `Variable2` does not exist.

# Azure DevOps Tasks

## Add task
You will find the new Tasks available under the Build orDeploy tab, or search for "variables validate".

### Parameters
- Azure Region - The region your instance is in. This can be taken from the start of your workspace URL (it must not contain spaces)
- Local Root Path - the path to your files, for example $(System.DefaultWorkingDirectory)/drop
- File Pattern - files to copy, examples *.* or *.py
- Target folder in DBFS - Path to folder in DBFS, must be from root and start with a forwardslash. For example /folder/subfolder

### Parameters
- ErrorOrWarn - Whether to throw an error if there are unresolved variables, or just warn.
