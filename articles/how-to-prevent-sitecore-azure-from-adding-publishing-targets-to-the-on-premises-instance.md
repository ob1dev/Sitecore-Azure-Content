#How to prevent Sitecore Azure from adding Publishing Targets to the on-premises instance

The Sitecore Azure module automatically adds a remote Sitecore Web database to the on-premises Sitecore instance (Deployment Center) during either the Editing or Delivery Farm deployment.

As a result, the on-premises Sitecore instance can publish to the remote Sitecore Web database on both Editing and Delivery Farms.

The module performs the following steps:

1. Updates the `\App_Config\ConnectionStrings.config` file with a connection string of the Sitecore Web database, which is hosted in [Microsoft Azure SQL Databases Service](https://msdn.microsoft.com/en-us/library/azure/ee336279.aspx).

2. Updates the `\App_Config\Include\Sitecore.Azure.config` file under the `databases` section. Adds a database definition for the remote Sitecore Web database.

3. Inserting a new `Publishing Target` item under the `/sitecore/system/Publishing targets` one in the Sitecore Master database.

This article provides a list of techniques that can be used to prevent adding a Publishing Target to on-premises when using the Sitecore Azure module.

##Solution

The recommended approach to prevent adding a Publishing Target in Sitecore Azure is as follows:

1. Modify the `\App_Config\Include\Sitecore.Azure.config` file.

2. Comment out the `Sitecore.Azure.Pipelines.Configuration.PublishingTarget.SaveChanges` processors in the `AddPublishingTarget` pipeline:

   ```xml
   <AddPublishingTarget>
   ...
     <!--<processor type="Sitecore.Azure.Pipelines.Configuration.PublishingTarget.SaveChanges, Sitecore.Azure" />-->
   </AddPublishingTarget>
   ```