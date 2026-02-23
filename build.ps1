$OutputPath = "$PSScriptRoot\output"

Remove-Item -Path $OutputPath -Force -ErrorAction SilentlyContinue -Recurse
Remove-Item -Path $PSScriptRoot\public -Force -ErrorAction SilentlyContinue -Recurse
Set-Location $PSScriptRoot

& {
    $ErrorActionPreference = 'SilentlyContinue'
    npm install --legacy-peer-deps
    npm run build
}

New-Item -Path $OutputPath -ItemType Directory | Out-Null

if (-not (Test-Path $PSScriptRoot\public)) {

    New-Item -Path $PSScriptRoot\public -ItemType Directory | Out-Null
}

Copy-Item $PSScriptRoot\public\*.* $OutputPath
Copy-Item $PSScriptRoot\UniversalDashboard.*.psd1 $OutputPath
Copy-Item $PSScriptRoot\UniversalDashboard.*.psm1 $OutputPath
