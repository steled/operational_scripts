Find-Module -Name VMware.PowerCLI
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name VMware.PowerCLI –Scope CurrentUser
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP $false
Set-PowerCLIConfiguration -InvalidCertificateAction Warn