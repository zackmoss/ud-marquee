# Register JavaScript assets with PowerShell Universal
Get-ChildItem "$PSScriptRoot\*.js" | ForEach-Object {
    $Item = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($_.FullName)
    if ($_.Name.StartsWith("index.") -and $_.Name.EndsWith(".bundle.js")) {
        $AssetId = $Item
    }
}

function New-UDMarquee {
    <#
    .SYNOPSIS
    Creates a new component
    
    .DESCRIPTION
    Creates a new component
    
    .PARAMETER Id
    The ID of this editor

    .PARAMETER Text
    Text for the component

    .EXAMPLE
    New-UDComponent -Text 'Hello, world!'
    #>
    
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter(Mandatory)]
        [object]$Messages,
        [Parameter()]
        [int]$RotateInterval = 5000,
        [Parameter()]
        [int]$Speed = 20,
        [Parameter()]
        [string]$BackgroundColor,
        [Parameter()]
        [string]$Color
    )

    end {
        @{
            assetId         = $AssetId 
            isPlugin        = $true 
            type            = "ud-marquee"
            id              = $Id

            messages        = $Messages
            rotateInterval  = $RotateInterval
            speed           = $Speed
            backgroundColor = $BackgroundColor
            color           = $Color
        }
    }
}