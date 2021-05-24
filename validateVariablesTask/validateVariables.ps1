[CmdletBinding()]
param()
# https://raw.githubusercontent.com/Microsoft/vsts-tasks/master/Tasks/MSBuildV1/MSBuild.ps1

Trace-VstsEnteringInvocation $MyInvocation
try {
    Import-VstsLocStrings "$PSScriptRoot\Task.json"

    # Get the inputs.
    [string]$varNameRegex = Get-VstsInput -Name varNameRegex
    [string]$varValueRegex = Get-VstsInput -Name varValueRegex
    [string]$warnOrError = Get-VstsInput -Name warnOrError

    ./ps_functions/Get-EnvironmentVariable.ps1 

    Write-Host "Action on issue: $warnOrError"
    
    if ([string]::IsNullOrEmpty($varNameRegex)) {$varNameRegex = '.*'}
    if ([string]::IsNullOrEmpty($varValueRegex)) {$varValueRegex = '\$\(.*?\)'}
    
    $Result = Get-EnvironmentVariable -NameRegex $varNameRegex -ValueRegex $varValueRegex -Verbose   

    if ($null -ne $Result) {
        $Msg = ("{0} invalid variables were found" -f $Result.Count)

        Write-Host "Invalid variables:"
        $Result 

        if($warnOrError -eq 'warn') {
            Write-Warning $Msg
        }
        else {
            Throw $Msg
        }
    }
    else {
        Write-Host "No variables considered invalid"
    }   

    
} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}