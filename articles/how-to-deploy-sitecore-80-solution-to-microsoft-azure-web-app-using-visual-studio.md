#How to deploy Sitecore 8.0 solution to Microsoft Azure Web App using Visual Studio

> **NB:** Deploying Sitecore application into Azure Web Apps currently works for non-scaled enviroment only due to persistence of certain types of data by Sitecore application into the file system. When scaled, Web Apps share file system but Sitecore instances don't support that. 

After developing a Sitecore solution in Visual Studio, it is possible to manually publish this solution to the Microsoft Azure Cloud Platform.

This article provides a list of techniques that can be used to deploy a Sitecore solution to Microsoft Azure using Microsoft Visual Studio.

> **Important:** It is highly recommended that you get acquainted with the [Compute Hosting Options Provided by Azure](http://azure.microsoft.com/en-us/documentation/articles/fundamentals-application-models/) and [Microsoft Azure Fundamentals](http://www.microsoftvirtualacademy.com/colleges/Azure-fundamentals) before following the instructions in this article.

**Requirements:**
- A work or school account / Microsoft account and a Microsoft Azure subscription with the following Azure services enabled:
  - [Azure Web App](https://msdn.microsoft.com/en-us/library/azure/dn948515.aspx)
  - [Azure Storage](https://msdn.microsoft.com/en-us/library/azure/gg433040.aspx)
  - [Azure SQL Database](https://msdn.microsoft.com/en-us/library/azure/ee336279.aspx)
- Microsoft Visual Studio 2013
- Microsoft Azure SDK 2.6 for .NET or newer
- Microsoft Azure Tool for Visual Studio 2013 
- Microsoft SQL Server Management Studio 2014
- MongoDB 2.6.1
- Sitecore® Experience Platform™ 8.0 rev. 150621 (8.0 Update-4) or higher

> **Note:** To download the latest version of the Microsoft Azure SDK and Tool for Visual Studio, follow this link: http://azure.microsoft.com/en-us/downloads/

##Instructions

The recommended approach to deploy a Sitecore solution to Microsoft Azure using Visual Studio is as follows:

1. Log in to the **Microsoft Azure Portal** using the https://portal.azure.com URL.
  
   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-01.png)
  
2. In the **Jumpbar**, click the **New** button, then select the **Web + Mobile** section and click the **Web App** button. The **Web App** blade appears.
   
   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-02.png)
   
3. In the **Web App** blade, fill in the **URL** field and configure the other section if needed, then click the **Create** button. 
 
   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-03.png)
 
4. In the **Startboard**, click on the **Web App** tile.

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-04.png)

5. In the **Web App** blade, click the **All settings** button and select the **Application settings** section.
 
   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-05.png)
 
6. In the **Application settings** blade, configure the following groups and save the changes.
 
   - In the **General settings** group:
     + Set the **PHP version** switcher to the **Off** value. 
     + Set the **Platform** switcher to the the **64-bit** value.
     + Set the **Always On** switcher to the the **On** value.
     + \[Optional\] Set the **Remote debugging** switcher to the **On** value and select the Visual Studio version.
   
   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-06.png)
   
   - In the **Connection strings** group:
     + Add the `core`, `master`, `web`, `reporting` and `session` SQL Database connection strings.
     + Add the `analytics`, `tracking.live`, `tracking.history` and `tracking.contact` MongoDB connection strings.   

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/AzurePortal-WebApp-07.png)
  
   > **Note:** For information on deploying Sitecore databases to Azure, see the section [How to deploy Sitecore databases to Azure SQL Database](how-to-deploy-sitecore-databases-to-azure-sql-database.md).
      
   ```xml
   Server=tcp:{server-name}.database.windows.net,1433;Database=Sitecore.Core;User ID={server-admin-login}@{server-name};Password={password};Trusted_Connection=False;Encrypt=True
   Server=tcp:{server-name}.database.windows.net,1433;Database=Sitecore.Master;User ID={server-admin-login}@{server-name};Password={password};Trusted_Connection=False;Encrypt=True
   Server=tcp:{server-name}.database.windows.net,1433;Database=Sitecore.Web;User ID={server-admin-login}@{server-name};Password={password};Trusted_Connection=False;Encrypt=True
   Server=tcp:{server-name}.database.windows.net,1433;Database=Sitecore.Reporting;User ID={server-admin-login}@{server-name};Password={password};Trusted_Connection=False;Encrypt=True
   Server=tcp:{server-name}.database.windows.net,1433;Database=Sitecore.Session;User ID={server-admin-login}@{server-name};Password={password};Trusted_Connection=False;Encrypt=True
   
   mongodb://{user-name}:{password}@{host}/sitecore_analytics
   mongodb://{user-name}:{password}@{host}/sitecore_tracking_lives
   mongodb://{user-name}:{password}@{host}/sitecore_tracking_historys
   mongodb://{user-name}:{password}@{host}/sitecore_tracking_contact 
   ```
   
   > **Note:** Use the above templates as an example of default Sitecore connection strings:
   > - For SQL Database connection strings, replace the `{server-name}` with the name of your Azure SQL Database service. The `{server-admin-login}` and `{password}` with SQL Server account credentials. 
   > - For MongoDB connection strings, replace the `{host}` with the URL of your Mongo service. The `{user-name}` and `{password}` with your Mongo account credentials.
   
7. In the **ASP.NET Web Application** project, include the default Sitecore files, directories and subdirectories. 

   > **Note:** For information on creating an ASP.NET Web Application project for Sitecore, see the section [How To Create ASP.NET Web Application Project](how-to-create-aspnet-web-application-project.md).

   - For a **Content Delivery** environment:
   
     + \App_Browsers
     + \App_Config
     + \App_Data
     + \Areas
     + \bin
     + \Controllers
     + \layouts
     + \Models
     + \sitecore\services
     + \sitecore modules
     + \sitecore_files
     + \temp
     + \upload
     + \Views
     + \xsl
     + \Default.aspx
     + \default.css
     + \default.htm.sitedown
     + \default.js
     + \Global.asax
     + \Web.config
     + \webedit.css

   - For a **Content Management** environment, additionally include the following directories and files:
   
     + \sitecore\admin
     + \sitecore\Copyright
     + \sitecore\debug
     + \sitecore\images
     + \sitecore\login
     + \sitecore\portal
     + \sitecore\samples
     + \sitecore\service
     + \sitecore\shell
     + \sitecore\blocked.aspx
     + \sitecore\default.aspx
     + \sitecore\no.css

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/VS-01.png)

   > **Important:** Visual Studio may freeze when including the entire `\sitecore\shell` directory at once because it contains a lot of files and subdirectories. Try to split all the subdirectories into portions, and then add them one by one.

8. For a **Content Management** environment, Visual Studio may throw the following build errors:   
       
   ```
   Build: Cannot compile external modules unless the '--module' flag is provided.
   ```   
    
   To address the above error, in the **ASP.NET Web Application** project's properties, switch to the **TypeScript Build** section and set the **Module system** property to the **AMD** value. Otherwise, exclude the following files from the project:
   - \sitecore\shell\client\Speak\Assets\lib\core\1.2\SitecoreSpeak.ts
   - \sitecore\shell\client\Speak\Assets\lib\core\1.2\SitecoreSpeak.d.ts
    
   ```
   Project file must include the .NET Framework assembly 'WindowsBase, PresentationCore, PresentationFramework' in the reference list.    
   ```
    
   To address the above error, in the **Solution Explorer** window, set the **Build Action** property to the **Content** value for the following item:
   - \sitecore\shell\ClientBin\EmptySplashScreen.xaml 
    
9. In the **Visual Studio**, click the **Tools** -> **NuGet Package Manager** -> **Packages Manager Console**. Run the following command in the **Package Manager Console** window against the **ASP.NET Web Application** project:     
  
   ```PowerShell
   Install-Package Sitecore.Azure.Setup -Version 8.0.1
   ```
   
10. In the **ASP.NET Web Application** project, right-click the `App_Data` item. Add the `license.xml` and `webdav.lic` files using the **Add** -> **Existing Item...** command in the context menu.

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/VS-02.png)

11. In the **ASP.NET Web Application** project, right-click the `Web.Debug.config` and then `Web.Release.config` files. Use the **Preview Transform** command in the context menu to check that all transformations look correct as you expect them to be.

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/VS-03.png)

   > **Note:** For more details about Web.config transformation syntax for Web Project Deployment using Visual Studio, see the MSDN website: http://msdn.microsoft.com/en-us/library/dd465326.aspx
 
12. Right-click the **ASP.NET Web Application** project, and then click the **Publish...**  in the context menu. The **Publish Web** dialog box appears.     

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/VS-04.png)

13. In the **Publish Web** dialog box, in the **Profile** step, click the **Microsoft Azure Web Apps** option and select the Web App that is created in created in Microsoft Azure Portal. 

   ![](./media/how-to-deploy-sitecore-80-solution-to-microsoft-azure-web-app-using-visual-studio/VS-05.png)

   > **Note:** For the basic information about the Publish Web Wizard, see the MSDN website: https://msdn.microsoft.com/en-us/library/dd465337(v=vs.110).aspx 
