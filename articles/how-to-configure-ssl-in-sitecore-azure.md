#How to configure SSL in Sitecore Azure

Sitecore CMS supports configuration of the Secure Socket Layer (SSL) encryption to secure the data sent across the internet.
The current article provides a list of techniques that can be used to manually create a self-signed SSL certificate, upload it to Azure Cloud Service, and configure an HTTPS (SSL) endpoint for a Sitecore solution when using the Sitecore Azure module.

**Note:** For the basic information about configuring SSL for an application in Azure, see Microsoft Azure website: 
https://azure.microsoft.com/en-us/documentation/articles/cloud-services-configure-ssl-certificate/

#Solution

The recommended approach to configure SSL in Sitecore Azure is as follows:

1. Run the **Internet Information Services (IIS)** and double-click on the **Server Certificates** feature.

2. In the **Actions** section, click the **Create Self-Signed Certificate**.

3. In the **Specify Friendly Name** dialog, fill a certificate name and click **OK** button.

4. Right-click on the created certificate and select **Export...** menu.

5. In the **Export Certificate** dialog, set a path for the `*.pfx` file (private key) and fill the **Password** fields.

6. Log in to the **Microsoft Azure Management Portal** using the https://manage.windowsazure.com URL.

7. In the **Cloud Service** section, select a cloud service entry that represents the Sitecore solution or create a custom Cloud Service.

   **Note:** For more details about using a custom Azure Cloud Service in Sitecore Azure, see the [How to use a custom Azure Storage Service in Sitecore Azure](how-to-use-a-custom-azure-cloud-service-in-sitecore-azure.md) article.