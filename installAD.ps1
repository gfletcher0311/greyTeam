#Varaibles for quick changes during a competition
$ADDomainName = "seneca.zoo"
$ADDomainNetBiosName = "seneca"
$ADPassword = "z00!"
# Install AD DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

#Install DNS Server
Install-WindowsFeature -Name DNS -IncludeManagementTools

#Install ADDSForest to promote server to a domain controller
Install-ADDSForest `
    -DomainName $ADDomainName `
    -DomainNetBiosName $ADDomainNetBiosName `
    -ForestMode "WinThreshold" `
    -DomainMode "WinThreshold" `
    -InstallDns `
    -SafeModeAdministratorPassword (ConvertTo-SecureString $ADPassword -AsPlainText -Force) `
    -Force
