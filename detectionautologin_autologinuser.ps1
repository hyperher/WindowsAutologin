$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
$Username = "autologinuser" # Note: Assuming "adiautologin" based on context, but user wrote "adiautologon" in query - please confirm
$key = ""

$allCorrect = $true

#Check ForceAutoLogon
if ((Get-ItemProperty -Path $RegistryPath -Name 'ForceAutoLogon' -ErrorAction SilentlyContinue).ForceAutoLogon -ne '0') {
Write-Host "ForceAutoLogon is not set to '1'."
$allCorrect = $false
}

#Check AutoAdminLogon
if ((Get-ItemProperty -Path $RegistryPath -Name 'AutoAdminLogon' -ErrorAction SilentlyContinue).AutoAdminLogon -ne '1') {
Write-Host "AutoAdminLogon is not set to '1'."
$allCorrect = $false
}

#Check DefaultUsername
if ((Get-ItemProperty -Path $RegistryPath -Name 'DefaultUsername' -ErrorAction SilentlyContinue).DefaultUsername -ne $Username) {
Write-Host "DefaultUsername is not set to '$Username'."
$allCorrect = $false
}

#Check DefaultPassword
if ((Get-ItemProperty -Path $RegistryPath -Name 'DefaultPassword' -ErrorAction SilentlyContinue).DefaultPassword -ne $key) {
Write-Host "DefaultPassword is not set to '$key'."
$allCorrect = $false
}

if ($allCorrect) {
Write-Host "All autologin registry settings are correctly configured."
exit 0
} else {
Write-Host "One or more autologin registry settings are incorrect."
exit 1
}