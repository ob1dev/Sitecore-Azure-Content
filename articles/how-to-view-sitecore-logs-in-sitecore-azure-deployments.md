#How to view Sitecore logs in Sitecore Azure deployments

The Sitecore Azure module automatically creates the [Microsoft Azure Storage Service](https://msdn.microsoft.com/en-us/library/azure/gg433040.aspx) during deployment and then uses this service to store Sitecore log entries and other diagnostic data. The data is organized into tables.

Here is the list of all the tables used for Sitecore Azure Deployment diagnostics:

| Table Name                           | Table Сontent                            |
| ------------------------------------ | ---------------------------------------- |
| WADDiagnosticInfrastructureLogsTable | Windows Diagnostic Infrastructure Logs   |
| WADDirectoriesTable                  | Internet Information Services (IIS) Logs |
| WADLogsTable                         | Sitecore Logs                            |
| WADPerformanceCountersTable          | Windows Performance Counters             |       
| WADWindowsEventLogsTable             | Windows Event Logs                       |

This article lists various ways that you can use to explore the WADLogsTable table in the Microsoft Azure Storage, which contains Sitecore logs.

##Solution

Use one of the following approaches to view Sitecore logs in the WADLogsTable table:
- Use the [Sitecore Log Analyzer](https://marketplace.sitecore.net/Modules/Sitecore_Log_Analyzer.aspx) tool, which parses and analyzes Sitecore logs from the Azure Table Storage source.
- Use the [Microsoft Azure Storage Explorer](http://blogs.msdn.com/b/windowsazurestorage/archive/2014/03/11/windows-azure-storage-explorers-2014.aspx) tool, which provides the ability to enumerate and access the Table data.
- Use the [Sitecore Azure Diagnostics](https://marketplace.sitecore.net/en/Modules/S/Sitecore_Azure_Diagnostics.aspx) module, which outputs Sitecore Log statements to Microsoft Azure Storage Service using the Block Blobs. 