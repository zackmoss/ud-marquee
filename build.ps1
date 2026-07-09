
param (
    [switch] $Clean
)

$outputPath = "$PSScriptRoot\output"

if ($Clean) {
    Remove-Item -Path "$PSScriptRoot\node_modules" -Force -ErrorAction SilentlyContinue -Recurse
    Remove-Item -Path "$PSScriptRoot\package-lock.json" -Force -ErrorAction SilentlyContinue
}

Remove-Item -Path $outputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path "$PSScriptRoot\public" -Force -ErrorAction SilentlyContinue -Recurse
Set-Location $PSScriptRoot

$env:NODE_OPTIONS = "--openssl-legacy-provider"

& {
    $ErrorActionPreference = 'SilentlyContinue'
    npm install --legacy-peer-deps
    npm run build
}

New-Item -Path $outputPath -ItemType Directory | Out-Null

if (-not (Test-Path "$PSScriptRoot\public")) {

    New-Item -Path $PSScriptRoot\public -ItemType Directory | Out-Null
}

Copy-Item "$PSScriptRoot\public\*.*" $outputPath
Copy-Item "$PSScriptRoot\UniversalDashboard.*.psd1" $outputPath
Copy-Item "$PSScriptRoot\UniversalDashboard.*.psm1" $outputPath
