function Get-EnvironmentVariable {
    [cmdletbinding()]
    param (
        [string]$NameRegex = '.*',
        [string]$ValueRegex = '.*'
        )

    Write-Host ("Getting environment variable with Name regex of '{0}' and Value regex of '{1}'" -f $NameRegex, $ValueRegex )
    
    $result = Get-ChildItem env:* | Where-Object {$_.Name -match $NameRegex -and $_.Value -match $ValueRegex}

    Write-Host "Result: `n $($Result | Select-Object Name, Value | convertto-json)"

    return $result

}