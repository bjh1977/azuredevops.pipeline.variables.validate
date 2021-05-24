function Get-EnvironmentVariable {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NameRegex,
        [Parameter(Mandatory = $true)]
        [string]$ValueRegex 
        )

    Write-Host ("Getting environment variables with Name regex of '{0}' and Value regex of '{1}'" -f $NameRegex, $ValueRegex )
    $result = @()
    $MatchedByName = @(); $MatchedByName += Get-ChildItem env:* | Where-Object {$_.Name -match $NameRegex}

    Write-Host ("{0} variables matched by name: " -f $MatchedByName.Count )
    

    $MatchedByName | ForEach-Object {
        Write-Host ("{0} matched by name" -f $_.Name)
        if ($_.Value -match $ValueRegex) {
            Write-Host (".. AND ALSO by value: {0}" -f $_.Value)
            $result += $_
        }
        else {
            Write-Host (".. BUT NOT by value: {0}" -f $_.Value )
        }
    }

    return $result

}

