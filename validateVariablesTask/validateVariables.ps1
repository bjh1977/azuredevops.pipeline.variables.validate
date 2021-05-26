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

    # Import the helpers.
    Import-Module -Name $PSScriptRoot\ps_modules\TaskHelper\taskhelper.psm1

    Write-Host "varNameRegex:  $varNameRegex"
    Write-Host "varValueRegex: $varValueRegex"
    Write-Host "warnOrError:   $warnOrError"
    
    if ([string]::IsNullOrEmpty($varNameRegex)) {$varNameRegex = '.*'}
    if ([string]::IsNullOrEmpty($varValueRegex)) {$varValueRegex = '\$\(.*?\)'}
    
    $InvalidVariables = Get-EnvironmentVariable -NameRegex $varNameRegex -ValueRegex $varValueRegex -Verbose   

    if ($null -ne $InvalidVariables) {
        $Msg = ("{0} invalid variable(s) found" -f $InvalidVariables.Count)

        Write-Host "Invalid variable(s):"
        foreach($InvalidVariable in $InvalidVariables) {
            Write-Host ("`n{0} = {1}" -f $InvalidVariable.Name, $InvalidVariable.Value) 
        } 

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