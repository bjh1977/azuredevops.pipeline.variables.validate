function Get-EnvironmentVariable {
    [cmdletbinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$NameRegex,
        [Parameter(Mandatory = $true)]
        [string]$ValueRegex 
        )

    Write-Host ("`nGetting environment variables with Name regex of '{0}' and Value regex of '{1}'" -f $NameRegex, $ValueRegex )
    $result = @()
    $MatchedByName = @(); $MatchedByName += Get-ChildItem env:* | Where-Object {$_.Name -match $NameRegex}

    Write-Host ("  {0} variables matched by name" -f $MatchedByName.Count )
    

    $MatchedByName | ForEach-Object {
        if ($_.Value -match $ValueRegex) {
            Write-Host ("   {0} matched by name AND value ({1})" -f $_.Name, $_.Value)            
            $result += $_
        }
        else {
            Write-Host ("   {0} matched by name BUT NOT value ({1})" -f $_.Name, $_.Value)
        }
    }

    return $result

}

