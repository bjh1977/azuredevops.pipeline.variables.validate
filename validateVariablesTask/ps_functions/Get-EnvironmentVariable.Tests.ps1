BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe Get-EnvironmentVariable {

    $UnresolvedRegex = '\$\(.*?\)'

    BeforeAll {
        $env:GetEnvVarTestVar1 = 'GetEnvVarTestVar1Value'
        $env:GetEnvVarTestVar1a = 'GetEnvVarTestVar1aValue'
        $env:GetEnvVarTestVar2 = 'GetEnvVarTestVar2Value'
        $env:GetEnvVarTestVar2a = 'GetEnvVarTestVar2aValue$(Unresolved)'
        $env:GetEnvVarTestVar3 = 'GetEnvVarTestVar3Value$(Unresolved)-Something($Unresolved)'
    }

    
    

    It "Returns no results when no variables match" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^DoesNotExist$'
        $TestResult.Count | Should -Be 0
    }

    It "Returns 1 result when 1 variable matches" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^GetEnvVarTestVar1$'
        $TestResult.Count | Should -Be 1
    }

    It "Returns 2 results when 2 variables match" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^GetEnvVarTestVar1'
        $TestResult.Count | Should -Be 2
    }

    It "Returns 1 result when 1 variable matched and is unresolved" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^GetEnvVarTestVar2a$' -ValueRegex $UnresolvedRegex
        $TestResult.Count | Should -Be 1
    }

    It "Returns 1 result when 2 variables match and 1 is unresolved" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^GetEnvVarTestVar2' -ValueRegex $UnresolvedRegex

        Write-Host "$($TestResult.Key) = $($TestResult.Value)"

        $TestResult.Count | Should -Be 1
    }

    It "Returns 1 result when 1 variable matched with multiple unresolved values" {
        $TestResult = Get-EnvironmentVariable -NameRegex '^GetEnvVarTestVar3$' -ValueRegex $UnresolvedRegex
        $TestResult.Count | Should -Be 1
    }

    AfterAll {
        $env:GetEnvVarTestVar1 = $null
        $env:GetEnvVarTestVar1a = $null
        $env:GetEnvVarTestVar2 = $null
        $env:GetEnvVarTestVar2a = $null
        $env:GetEnvVarTestVar3 = $null
    }
   

    

    


}


