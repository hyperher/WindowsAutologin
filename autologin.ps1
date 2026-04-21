$Username = "kioskuser0"
$key = ""

# Check if user exists, if not, create it
$user = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
if (-not $user) {
    if ([string]::IsNullOrEmpty($key)) {
        $securePassword = [System.Security.SecureString]::new()
    } else {
        $securePassword = ConvertTo-SecureString $key -AsPlainText -Force
    }
    New-LocalUser -Name $Username -Password $securePassword -AccountNeverExpires -PasswordNeverExpires
    # Add to Administrators group for autologin
    Add-LocalGroupMember -Group "Administrators" -Member $Username
}

$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'

If ((Get-Item -Path $RegistryPath).GetValue('ForceAutoLogon') -ne '1') {Set-ItemProperty -Path $RegistryPath -Name 'ForceAutoLogon' -Value 1}

If ((Get-Item -Path $RegistryPath).GetValue('AutoAdminLogon') -ne '1') {Set-ItemProperty -Path $RegistryPath -Name 'AutoAdminLogon' -Value 1}

If ((Get-Item -Path $RegistryPath).GetValue('DefaultUsername') -ne $Username) {Set-ItemProperty -Path $RegistryPath -Name 'DefaultUsername' -Value $Username}

If ((Get-Item -Path $RegistryPath).GetValue('DefaultPassword') -ne $key) {Set-ItemProperty -Path $RegistryPath -Name 'DefaultPassword' -Value $key}

Restart-Computer -Force