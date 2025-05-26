# Copy justfile to root if not already present
$justSource = "$PSScriptRoot\..\utils\justfile"
$justDest = "$PSScriptRoot\..\justfile"

if (!(Test-Path $justDest)) {
    Copy-Item $justSource $justDest -Force
    Write-Host "✅ Copied justfile to project root." -ForegroundColor Green
} else {
    Write-Host "🔄 justfile already exists in root." -ForegroundColor Gray
}