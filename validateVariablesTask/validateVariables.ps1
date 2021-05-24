[CmdletBinding()]
param()
# https://raw.githubusercontent.com/Microsoft/vsts-tasks/master/Tasks/MSBuildV1/MSBuild.ps1

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\Task.json"

    # Get the inputs.
    [string]$warnOrError = Get-VstsInput -Name warnOrError

    ./ps_functions/Get-EnvironmentVariable.ps1 

    Write-Host "Action on issue: $warnOrError"
    $UnresolvedRegex = '\$\(.*?\)'

    $UnresolvedVariables = Get-EnvironmentVariable -ValueRegex $UnresolvedRegex -Verbose   

    if ($null -ne $UnresolvedVariables) {
        $Msg = ("{0} unresolved variables were found" -f $UnresolvedVariables.Count)

        Write-Host "Unresolved variables:"
        $UnresolvedVariables 

        if($warnOrError -eq 'warn') {
            Write-Warning $Msg
        }
        else {
            Throw $Msg
        }
    }   

    
} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}