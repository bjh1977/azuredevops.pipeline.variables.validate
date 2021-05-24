function Get-EnvironmentVariable {
    [cmdletbinding()]
    param (
        [string]$NameRegex = '.*',
        [string]$ValueRegex = '.*'
        )

    Write-Verbose ("Getting environment variable with Name regex of '{0}' and Value regex of '{1}'" -f $NameRegex, $ValueRegex )
    
    Get-ChildItem env:* | Where-Object {$_.Name -match $NameRegex -and $_.Value -match $ValueRegex}

}