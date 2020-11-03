#AWS Powershell Module Install

Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Install-Module -Name AWS.Tools.Installer
Install-Module -name AWSPowerShell.NetCore


#setup account, requires an on prem IAM user account
Set-AWSCredential -AccessKey ********* -SecretKey ******* -StoreAs MyProfileName
Get-AWSCredential -ListProfileDetail
Initialize-AWSDefaultConfiguration -ProfileName MyProfileName -Region <region_for example us-east-1> 
Set-AWSCredential -ProfileName MyProfileName

#Test
#Get-R53ResourceRecordSet -HostedZoneId <resourceid>

