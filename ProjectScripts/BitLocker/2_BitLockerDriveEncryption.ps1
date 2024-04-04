# Function to check the status of: BitLocker - Drive Encryption
function Check-GPSetting {
    param (
        [string]$policyPath,
        [string]$valueName,
        [string]$expectedValue,
        [string]$sectionNumber,
		[string]$level,
        [string]$description,
        [string]$recommendation
    )

    $currentValue = Get-ItemProperty -Path $policyPath -Name $valueName -ErrorAction SilentlyContinue
    $status = "Non-Compliant"
    if ($currentValue -ne $null -and $currentValue.$valueName -eq $expectedValue) {
        $status = "Compliant"
    }

    Write-Host "$sectionNumber $level Ensure '$description' is set to '$recommendation': $status"
}


# Registry Values:
$RegPath= "HKLM:\SOFTWARE\Policies\Microsoft\FVE"


# 18.10.9.1.1 (BL) Ensure 'Allow access to BitLocker-protected fixed data drives from earlier versions of Windows' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVDiscoveryVolumeType" -expectedValue 0 -sectionNumber "18.10.9.1.1" -level "(BL)" -description "Allow access to BitLocker-protected fixed data drives from earlier versions of Windows" -recommendation "Disabled"

# 18.10.9.1.2 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVRecovery" -expectedValue 1 -sectionNumber "18.10.9.1.2" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered" -recommendation "Enabled"

# 18.10.9.1.3 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Allow data recovery agent' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "FDVManageDRA" -expectedValue 1 -sectionNumber "18.10.9.1.3" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Allow data recovery agent" -recommendation "Enabled: True"

# 18.10.9.1.4 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Recovery Password' is set to 'Enabled: Allow 48-digit recovery password'
Check-GPSetting -policyPath $RegPath -valueName "FDVRecoveryPassword" -expectedValue 1 -sectionNumber "18.10.9.1.4" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Recovery Password" -recommendation "Enabled: Allow 48-digit recovery password"

# 18.10.9.1.5 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Recovery Key' is set to 'Enabled: Allow 256-bit recovery key'
Check-GPSetting -policyPath $RegPath -valueName "FDVRecoveryKey" -expectedValue 1 -sectionNumber "18.10.9.1.5" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Recovery Key" -recommendation "Enabled: Allow 256-bit recovery key"

# 18.10.9.1.6 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Omit recovery options from the BitLocker setup wizard' are set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "FDVHideRecoveryPage" -expectedValue 1 -sectionNumber "18.10.9.1.6" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Omit recovery options from the BitLocker setup wizard" -recommendation "Enabled: True"

# 18.10.9.1.7 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Save BitLocker recovery information to AD DS for fixed data drives' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "FDVActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.1.7" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Save BitLocker recovery information to AD DS for fixed data drives" -recommendation "Enabled: False"

# 18.10.9.1.8 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Configure storage of BitLocker recovery information to AD DS' is set to 'Enabled: Backup recovery passwords and key packages'
Check-GPSetting -policyPath $RegPath -valueName "FDVActiveDirectoryInfoToStore" -expectedValue 1 -sectionNumber "18.10.9.1.8" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Configure storage of BitLocker recovery information to AD DS" -recommendation "Enabled: Backup recovery passwords and key packages"

# 18.10.9.1.9 (BL) Ensure 'Choose how BitLocker-protected fixed drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "FDVRequireActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.1.9" -level "(BL)" -description "Choose how BitLocker-protected fixed drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for fixed data drives" -recommendation "Enabled: False"

# 18.10.9.1.10 (BL) Ensure 'Configure use of hardware-based encryption for fixed data drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVHardwareEncryption" -expectedValue 0 -sectionNumber "18.10.9.1.10" -level "(BL)" -description "Configure use of hardware-based encryption for fixed data drives" -recommendation "Disabled"

# 18.10.9.1.11 (BL) Ensure 'Configure use of passwords for fixed data drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVPassphrase" -expectedValue 0 -sectionNumber "18.10.9.1.11" -level "(BL)" -description "Configure use of passwords for fixed data drives" -recommendation "Disabled"

# 18.10.9.1.12 (BL) Ensure 'Configure use of smart cards on fixed data drives' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "FDVAllowUserCert" -expectedValue 1 -sectionNumber "18.10.9.1.12" -level "(BL)" -description "Configure use of smart cards on fixed data drives" -recommendation "Enabled"

# 18.10.9.1.13 (BL) Ensure 'Configure use of smart cards on fixed data drives: Require use of smart cards on fixed data drives' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "FDVEnforceUserCert" -expectedValue 1 -sectionNumber "18.10.9.1.13" -level "(BL)" -description "Configure use of smart cards on fixed data drives: Require use of smart cards on fixed data drives" -recommendation "Enabled: True"

# 18.10.9.2.1 (BL) Ensure 'Allow enhanced PINs for startup' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "UseEnhancedPin" -expectedValue 1 -sectionNumber "18.10.9.2.1" -level "(BL)" -description "Allow enhanced PINs for startup" -recommendation "Enabled"

# 18.10.9.2.2 (BL) Ensure 'Allow Secure Boot for integrity validation' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "OSAllowSecureBootForIntegrity" -expectedValue 1 -sectionNumber "18.10.9.2.2" -level "(BL)" -description "Allow Secure Boot for integrity validation" -recommendation "Enabled"

# 18.10.9.2.3 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "OSRecovery" -expectedValue 1 -sectionNumber "18.10.9.2.3" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered" -recommendation "Enabled"

# 18.10.9.2.4 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Allow data recovery agent' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "OSManageDRA" -expectedValue 1 -sectionNumber "18.10.9.2.4" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Allow data recovery agent" -recommendation "Enabled: False"

# 18.10.9.2.5 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Recovery Password' is set to 'Enabled: Require 48-digit recovery password'
Check-GPSetting -policyPath $RegPath -valueName "OSRecoveryPassword" -expectedValue 1 -sectionNumber "18.10.9.2.5" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Recovery Password" -recommendation "Enabled: Require 48-digit recovery password"

# 18.10.9.2.6 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Recovery Key' is set to 'Enabled: Do not allow 256-bit recovery key'
Check-GPSetting -policyPath $RegPath -valueName "OSRecoveryKey" -expectedValue 1 -sectionNumber "18.10.9.2.6" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Recovery Key" -recommendation "Enabled: Do not allow 256-bit recovery key"

# 18.10.9.2.7 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Omit recovery options from the BitLocker setup wizard' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "OSHideRecoveryPage" -expectedValue 1 -sectionNumber "18.10.9.2.7" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Omit recovery options from the BitLocker setup wizard" -recommendation "Enabled: True"

# 18.10.9.2.8 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Save BitLocker recovery information to AD DS for operating system drives' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "OSActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.2.8" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Save BitLocker recovery information to AD DS for operating system drives" -recommendation "Enabled: True"

# 18.10.9.2.9 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Configure storage of BitLocker recovery information to AD DS:' is set to 'Enabled: Store recovery passwords and key packages'
Check-GPSetting -policyPath $RegPath -valueName "OSActiveDirectoryInfoToStore" -expectedValue 1 -sectionNumber "18.10.9.2.9" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Configure storage of BitLocker recovery information to AD DS" -recommendation "Enabled: Store recovery passwords and key packages"

# 18.10.9.2.10 (BL) Ensure 'Choose how BitLocker-protected operating system drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for operating system drives' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "OSRequireActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.2.10" -level "(BL)" -description "Choose how BitLocker-protected operating system drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for operating system drives" -recommendation "Enabled: True"

# 18.10.9.2.11 (BL) Ensure 'Configure use of hardware-based encryption for operating system drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "OSHardwareEncryption" -expectedValue 0 -sectionNumber "18.10.9.2.11" -level "(BL)" -description "Configure use of hardware-based encryption for operating system drives" -recommendation "Disabled"

# 18.10.9.2.12 (BL) Ensure 'Configure use of passwords for operating system drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "OSPassphrase" -expectedValue 0 -sectionNumber "18.10.9.2.12" -level "(BL)" -description "Configure use of passwords for operating system drives" -recommendation "Disabled"

# 18.10.9.2.13 (BL) Ensure 'Require additional authentication at startup' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "UseAdvancedStartup" -expectedValue 1 -sectionNumber "18.10.9.2.13" -level "(BL)" -description "Require additional authentication at startup" -recommendation "Enabled"

# 18.10.9.2.14 (BL) Ensure 'Require additional authentication at startup: Allow BitLocker without a compatible TPM' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "EnableBDEWithNoTPM" -expectedValue 1 -sectionNumber "18.10.9.2.14" -level "(BL)" -description "Require additional authentication at startup: Allow BitLocker without a compatible TPM" -recommendation "Enabled: False"

# 18.10.9.3.1 (BL) Ensure 'Allow access to BitLocker-protected removable data drives from earlier versions of Windows' is set to 'Disabled'
 Check-GPSetting -policyPath $RegPath -valueName "RDVDiscoveryVolumeType" -expectedValue 0 -sectionNumber "18.10.9.3.1" -level "(BL)" -description "Allow access to BitLocker-protected removable data drives from earlier versions of Windows" -recommendation "Disabled"

# 18.10.9.3.2 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RDVRecovery" -expectedValue 1 -sectionNumber "18.10.9.3.2" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered" -recommendation "Enabled"

# 18.10.9.3.3 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Allow data recovery agent' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "RDVManageDRA" -expectedValue 1 -sectionNumber "18.10.9.3.3" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Allow data recovery agent" -recommendation "Enabled: True"

# 18.10.9.3.4 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Recovery Password' is set to 'Enabled: Do not allow 48-digit recovery password'
Check-GPSetting -policyPath $RegPath -valueName "RDVRecoveryPassword" -expectedValue 1 -sectionNumber "18.10.9.3.4" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Recovery Password" -recommendation "Enabled: Do not allow 48-digit recovery password"

# 18.10.9.3.5 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Recovery Key' is set to 'Enabled: Do not allow 256-bit recovery key'
Check-GPSetting -policyPath $RegPath -valueName "RDVRecoveryKey" -expectedValue 1 -sectionNumber "18.10.9.3.5" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Recovery Key" -recommendation "Enabled: Do not allow 256-bit recovery key"

# 18.10.9.3.6 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Omit recovery options from the BitLocker setup wizard' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "RDVHideRecoveryPage" -expectedValue 1 -sectionNumber "18.10.9.3.6" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Omit recovery options from the BitLocker setup wizard" -recommendation "Enabled: True"

# 18.10.9.3.7 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Save BitLocker recovery information to AD DS for removable data drives' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "RDVActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.3.7" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Save BitLocker recovery information to AD DS for removable data drives" -recommendation "Enabled: False"

# 18.10.9.3.8 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Configure storage of BitLocker recovery information to AD DS:' is set to 'Enabled: Backup recovery passwords and key packages'
Check-GPSetting -policyPath $RegPath -valueName "RDVActiveDirectoryInfoToStore" -expectedValue 1 -sectionNumber "18.10.9.3.8" -level "(BL)" -description "" -recommendation "Enabled: Backup recovery passwords and key packages"

# 18.10.9.3.9 (BL) Ensure 'Choose how BitLocker-protected removable drives can be recovered: Do not enable BitLocker until recovery information is stored to AD DS for removable data drives' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "RDVRequireActiveDirectoryBackup" -expectedValue 1 -sectionNumber "18.10.9.3.9" -level "(BL)" -description "Choose how BitLocker-protected removable drives can be recovered: Configure storage of BitLocker recovery information to AD DS" -recommendation "Enabled: False"

# 18.10.9.3.10 (BL) Ensure 'Configure use of hardware-based encryption for removable data drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "RDVHardwareEncryption" -expectedValue 0 -sectionNumber "18.10.9.3.10" -level "(BL)" -description "Configure use of hardware-based encryption for removable data drives" -recommendation "Disabled"

# 18.10.9.3.11 (BL) Ensure 'Configure use of passwords for removable data drives' is set to 'Disabled'
Check-GPSetting -policyPath $RegPath -valueName "RDVPassphrase" -expectedValue 0 -sectionNumber "18.10.9.3.11" -level "(BL)" -description "Configure use of passwords for removable data drives" -recommendation "Disabled"

# 18.10.9.3.12 (BL) Ensure 'Configure use of smart cards on removable data drives' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RDVAllowUserCert" -expectedValue 1 -sectionNumber "18.10.9.3.12" -level "(BL)" -description "Configure use of smart cards on removable data drives" -recommendation "Enabled"

# 18.10.9.3.13 (BL) Ensure 'Configure use of smart cards on removable data drives: Require use of smart cards on removable data drives' is set to 'Enabled: True'
Check-GPSetting -policyPath $RegPath -valueName "RDVEnforceUserCert" -expectedValue 1 -sectionNumber "18.10.9.3.13" -level "(BL)" -description "Configure use of smart cards on removable data drives: Require use of smart cards on removable data drives" -recommendation "Enabled: True"

# 18.10.9.3.14 (BL) Ensure 'Deny write access to removable drives not protected by BitLocker' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "RDVDenyWriteAccess" -expectedValue 1 -sectionNumber "18.10.9.3.14" -level "(BL)" -description "Deny write access to removable drives not protected by BitLocker" -recommendation "Enabled"

# 18.10.9.3.15 (BL) Ensure 'Deny write access to removable drives not protected by BitLocker: Do not allow write access to devices configured in another organization' is set to 'Enabled: False'
Check-GPSetting -policyPath $RegPath -valueName "RDVDenyCrossOrg" -expectedValue 1 -sectionNumber "18.10.9.3.15" -level "(BL)" -description "Deny write access to removable drives not protected by BitLocker: Do not allow write access to devices configured in another organization" -recommendation "Enabled: False"

# 18.10.9.4 (BL) Ensure 'Disable new DMA devices when this computer is locked' is set to 'Enabled'
Check-GPSetting -policyPath $RegPath -valueName "DisableExternalDMAUnderLock" -expectedValue 1 -sectionNumber "18.10.9.4" -level "(BL)" -description "Disable new DMA devices when this computer is locked" -recommendation "Enabled"
