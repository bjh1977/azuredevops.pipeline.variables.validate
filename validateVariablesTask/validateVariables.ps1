[CmdletBinding()]
param()
# https://raw.githubusercontent.com/Microsoft/vsts-tasks/master/Tasks/MSBuildV1/MSBuild.ps1

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\Task.json"

    # Get the inputs.
    [string]$warnOrError = Get-VstsInput -Name warnOrError

    Write-Host "Action on issue: $warnOrError"
    $regex = '\$\(.*?\)'
    $UnresolvedVariables = @()

    # Get unresolved variables
    Get-ChildItem env:* | ForEach-Object {
        if ($_.Value -match $regex) {
            $UnresolvedVariables += $_
            Write-Host ("Variable {0} is unresolved. Value is {1}" -f $_.Name, $_.Value) -ForegroundColor Yellow
        }        
    }

    if ($UnresolvedVariables.Count -gt 0) {
        $Msg = ("{0} unresolved variables were found" -f $UnresolvedVariables.Count  )

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