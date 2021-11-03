#Fill these out
$sub="" #Subscription Name
$rg="" #Resource Group to analyse
$tenantId="" #Azure AD tenantId

#Only change these if you really care
$templatePath=".wellarchitected-output/templates/"
$resultsPath=".wellarchitected-output/results/"


# Install PSRule.Rules.Azure from the PowerShell Gallery
Install-Module -Name 'PSRule.Rules.Azure' -Scope CurrentUser -Force;

#Connect to Azure
Connect-AzAccount -Subscription $sub -UseDeviceAuthentication -Tenant $tenantId

# Export data from the resource group
Export-AzRuleData -ResourceGroupName $rg -OutputPath $templatePath;

# Check against Azure Rules
$resultsFile = Join-Path $resultsPath -childpath "$(New-Guid).txt"
$PSRuleResults = Invoke-PSRule -InputPath $templatePath -Module 'PSRule.Rules.Azure' -As Summary;
$PSRuleResults | Out-File $resultsFile 
Write-Output $PSRuleResults