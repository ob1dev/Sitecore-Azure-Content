#How to deploy Sitecore databases to Azure SQL Database using PowerShell

This article provides a list of techniques that can be used to deploy Sitecore databases to Microsoft Azure using Azure PowerShell.

**Requirements:**
- A work or school account / Microsoft account and a Microsoft Azure subscription with the following Azure services enabled:
  - Azure Resource Group
  - Azure Storage
  - Azure SQL Database
  - Azure SQL Database Server
- Windows PowerShell ISE or Microsoft Azure PowerShell (available on [PowerShell Gallery](https://www.powershellgallery.com/profiles/azure-sdk/) and [WebPI](http://aka.ms/webpi-azps/)).
- Microsoft SQL Server 2014 or higher
- Sitecore® Experience Platform™ 8.0 or higher

> **Note:** For basic instructions about using Windows PowerShell, see [Using Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=321939).

##Instructions

The recommended approach to deploy Sitecore databases to the [Microsoft Azure SQL Database](https://azure.microsoft.com/en-us/documentation/articles/sql-database-technical-overview/) service is as follows:

1. Run either the Windows PowerShell ISE or Microsoft Azure PowerShell.

   > **Note:** You must run as an Administrator very first time to install a module.

2. Install the Windows PowerShell [Sitecore.Azure](https://www.powershellgallery.com/packages/Sitecore.Azure/) module:

   ```
   PS> Install-Module -Name Sitecore.Azure 
   ```
   
   > **Note:** the `Sitecore.Azure` module depends on the Azure Resource Manager modules, which will be installed automatically if any needed.
   
3. Log in to authenticate cmdlets with Azure Resource Manager:

   ```
   PS> Login-AzureRmAccount
   ```

4. Now you can use the `Publish-SitecoreSqlDatabase` cmdlet to publish one or more Sitecore SQL Server databases. 

   - **Example 1:** Publish the SQL Server databases `sc81initial_core`, `sc81initial_master`, `sc81initial_web` from the local SQL Server `Oleg-PC\SQLEXPRESS` to an Azure SQL Database Server.

      ```
      PS> Publish-SitecoreSqlDatabase -SqlServerName "Oleg-PC\SQLEXPRESS" `
                                      -SqlServerCredentials $credentials `
                                      -SqlServerDatabaseList @("sc81initial_core", "sc81initial_master", "sc81initial_web")
      ```
      
   - **Example 2:** Publish the SQL Server databases `sc81initial_web` from the local SQL Server `Oleg-PC\SQLEXPRESS` to an Azure SQL Database Server in the Resource Group `MyCompanyName` at the Azure data center `Australia East`.
   
     ```
     PS> $credentials = Get-Credential
     
     PS> Publish-SitecoreSqlDatabase -SqlServerName "Oleg-PC\SQLEXPRESS" `
                                     -SqlServerCredentials $credentials ` 
                                     -SqlServerDatabaseList @("sc81initial_web") `
                                     -AzureResourceGroupName "MyCompanyName" `
                                     -AzureResourceGroupLocation "Australia East"
     ```
     
     > **Important:** The Australia Regions are available to customers with a business presence in Australia or New Zealand.
     
   - **Example 3:** Publish the SQL Server databases `sc81initial_core` and `sc81initial_web` from the local SQL Server `Oleg-PC\SQLEXPRESS` to an Azure SQL Database Server using the Azure Storage Account `mycompanyname` for BACPAC packages (.bacpac files).
   
     ```
     PS> $password = ConvertTo-SecureString "12345" -AsPlainText -Force 
     PS> $credentials = New-Object System.Management.Automation.PSCredential ("sa", $password) 
     
     PS> Publish-SitecoreSqlDatabase -SqlServerName "Oleg-PC\SQLEXPRESS" `
                                     -SqlServerCredentials $credentials `
                                     -SqlServerDatabaseList @("sc81initial_core", "sc81initial_web") `
                                     -AzureStorageAccountName "mycompanyname"
     ```
     
   - **Example 4:** Publish the SQL Server databases `sc81initial_core`, `sc81initial_master` and `sc81initial_web` from the local SQL Server `Oleg-PC\SQLEXPRESS` to an Azure SQL Database Server with specified administrator credentials.
   
     ```
     PS> $password = ConvertTo-SecureString "12345" -AsPlainText -Force 
     PS> $azureSqlServerCredentials = New-Object System.Management.Automation.PSCredential ("sa", $password) 
     
     PS> Publish-SitecoreSqlDatabase -SqlServerName "Oleg-PC\SQLEXPRESS" `
                                     -SqlServerCredentials $localSqlServerCredentials `
                                     -SqlServerDatabaseList @("sc81initial_core", "sc81initial_master", "sc81initial_web") `
                                     -AzureSqlServerName "sitecore-azure" `
                                     -AzureSqlServerCredentials $azureSqlServerCredentials
     ```
   
   - **Example 5:** Publish the SQL Server databases `sc81initial_core`, `sc81initial_master`, `sc81initial_web` and `sc81initial_reporting` from the local SQL Server `Oleg-PC\SQLEXPRESS` to Azure SQL Database Server `sitecore-azure` in the Resource Group `MyCompanyName` at the Azure data center `Japan East` using the Azure storage Account `mycompanyname`.
   
     ```
     PS> $localPassword = ConvertTo-SecureString "12345" -AsPlainText -Force 
     PS> $localSqlServerCredentials = New-Object System.Management.Automation.PSCredential ("sa", $localPassword) 
     
     PS> $azurePassword = ConvertTo-SecureString "Experienc3!" -AsPlainText -Force 
     PS> $azureSqlServerCredentials = New-Object System.Management.Automation.PSCredential ("sitecore", $azurePassword)
     
     PS> Publish-SitecoreSqlDatabase -SqlServerName "Oleg-PC\SQLEXPRESS" `
                                     -SqlServerCredentials $localSqlServerCredentials `
                                     -SqlServerDatabaseList @("sc81initial_core", "sc81initial_master", "sc81initial_web", "sc81initial_reporting") `
                                     -AzureResourceGroupName "MyCompanyName" `
                                     -AzureResourceGroupLocation "Japan East" `
                                     -AzureStorageAccountName "mycompanyname" `
                                     -AzureSqlServerName "sitecore-azure" `
                                     -AzureSqlServerCredentials $azureSqlServerCredentials 
     ```