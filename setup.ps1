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

New-Item -Path '.\Modules' -ItemType Directory -Force | Out-Null

# Install the NuGet 2.8.5.208
# Define source and destination paths
$RepoPath = "\\Local\Repo\Path" # CHANGE THIS
$SourcePath = "$Repopath\nuget"
$DestinationDir = "$env:LOCALAPPDATA\PackageManagement\ProviderAssemblies"
$DestinationPath = Join-Path $DestinationDir "nuget"

# Check if the destination directory/folder exists
if (-not (Test-Path -Path $DestinationPath)) {
    # Ensure parent directory exists
    if (-not (Test-Path -Path $DestinationDir)) {
        New-Item -ItemType Directory -Force -Path $DestinationDir | Out-Null
    }
    
    # Copy the folder
    Copy-Item -Path $SourcePath -Destination $DestinationPath -Recurse -Force
    Write-Host "NuGet folder successfully copied to $DestinationPath" -ForegroundColor Green
} else {
    Write-Host "NuGet folder already exists at $DestinationPath. No action taken." -ForegroundColor Yellow
}

# Save PackageManagement and PowerShellGet to the directory
Save-Module -Name ImportExcel -Path '.\Modules'
