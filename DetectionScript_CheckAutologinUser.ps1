

try {
    $user = Get-LocalUser -Name "adiautologin" -ErrorAction Stop
    Write-Host "User 'kioskuser0' exists."
    exit 0
} catch {
    Write-Host "User 'adiautologin' does not exist."
    exit 1
}