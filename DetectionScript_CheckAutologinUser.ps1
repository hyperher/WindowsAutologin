

try {
    $user = Get-LocalUser -Name "kioskuser0" -ErrorAction Stop
    Write-Host "User 'kioskuser0' exists."
    exit 0
} catch {
    Write-Host "User 'kioskuser0' does not exist."
    exit 1
}