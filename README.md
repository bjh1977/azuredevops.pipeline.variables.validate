
# Validate Azure Devops Variables

This extension checks the value of your variables and either warns or throws an error if they have not been fully-resolved.  This may happen if you reference a variable which does not exist such as `Variable1: $(Variable2)` where `Variable2` does not exist.


### Add task
You will find the new Tasks available under the Build or Deploy tab, or search for "variables validate".

### Usage
```
- task: validateVariablesTask@0
  inputs:
    warnOrError: 'Error'
```    

### Parameters
- `warnOrError` - Whether to throw an error if there are unresolved variables, or just warn.
