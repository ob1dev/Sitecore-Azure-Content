#How to deploy Sitecore 7.2 solution to Microsoft Azure Cloud Service using Visual Studio

After developing a Sitecore solution in Visual Studio, it is possible to manually publish this solution to the Microsoft Azure Cloud Platform.

This article provides a list of techniques that can be used to deploy a Sitecore solution to Microsoft Azure using Microsoft Visual Studio.

> **Important:** It is highly recommended that you get acquainted with the [Compute Hosting Options Provided by Azure](http://azure.microsoft.com/en-us/documentation/articles/fundamentals-application-models/) and [Microsoft Azure Fundamentals](http://www.microsoftvirtualacademy.com/colleges/Azure-fundamentals) before following the instructions in this article.

**Requirements:**
- A work or school account / Microsoft account and a Microsoft Azure subscription with the following Azure services enabled:
  - [Azure Cloud Service](https://msdn.microsoft.com/en-us/library/azure/jj155995.aspx)
  - [Azure Storage](https://msdn.microsoft.com/en-us/library/azure/gg433040.aspx)
  - [Azure SQL Database](https://msdn.microsoft.com/en-us/library/azure/ee336279.aspx)
  - [Azure Redis Cache](https://msdn.microsoft.com/en-us/library/azure/dn690523.aspx)
- Microsoft Visual Studio 2013
- Microsoft Azure SDK 2.5.1 for .NET
- Microsoft Azure Tool for Visual Studio 2013 
- Microsoft SQL Server Management Studio 2014
- Sitecore CMS and DMS 7.2 rev. 150408 (7.2 Update-4) or higher

> **Note:** To download the latest version of the Microsoft Azure SDK and Tool for Visual Studio, follow this link: http://azure.microsoft.com/en-us/downloads/

##Instructions

The recommended approach to deploy a Sitecore solution to Microsoft Azure using Visual Studio is as follows:

1. In the **Visual Studio**, right-click the **ASP.NET Web Application** project, and then click the **Convert -> Convert to Microsoft Cloud Service Project** in the context menu. The **Azure Cloud Service** project is generated.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-01.png)
   
   > **Note:** For information on creating an ASP.NET Web Application project for Sitecore, see the section [How To Create ASP.NET Web Application Project](how-to-create-aspnet-web-application-project.md).

2. In the **ASP.NET Web Application** project, include the default Sitecore files, directories and subdirectories:

   For a **Content Delivery** environment:
   - \App_Browsers
   - \App_Config
   - \App_Data
   - \bin
   - \layouts
   - \sitecore\services
   - \sitecore modules
   - \sitecore_files
   - \temp
   - \upload
   - \xsl
   - \Default.aspx
   - \default.css
   - \default.htm.sitedown
   - \default.js
   - \Global.asax
   - \Web.config
   - \webedit.css

   For a **Content Management** environment, additionally include the following directories and files:
   - \sitecore\admin
   - \sitecore\Copyright
   - \sitecore\debug
   - \sitecore\images
   - \sitecore\login
   - \sitecore\portal
   - \sitecore\samples
   - \sitecore\shell
   - \sitecore\blocked.aspx
   - \sitecore\default.aspx
   - \sitecore\no.css

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-02.png)

   > **Important:** Visual Studio may freeze when including the entire `\sitecore\shell` directory at once because it contains a lot of files and subdirectories. Try to split all the subdirectories into portions, and then add them one by one.

3. In the **Visual Studio**, click the **Tools** -> **NuGet Package Manager** -> **Packages Manager Console**. Run the following command in the **Package Manager Console** window against the **ASP.NET Web Application** project:     
  
    ```
    Install-Package Sitecore.Azure.Setup -Version 7.2.0
    ```
   
   > **Note:** Modify both the `Web.Debug.config` and `Web.Release.config` files under the `\configuration\connectionStrings` element.
   > - For SQL Server connection strings, replace the `{server-name}` with the name of your Azure SQL Database service. The `{server-admin-login}` and `{password}` with SQL Server account credentials.
   
   > **Note:** For information on deploying Sitecore databases to Azure, see the section [How To Deploy Sitecore Databases](#how-to-deploy-sitecore-databases).
    
4. In the **ASP.NET Web Application** project, include the `Startup.cmd` file in the the `\bin` folder.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-03.png)

5. In the **Azure Cloud Service** project, modify the `ServiceDefinition.csdef` file under the `WebRole` element. Add the following task definition to execute the `Startup.cmd` file:

    ```xml
    <ServiceDefinition>
      <WebRole>
      ...
        <Startup>
          <Task commandLine="Startup.cmd" executionContext="elevated" taskType="simple" />
        </Startup>
      ...
      </WebRole>
    </ServiceDefinition>
    ```

6. In the **ASP.NET Web Application** project, right-click the `App_Data` item. Add the `license.xml` and `webdav.lic` files using the **Add** -> **Existing Item...** command in the context menu.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-04.png)
   
7. Log in to the **Microsoft Azure Portal** using the https://portal.azure.com URL.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-01.png)

8. In the **Jumpbar**, click the **New** button, then select the **Data + Storage** section and click the **Redis Cache** button. The **New Redis Cache** blade appears.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-02.png)

9. In the **New Redis Cache** blade, fill in the **DNS name** field and configure the other section if needed, then click the **Create** button.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-03.png)

10. In the **Startboard**, click on the **my-website** Redis Cache tile.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-04.png)

11. In the **my-website Redis Cache** blade, click the **All settings** button. The **Settings** blade appears.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-05.png)
   
12. In the **Settings** blade, click on the **Properties** section and copy the **Host Name** field value.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-06.png)

13. In the **Settings** blade, click on the **Access keys** section and copy the **Primary** field value.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-Redis-07.png)

14. In the **Visual Studio**, click **Tools** -> **NuGet Package Manager** -> **Packages Manager Console**. Run the following command in the **Package Manager Console** window against the **ASP.NET Web Application** project:
    
   ```
   Install-Package Microsoft.Web.RedisSessionStateProvider
   ```
    
15. In the **ASP.NET Web Application** project, modify the `Web.config` file under the `\configuration\system.web\sessionState mode="Custom"` element. Move the entire `sessionState mode="Custom"` element from the `Web.config` file to both the `Web.Debug.config` and `Web.Release.config` files:   

   ```xml
   <configuration>
   ...
     <system.web>
       <sessionState mode="Custom" customProvider="MySessionStateStore">
       ...
       </sessionState>
     </system.web>
   </configuration>
   ```

16. In the **ASP.NET Web Application** project, modify both the `Web.Debug.config` and `Web.Release.config` files under the `\configuration\system.web\sessionState\providers\add` element. Insert the copied Azure Redis Cache Host Name into the `host` attribute and Primary Access Key into the `accessKey` one. Additionally, insert the `xdt:Transorm` attribute into the `sessionState` element:   

   ```xml
   <configuration>
   ...
     <system.web>
       <sessionState mode="Custom" customProvider="MySessionStateStore" xdt:Transform="Replace>
         <providers>
           <add name="MySessionStateStore" type="Microsoft.Web.Redis.RedisSessionStateProvider" host="{host-name}.redis.cache.windows.net" accessKey="{primary-access-key}" ssl="true" />
         </providers>
       </sessionState>
     </system.web>
   </configuration>
   ```

   > **Note:** For information on configuring ASP.NET Session State Provider for Azure Redis Cache, see the MSDN website: https://msdn.microsoft.com/en-us/library/azure/dn690522.aspx

17. In the **Visual Studio**, click **Tools** -> **NuGet Package Manager** -> **Packages Manager Console**. Run the following command in the **Package Manager Console** window against the **ASP.NET Web Application** project:

   ```xml
   Install-Package Sitecore.Azure.Diagnostics -Version 7.2.1
   ```

   > **Note:** Modify both the `Web.Debug.config` and `Web.Release.config` files under the `\configuration\appSettings` element. Replace the `{account-name}` with the name of your storage account, and the `{account-key}` with your account access key.  

18. In the **ASP.NET Web Application** project, right-click the `Web.Debug.config` and then `Web.Release.config` files. Use the **Preview Transform** command in the context menu to check that all transformations look correct as you expect them to be.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-05.png)
   
   > **Note:** For more details about Web.config transformation syntax for Web Project Deployment using Visual Studio, see the MSDN website: http://msdn.microsoft.com/en-us/library/dd465326.aspx

19. Right-click on the **Azure Cloud Service** project and click the **Set as StartUp Project** in the context menu. Use Azure Computer Emulator to run and debug Sitecore instance locally.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-06.png)

   > **Note:** For information regarding using Emulator Express to Run and Debug a Cloud Service Locally, see the MSDN website: https://msdn.microsoft.com/library/azure/dn339018.aspx

20. Right-click the **Azure Cloud Service** project and click the **Publish...**  in the context menu. The **Publishing Azure Application** dialog box appears.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-07.png)

21. In the **Publishing Azure Application** dialog box, publish the Sitecore solution to the Microsoft Azure Cloud Platform.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-08.png)
   
   > **Note:** For the basic information about the Publish Azure Application Wizard, see the MSDN website: http://msdn.microsoft.com/en-us/library/azure/hh535756.aspx

##How to Deploy Sitecore Databases

The recommended approach to deploy Sitecore databases to the Microsoft Azure SQL Database service is as follows:

1. Update the Sitecore database schema to fit the **Azure SQL Database** service requirements:
   - For Sitecore CMS 7.2 - execute the [SQL Azure \[Core, Master, Web\].sql](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SQL Azure [Core, Master, Web].sql) script on the Sitecore Core, Master and Web databases.
   - For Sitecore DMS 7.2 - execute the [SQL Azure \[Analytics\].sql](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SQL Azure [Analytics].sql) script on the Sitecore Analytics databases.

2. In the **SQL Server Management Studio**, in the **Object Explorer**, right-click a Sitecore database, and select **Tasks -> Export Data-tier Application...** in the context menu. The **Export data-tier Application** dialog box appears. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SSMS-01.png)

3. In the **Export data-tier Application** dialog box, click the **Next >** button to go to the **Export Settings** step. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SSMS-02.png)

4. In the **Export Settings** step, browse a location for a `*.bacpac` file to be stored in the file system. Then click the **Next >** button to go to the **Summary** step. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SSMS-03.png)

5. In the **Summary** step, click the **Finish** button to start creating a `*.bacpac` file. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SSMS-04.png)

6. In the **Results** step, click the **Close** button when the operation is complete. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/SSMS-05.png)

7. Repeat steps 2-5 for each Sitecore database you want to export.
 
8. In the **Visual Studio**, in the **Server Explorer**, right-click the `/Azure/Storage` item, and then click the **Create Storage Account...** in the context menu. The **Create Storage Account** dialog box appears. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-01.png)

9. In the **Create Storage Account** dialog box, fill in the **Subscription**, **Name**, **Region or Affinity Group** and **Replication** fields, and click the **Create** button. The **Azure Storage** service is created. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-02.png)

10. In the **Server Explorer**, right click the `/Azure/Storage/<StorageAccount>/Blobs` item, and then click the **Create Blob Container...** in the context menu. The **Create Blob Container** dialog box appears.
  
   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-03.png)
    
11. In the **Create Blob Container** dialog box, enter a name for the new blob container and click the **OK** button. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-04.png)
   
12. In the **Server Explorer**, double click the created container, and then click the **Upload Blob** button. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-05.png)

13. Upload the `*.bacpac` files to the container.

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/VS-SQL-06.png)

14. Log in to the **Microsoft Azure Portal** using the https://portal.azure.com URL. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-01.png)

15. In the **Jumpbar**, click the **New** button, then select the **Data + Storage** section and click the **SQL Database** button. The **SQL Database** blade appears. 

   ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-02.png)

16. In the **SQL Database** blade, click on the **Server** section. Then create a new server configuration. 

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-03.png)
  
  > **Note:** Sitecore recommends using [Azure SQL Database V12](http://azure.microsoft.com/en-us/documentation/articles/sql-database-v12-whats-new/) service to get the better experience.

17. In the **SQL Database** blade, fill in the **Name** field and configure the other section if needed, then click the **Create** button.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-04.png)

18. In the **Startboard**, click on the **Empty SQL Database** tile.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-05.png)

19. In the **Empty SQL Database** blade, click the **Delete** button.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-06.png)

20. In the **Jumpbar**, click the **Browser** button and select the **SQL servers** from the list. The **Browser** and **SQL servers** blades appear.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-07.png)

21. In the **SQL servers** blade, click on the SQL Server instance you created before. The **SQL Server** blade appears.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-08.png)

22. In the **SQL Server** blade, click the **Import database** button in the top menu. The **Import Database** blade appears.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-09.png)

23. In the **Import Database** blade, select the created storage account and container with `*.bacpac` file, then click the **OK** button.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-10.png)

24. In the **Import Database** blade, configure the **Pricing Tier** section and fill in the **Database Name**, **Server Admin Login** and **Password** fields, then click the **Create** button.

  ![](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/AzurePortal-SQL-11.png)

25. Repeat steps 22-24 for each Sitecore database you want to import.

##Download Options

Empty ASP.NET Web Application Projects:
- [Sitecore 7.2 ASP.NET MVC.zip](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore 7.2 ASP.NET MVC.zip)
- [Sitecore 7.2 ASP.NET Web Forms.zip](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore 7.2 ASP.NET Web Forms.zip)
- [Sitecore 7.2 ASP.NET Web Forms and MVC.zip](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore 7.2 ASP.NET Web Forms and MVC.zip)

Exported Sitecore databases as `*.bacpac` files:
- [Sitecore72.Core.bacpac](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore72.Core.bacpac)
- [Sitecore72.Master.bacpac](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore72.Master.bacpac)
- [Sitecore72.Web.bacpac](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore72.Web.bacpac)
- [Sitecore72.Analytics.bacpac](./media/how-to-deploy-sitecore-72-solution-to-microsoft-azure-cloud-service-using-visual-studio/Sitecore72.Analytics.bacpac)