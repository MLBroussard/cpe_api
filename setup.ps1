$Directories = @(
    '.\State'
    '.\Results'
    '.\Reports'
    '.\Modules'
)

foreach ($Directory in $Directories) {

    if (-not (Test-Path -LiteralPath $Directory)) {

        New-Item `
            -Path $Directory `
            -ItemType Directory `
            -Force |
        Out-Null
    }
}

foreach ($Directory in @(
    '.\State'
    '.\Results'
    '.\Reports'
)) {

    $GitKeep = Join-Path $Directory '.gitkeep'

    if (-not (Test-Path -LiteralPath $GitKeep)) {

        New-Item `
            -Path $GitKeep `
            -ItemType File `
            -Force |
        Out-Null
    }
}

Write-Host 'Repository directories are ready.' -ForegroundColor Green

New-Item `
    -Path '.\Modules' `
    -ItemType Directory `
    -Force |
Out-Null

Save-Module `
    -Name ImportExcel `
    -Path '.\Modules'
