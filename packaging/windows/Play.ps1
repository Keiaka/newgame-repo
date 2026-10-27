$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
try {
    $data = Join-Path $PSScriptRoot 'Data'
    if ($env:WOW_DATA -and (Test-Path (Join-Path $env:WOW_DATA 'terrain.MPQ'))) { $data = $env:WOW_DATA }
    if (!(Test-Path (Join-Path $data 'terrain.MPQ')) -or !(Test-Path (Join-Path $data 'patch.MPQ'))) {
        Write-Host 'First launch needs the separate WoW 1.12.1 game data (~5.5 GB download).'
        Write-Host 'You can instead place your existing 1.12.1 Data folder beside Play.cmd.'
        $answer = Read-Host 'Download the data from the upstream archive.org source now? [Y/N]'
        if ($answer -notmatch '^[Yy]$') { exit 1 }
        $zip = Join-Path $PSScriptRoot 'game-data.zip'
        $url = 'https://archive.org/download/WoW_1.12.1-5875/1.12.1-5875_enUS.zip'
        & curl.exe --fail --location --retry 3 --continue-at - --output $zip $url
        if ($LASTEXITCODE -ne 0) { throw 'Download failed. Run Play.cmd again to resume.' }
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        $archive = [IO.Compression.ZipFile]::OpenRead($zip)
        try {
            New-Item -ItemType Directory -Force $data | Out-Null
            foreach ($entry in $archive.Entries) {
                if ($entry.FullName -match '^Data/([^/]+\.MPQ)$') {
                    [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, (Join-Path $data $Matches[1]), $true)
                }
            }
        } finally { $archive.Dispose() }
        if (!(Test-Path (Join-Path $data 'terrain.MPQ')) -or !(Test-Path (Join-Path $data 'patch.MPQ'))) { throw 'Archive did not contain the required Data files.' }
        Remove-Item $zip
    }
    $env:WOW_DATA = $data
    & (Join-Path $PSScriptRoot 'warcraft-survivors.exe')
    if ($LASTEXITCODE -ne 0) { throw "Game exited with code $LASTEXITCODE. Keep this window open for its error details." }
} catch { Write-Host $_ -ForegroundColor Red; exit 1 }
