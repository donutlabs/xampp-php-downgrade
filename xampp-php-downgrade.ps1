# Script Name: XAMPP PHP DOWNGRADE
# Author: Christopher Spradlin
# Version: 1.0
# Description: PowerShell Script to Downgrade PHP in XAMPP to PHP 7.1
# Date: 03/2/2024
#------------------------------------------------------------

# Define the PHP version to downgrade to
$phpVersion = "7.1.33"

# Define the download URL for the specified PHP version
$phpDownloadUrl = "https://windows.php.net/downloads/releases/archives/php-$phpVersion-Win32-VC14-x64.zip"

# Define the XAMPP PHP directory
$xamppPhpDir = "C:\xampp\php"

# Define the backup directory
$backupDir = "C:\xampp\php_backup"

# Define the directory to extract the new PHP version
$newPhpDir = "C:\xampp\php_new"

# Create a backup of the current PHP directory
Write-Host "Backing up the current PHP directory..."
if (Test-Path $backupDir) {
    Remove-Item -Recurse -Force $backupDir
}
Copy-Item -Recurse $xamppPhpDir $backupDir

# Download the specified PHP version
Write-Host "Downloading PHP $phpVersion..."
Invoke-WebRequest -Uri $phpDownloadUrl -OutFile "$newPhpDir.zip"

# Extract the downloaded PHP version
Write-Host "Extracting PHP $phpVersion..."
Expand-Archive -Path "$newPhpDir.zip" -DestinationPath $newPhpDir -Force

# Remove the existing PHP directory
Remove-Item -Recurse -Force $xamppPhpDir

# Rename the new PHP directory
Rename-Item -Path $newPhpDir -NewName $xamppPhpDir

# Cleanup downloaded files
Remove-Item "$newPhpDir.zip"

Write-Host "PHP version downgraded to $phpVersion. Please check your applications for compatibility."
