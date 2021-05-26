function Get-EnvironmentVariable {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NameRegex,
        [Parameter(Mandatory = $true)]
        [string]$ValueRegex 
        )

    Write-Host ("`nGetting environment variables with Name regex of '{0}' and Value regex of '{1}'" -f $NameRegex, $ValueRegex )
    $MatchedByNameAndValue = @()
    $MatchedByName = @(); $MatchedByName += Get-ChildItem env:* | Where-Object {$_.Name -match $NameRegex}


    $MatchedByName | ForEach-Object {
        if ($_.Value -match $ValueRegex) {
            Write-Verbose ("   {0} matched by name AND value ({1})" -f $_.Name, $_.Value)            
            $MatchedByNameAndValue += $_
        }
        else {
            Write-Verbose ("   {0} matched by name BUT NOT value ({1})" -f $_.Name, $_.Value)
        }
    }

    Write-Host ("SUMMARY:`n{0} variable(s) matched by name`n{1} variables matched by name and value and considered invalid" -f $MatchedByName.Count, $MatchedByNameAndValue.Count )

    return $MatchedByNameAndValue

}

