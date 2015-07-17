/****** Script Date: 5/27/2014 4:03:42 PM ******/

USE [Sitecore_analytics]
GO

/****** Drop and Recreate Trigger without IsNotForReplication (NOT FOR REPLICATION) ******/

/****** Object:  Trigger [dbo].[UpdateItemUrls].[UpdateItemUrls] ******/
DROP TRIGGER [dbo].[UpdateItemUrls]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[UpdateItemUrls] ON [dbo].[Pages] 
FOR INSERT AS
BEGIN
  INSERT INTO ItemUrls (ItemId, Url) 
  SELECT INSERTED.ItemId, MIN(CONVERT(varchar(800), INSERTED.Url)) Url 
  FROM INSERTED LEFT JOIN ItemUrls ON INSERTED.ItemId = ItemUrls.ItemId WHERE ItemUrls.ItemId IS NULL
  GROUP BY INSERTED.ItemId
END

GO
/*******************************************************************/




/****** Drop and Rebuilt Indexes without IsPadded (PAD_INDEX = OFF) and FillFactor (FILLFACTOR = 0) ******/

/****** Object:  Index [dbo].[AutomationStates].[IX_ByAutomation] ******/
CREATE NONCLUSTERED INDEX [IX_ByAutomation] ON [dbo].[AutomationStates]
(
	[AutomationId] ASC,
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_ByAutomationState] ******/
CREATE NONCLUSTERED INDEX [IX_ByAutomationState] ON [dbo].[AutomationStates]
(
	[StateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_ByTestSet] ******/
CREATE NONCLUSTERED INDEX [IX_ByTestSet] ON [dbo].[AutomationStates]
(
	[TestSetId] ASC,
	[TestValues] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_ByUser] ******/
CREATE NONCLUSTERED INDEX [IX_ByUser] ON [dbo].[AutomationStates]
(
	[UserName] ASC
)
WHERE ([UserName] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[AutomationStates]
(
	[VisitorId] ASC
)
WHERE ([VisitorId] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[AutomationStates]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[AutomationStates].[IX_State] ******/
CREATE NONCLUSTERED INDEX [IX_State] ON [dbo].[AutomationStates]
(
	[State] ASC,
	[WakeupDateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Cache_TrafficByDay].[IX_ByLanguage] ******/
CREATE NONCLUSTERED INDEX [IX_ByLanguage] ON [dbo].[Cache_TrafficByDay]
(
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_TrafficByDay].[IX_ByMultisite] ******/
CREATE NONCLUSTERED INDEX [IX_ByMultisite] ON [dbo].[Cache_TrafficByDay]
(
	[Multisite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_TrafficByDay].[IX_ByTrafficType] ******/
CREATE NONCLUSTERED INDEX [IX_ByTrafficType] ON [dbo].[Cache_TrafficByDay]
(
	[TrafficType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_TrafficByDay].[IX_CampaignId] ******/
CREATE NONCLUSTERED INDEX [IX_CampaignId] ON [dbo].[Cache_TrafficByDay]
(
	[CampaignId] ASC
)
INCLUDE ( 	[Visits],
	[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Cache_ValueBySource].[IX_ByLanguage] ******/
CREATE NONCLUSTERED INDEX [IX_ByLanguage] ON [dbo].[Cache_ValueBySource]
(
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_ValueBySource].[IX_ByMultisite] ******/
CREATE NONCLUSTERED INDEX [IX_ByMultisite] ON [dbo].[Cache_ValueBySource]
(
	[Multisite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_ValueBySource].[IX_ByTrafficType] ******/
CREATE NONCLUSTERED INDEX [IX_ByTrafficType] ON [dbo].[Cache_ValueBySource]
(
	[TrafficType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByCampaignId] ******/
CREATE NONCLUSTERED INDEX [IX_ByCampaignId] ON [dbo].[Cache_VisitEvents]
(
	[CampaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByItem] ******/
CREATE NONCLUSTERED INDEX [IX_ByItem] ON [dbo].[Cache_VisitEvents]
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByLanguage] ******/
CREATE NONCLUSTERED INDEX [IX_ByLanguage] ON [dbo].[Cache_VisitEvents]
(
	[Language] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByMultisite] ******/
CREATE NONCLUSTERED INDEX [IX_ByMultisite] ON [dbo].[Cache_VisitEvents]
(
	[Multisite] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByPageEventDefinition] ******/
CREATE NONCLUSTERED INDEX [IX_ByPageEventDefinition] ON [dbo].[Cache_VisitEvents]
(
	[PageEventDefinitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByTrafficType] ******/
CREATE NONCLUSTERED INDEX [IX_ByTrafficType] ON [dbo].[Cache_VisitEvents]
(
	[TrafficType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Cache_VisitEvents].[IX_ByVisit] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisit] ON [dbo].[Cache_VisitEvents]
(
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Campaigns].[IX_Category1] ******/
CREATE NONCLUSTERED INDEX [IX_Category1] ON [dbo].[Campaigns]
(
	[Category1Id] ASC,
	[CampaignId] ASC
)
INCLUDE ( 	[Category2Id],
	[Category3Id],
	[CampaignName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Campaigns].[IX_Category2] ON [dbo].[Campaigns] ******/
CREATE NONCLUSTERED INDEX [IX_Category2] ON [dbo].[Campaigns]
(
	[Category1Id] ASC,
	[Category2Id] ASC,
	[CampaignId] ASC
)
INCLUDE ( 	[Category3Id],
	[CampaignName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Campaigns].[IX_Category3] ******/
CREATE NONCLUSTERED INDEX [IX_Category3] ON [dbo].[Campaigns]
(
	[Category1Id] ASC,
	[Category2Id] ASC,
	[Category3Id] ASC,
	[CampaignId] ASC
)
INCLUDE ( 	[CampaignName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[PageEventDefinitions].[IX_Goals] ******/
CREATE NONCLUSTERED INDEX [IX_Goals] ON [dbo].[PageEventDefinitions]
(
	[IsGoal] ASC
)
INCLUDE ( 	[PageEventDefinitionId],
	[Name]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[PageEvents].[IX_ByDate] ******/
CREATE NONCLUSTERED INDEX [IX_ByDate] ON [dbo].[PageEvents]
(
	[DateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[PageEvents].[IX_ByDefinition] ******/
CREATE NONCLUSTERED INDEX [IX_ByDefinition] ON [dbo].[PageEvents]
(
	[PageEventDefinitionId] ASC,
	[VisitId] ASC,
	[DataKey] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[PageEvents].[IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[PageEvents]
(
	[VisitorId] ASC,
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[PageEvents].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[PageEvents]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Pages].[IX_ByDate] ******/
CREATE NONCLUSTERED INDEX [IX_ByDate] ON [dbo].[Pages]
(
	[DateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Pages].[IX_ByTestSet] ******/
CREATE NONCLUSTERED INDEX [IX_ByTestSet] ON [dbo].[Pages]
(
	[TestSetId] ASC,
	[TestValues] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Pages].[IX_ByUrl] ******/
CREATE NONCLUSTERED INDEX [IX_ByUrl] ON [dbo].[Pages]
(
	[Url] ASC,
	[VisitId] ASC,
	[VisitPageIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Pages].[IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[Pages]
(
	[VisitorId] ASC,
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Pages].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[Pages]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Profiles].[IX_ByVisitId] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitId] ON [dbo].[Profiles]
(
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[Profiles]
(
	[VisitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Profiles].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[Profiles]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Campaigns].[IX_Order] ON [dbo].[Visitors] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[Visitors]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[VisitorTags].[IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[VisitorTags]
(
	[VisitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[VisitorTags].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[VisitorTags]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[IX_ByCampaign] ******/
CREATE NONCLUSTERED INDEX [IX_ByCampaign] ON [dbo].[Visits]
(
	[CampaignId] ASC,
	[StartDateTime] ASC
)
WHERE ([CampaignId] IS NOT NULL AND [CampaignId]<>'00000000-0000-0000-0000-000000000000')
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_ByDate] ******/
CREATE NONCLUSTERED INDEX [IX_ByDate] ON [dbo].[Visits]
(
	[StartDateTime] ASC,
	[VisitorId] ASC,
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/

/****** Object:  Index [dbo].[Visits].[IX_ByLocation] ******/
CREATE NONCLUSTERED INDEX [IX_ByLocation] ON [dbo].[Visits]
(
	[LocationId] ASC,
	[StartDateTime] ASC
)
INCLUDE ( 	[VisitorId],
	[VisitId],
	[Region],
	[BusinessName],
	[City],
	[Latitude],
	[Longitude],
	[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_ByReferringSite] ******/
CREATE NONCLUSTERED INDEX [IX_ByReferringSite] ON [dbo].[Visits]
(
	[ReferringSiteId] ASC
)
INCLUDE ( 	[VisitId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_ByState] ******/
CREATE NONCLUSTERED INDEX [IX_ByState] ON [dbo].[Visits]
(
	[State] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_ByTestSet] ******/
CREATE NONCLUSTERED INDEX [IX_ByTestSet] ON [dbo].[Visits]
(
	[TestSetId] ASC,
	[TestValues] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_ByVisitor] ******/
CREATE NONCLUSTERED INDEX [IX_ByVisitor] ON [dbo].[Visits]
(
	[VisitorId] ASC,
	[VisitId] ASC
)
INCLUDE ( 	[VisitorVisitIndex],
	[StartDateTime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_FirstVisits] ******/
CREATE NONCLUSTERED INDEX [IX_FirstVisits] ON [dbo].[Visits]
(
	[VisitorVisitIndex] ASC,
	[VisitorId] ASC,
	[TrafficType] ASC
)
INCLUDE ( 	[StartDateTime],
	[Value]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

/****** Object:  Index [dbo].[Visits].[IX_Order] ******/
CREATE UNIQUE CLUSTERED INDEX [IX_Order] ON [dbo].[Visits]
(
	[rn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = ON, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/




/****** Dropped and Re-create Constrains without IsPadded (PAD_INDEX = OFF) and FillFactor (FILLFACTOR = 0) ******/

/****** Object:  Index [dbo].[Automations].[PK_Automation] ******/
ALTER TABLE [dbo].[AutomationStates] DROP CONSTRAINT [FK_MarketingAutomationStates_MarketingAutomations]
GO

ALTER TABLE [dbo].[Automations] DROP CONSTRAINT [PK_Automation]
GO

ALTER TABLE [dbo].[Automations] ADD  CONSTRAINT [PK_Automation] PRIMARY KEY CLUSTERED 
(
	[AutomationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[AutomationStates]  WITH NOCHECK ADD  CONSTRAINT [FK_MarketingAutomationStates_MarketingAutomations] FOREIGN KEY([AutomationId])
REFERENCES [dbo].[Automations] ([AutomationId])
GO

ALTER TABLE [dbo].[AutomationStates] NOCHECK CONSTRAINT [FK_MarketingAutomationStates_MarketingAutomations]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[AutomationStates].[PK_AutomationState] ******/
ALTER TABLE [dbo].[AutomationStates] DROP CONSTRAINT [PK_AutomationState]
GO

ALTER TABLE [dbo].[AutomationStates] ADD  CONSTRAINT [PK_AutomationState] PRIMARY KEY NONCLUSTERED 
(
	[AutomationStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_Browsers] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Browsers]
GO

ALTER TABLE [dbo].[Browsers] DROP CONSTRAINT [PK_Browsers]
GO

ALTER TABLE [dbo].[Browsers] ADD  CONSTRAINT [PK_Browsers] PRIMARY KEY CLUSTERED 
(
	[BrowserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Browsers] FOREIGN KEY([BrowserId])
REFERENCES [dbo].[Browsers] ([BrowserId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Browsers]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Campaigns].[PK_Campaign] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Campaigns]
GO

ALTER TABLE [dbo].[Automations] DROP CONSTRAINT [FK_Automation_Campaign]
GO

ALTER TABLE [dbo].[Campaigns] DROP CONSTRAINT [PK_Campaign]
GO

ALTER TABLE [dbo].[Campaigns] ADD  CONSTRAINT [PK_Campaign] PRIMARY KEY CLUSTERED 
(
	[CampaignId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Automations]  WITH NOCHECK ADD  CONSTRAINT [FK_Automation_Campaign] FOREIGN KEY([Campaignid])
REFERENCES [dbo].[Campaigns] ([CampaignId])
GO

ALTER TABLE [dbo].[Automations] NOCHECK CONSTRAINT [FK_Automation_Campaign]
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Campaigns] FOREIGN KEY([CampaignId])
REFERENCES [dbo].[Campaigns] ([CampaignId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Campaigns]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_GeoIps] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_GeoIps]
GO

ALTER TABLE [dbo].[GeoIps] DROP CONSTRAINT [PK_GeoIps]
GO

ALTER TABLE [dbo].[GeoIps] ADD  CONSTRAINT [PK_GeoIps] PRIMARY KEY CLUSTERED 
(
	[Ip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_GeoIps] FOREIGN KEY([Ip])
REFERENCES [dbo].[GeoIps] ([Ip])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_GeoIps]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[ItemUrls].[PK_ItemUrls] ******/
ALTER TABLE [dbo].[ItemUrls] DROP CONSTRAINT [PK_ItemUrls]
GO

ALTER TABLE [dbo].[ItemUrls] ADD  CONSTRAINT [PK_ItemUrls] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_Keywords] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Keywords]
GO

ALTER TABLE [dbo].[Keywords] DROP CONSTRAINT [PK_Keywords]
GO

ALTER TABLE [dbo].[Keywords] ADD  CONSTRAINT [PK_Keywords] PRIMARY KEY CLUSTERED 
(
	[KeywordsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Keywords] FOREIGN KEY([KeywordsId])
REFERENCES [dbo].[Keywords] ([KeywordsId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Keywords]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_Location] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Locations]
GO

ALTER TABLE [dbo].[NotificationSubscriptions] DROP CONSTRAINT [FK_NotificationSubscriptions_Locations]
GO

ALTER TABLE [dbo].[Locations] DROP CONSTRAINT [PK_Location]
GO

ALTER TABLE [dbo].[Locations] ADD  CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[NotificationSubscriptions]  WITH NOCHECK ADD  CONSTRAINT [FK_NotificationSubscriptions_Locations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO

ALTER TABLE [dbo].[NotificationSubscriptions] NOCHECK CONSTRAINT [FK_NotificationSubscriptions_Locations]
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Locations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Locations] ([LocationId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Locations]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[NotificationSubscriptions].[PK_NotificationSubscriptions]M ******/
ALTER TABLE [dbo].[NotificationSubscriptions] DROP CONSTRAINT [PK_NotificationSubscriptions]
GO

ALTER TABLE [dbo].[NotificationSubscriptions] ADD  CONSTRAINT [PK_NotificationSubscriptions] PRIMARY KEY CLUSTERED 
(
	[NotificationSubscriptionsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[OS].[PK_OS] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_OS]
GO

ALTER TABLE [dbo].[OS] DROP CONSTRAINT [PK_OS]
GO

ALTER TABLE [dbo].[OS] ADD  CONSTRAINT [PK_OS] PRIMARY KEY CLUSTERED 
(
	[OsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_OS] FOREIGN KEY([OsId])
REFERENCES [dbo].[OS] ([OsId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_OS]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[PageEventDefinitions].[PK_PageEventDefinitions] ******/
ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [FK_PageEvents_PageEventDefinitions]
GO

ALTER TABLE [dbo].[PageEventDefinitions] DROP CONSTRAINT [PK_PageEventDefinitions]
GO

ALTER TABLE [dbo].[PageEventDefinitions] ADD  CONSTRAINT [PK_PageEventDefinitions] PRIMARY KEY CLUSTERED 
(
	[PageEventDefinitionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[PageEvents]  WITH NOCHECK ADD  CONSTRAINT [FK_PageEvents_PageEventDefinitions] FOREIGN KEY([PageEventDefinitionId])
REFERENCES [dbo].[PageEventDefinitions] ([PageEventDefinitionId])
GO

ALTER TABLE [dbo].[PageEvents] NOCHECK CONSTRAINT [FK_PageEvents_PageEventDefinitions]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[PageEvents].[PK_PageEvents] ******/
ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [PK_PageEvents]
GO

ALTER TABLE [dbo].[PageEvents] ADD  CONSTRAINT [PK_PageEvents] PRIMARY KEY NONCLUSTERED 
(
	[PageEventId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[PageEvents].[PK_Pages] ******/
ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [FK_PageEvents_Pages]
GO

ALTER TABLE [dbo].[Pages] DROP CONSTRAINT [PK_Pages]
GO

ALTER TABLE [dbo].[Pages] ADD  CONSTRAINT [PK_Pages] PRIMARY KEY NONCLUSTERED 
(
	[PageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[PageEvents]  WITH NOCHECK ADD  CONSTRAINT [FK_PageEvents_Pages] FOREIGN KEY([PageId])
REFERENCES [dbo].[Pages] ([PageId])
GO

ALTER TABLE [dbo].[PageEvents] NOCHECK CONSTRAINT [FK_PageEvents_Pages]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Profiles].[PK_Profile] ******/
ALTER TABLE [dbo].[Profiles] DROP CONSTRAINT [PK_Profile]
GO

ALTER TABLE [dbo].[Profiles] ADD  CONSTRAINT [PK_Profile] PRIMARY KEY NONCLUSTERED 
(
	[ProfileId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[ReferringSites].[PK_ReferringSites] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_ReferringSites]
GO

ALTER TABLE [dbo].[ReferringSites] DROP CONSTRAINT [PK_ReferringSites]
GO

ALTER TABLE [dbo].[ReferringSites] ADD  CONSTRAINT [PK_ReferringSites] PRIMARY KEY CLUSTERED 
(
	[ReferringSiteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_ReferringSites] FOREIGN KEY([ReferringSiteId])
REFERENCES [dbo].[ReferringSites] ([ReferringSiteId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_ReferringSites]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Screens].[PK_Screens]    Script Date: 5/27/2014 5:10:47 PM ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Screens]
GO

ALTER TABLE [dbo].[Screens] DROP CONSTRAINT [PK_Screens]
GO

ALTER TABLE [dbo].[Screens] ADD  CONSTRAINT [PK_Screens] PRIMARY KEY CLUSTERED 
(
	[ScreenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Screens] FOREIGN KEY([ScreenId])
REFERENCES [dbo].[Screens] ([ScreenId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Screens]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Status].[PK_Status] ******/
ALTER TABLE [dbo].[Status] DROP CONSTRAINT [PK_Status]
GO

ALTER TABLE [dbo].[Status] ADD  CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[TestDefinitions].[PK_TestDefinitions] ******/
ALTER TABLE [dbo].[TestDefinitions] DROP CONSTRAINT [PK_TestDefinitions]
GO

ALTER TABLE [dbo].[TestDefinitions] ADD  CONSTRAINT [PK_TestDefinitions] PRIMARY KEY CLUSTERED 
(
	[ValueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[TrafficTypes].[PK_TrafficTypes] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_TrafficTypes]
GO

ALTER TABLE [dbo].[ReferringSites] DROP CONSTRAINT [FK_ReferringSites_TrafficTypes]
GO

ALTER TABLE [dbo].[TrafficTypes] DROP CONSTRAINT [PK_TrafficTypes]
GO

ALTER TABLE [dbo].[TrafficTypes] ADD  CONSTRAINT [PK_TrafficTypes] PRIMARY KEY CLUSTERED 
(
	[TrafficType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[ReferringSites]  WITH NOCHECK ADD  CONSTRAINT [FK_ReferringSites_TrafficTypes] FOREIGN KEY([TrafficType])
REFERENCES [dbo].[TrafficTypes] ([TrafficType])
GO

ALTER TABLE [dbo].[ReferringSites] NOCHECK CONSTRAINT [FK_ReferringSites_TrafficTypes]
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_TrafficTypes] FOREIGN KEY([TrafficType])
REFERENCES [dbo].[TrafficTypes] ([TrafficType])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_TrafficTypes]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_UserAgents] ******/
ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_UserAgents]
GO

ALTER TABLE [dbo].[UserAgents] DROP CONSTRAINT [PK_UserAgents]
GO

ALTER TABLE [dbo].[UserAgents] ADD  CONSTRAINT [PK_UserAgents] PRIMARY KEY CLUSTERED 
(
	[UserAgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_UserAgents] FOREIGN KEY([UserAgentId])
REFERENCES [dbo].[UserAgents] ([UserAgentId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_UserAgents]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[VisitorClassifications].[PK_VisitorClassification] ******/
ALTER TABLE [dbo].[UserAgents] DROP CONSTRAINT [FK_UserAgents_VisitorClassification]
GO

ALTER TABLE [dbo].[Visitors] DROP CONSTRAINT [FK_Visitors_VisitorClassification1]
GO

ALTER TABLE [dbo].[Visitors] DROP CONSTRAINT [FK_Visitors_VisitorClassification]
GO

ALTER TABLE [dbo].[Locations] DROP CONSTRAINT [FK_Locations_VisitorClassification]
GO

ALTER TABLE [dbo].[GeoIps] DROP CONSTRAINT [FK_GeoIps_VisitorClassification]
GO

ALTER TABLE [dbo].[VisitorClassifications] DROP CONSTRAINT [PK_VisitorClassification]
GO

ALTER TABLE [dbo].[VisitorClassifications] ADD  CONSTRAINT [PK_VisitorClassification] PRIMARY KEY CLUSTERED 
(
	[VisitorClassification] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO


ALTER TABLE [dbo].[GeoIps]  WITH NOCHECK ADD  CONSTRAINT [FK_GeoIps_VisitorClassification] FOREIGN KEY([VisitorClassification])
REFERENCES [dbo].[VisitorClassifications] ([VisitorClassification])
GO

ALTER TABLE [dbo].[GeoIps] NOCHECK CONSTRAINT [FK_GeoIps_VisitorClassification]
GO


ALTER TABLE [dbo].[Locations]  WITH NOCHECK ADD  CONSTRAINT [FK_Locations_VisitorClassification] FOREIGN KEY([VisitorClassification])
REFERENCES [dbo].[VisitorClassifications] ([VisitorClassification])
GO

ALTER TABLE [dbo].[Locations] NOCHECK CONSTRAINT [FK_Locations_VisitorClassification]
GO

ALTER TABLE [dbo].[Visitors]  WITH NOCHECK ADD  CONSTRAINT [FK_Visitors_VisitorClassification] FOREIGN KEY([VisitorClassification])
REFERENCES [dbo].[VisitorClassifications] ([VisitorClassification])
GO

ALTER TABLE [dbo].[Visitors] NOCHECK CONSTRAINT [FK_Visitors_VisitorClassification]
GO

ALTER TABLE [dbo].[Visitors]  WITH NOCHECK ADD  CONSTRAINT [FK_Visitors_VisitorClassification1] FOREIGN KEY([OverrideVisitorClassification])
REFERENCES [dbo].[VisitorClassifications] ([VisitorClassification])
GO

ALTER TABLE [dbo].[Visitors] NOCHECK CONSTRAINT [FK_Visitors_VisitorClassification1]
GO

ALTER TABLE [dbo].[UserAgents]  WITH NOCHECK ADD  CONSTRAINT [FK_UserAgents_VisitorClassification] FOREIGN KEY([VisitorClassification])
REFERENCES [dbo].[VisitorClassifications] ([VisitorClassification])
GO

ALTER TABLE [dbo].[UserAgents] NOCHECK CONSTRAINT [FK_UserAgents_VisitorClassification]
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visitors].[PK_Visitors] ******/
ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [FK_PageEvents_Visitors]
GO

ALTER TABLE [dbo].[AutomationStates] DROP CONSTRAINT [FK_AutomationStates_Visitors]
GO

ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [FK_Visits_Visitors]
GO

ALTER TABLE [dbo].[VisitorTags] DROP CONSTRAINT [FK_VisitorTags_Visitors]
GO

ALTER TABLE [dbo].[Profiles] DROP CONSTRAINT [FK_Profiles_Visitors]
GO

ALTER TABLE [dbo].[Pages] DROP CONSTRAINT [FK_Pages_Visitors]
GO

ALTER TABLE [dbo].[Visitors] DROP CONSTRAINT [PK_Visitors]
GO

ALTER TABLE [dbo].[Visitors] ADD  CONSTRAINT [PK_Visitors] PRIMARY KEY NONCLUSTERED 
(
	[VisitorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Pages]  WITH NOCHECK ADD  CONSTRAINT [FK_Pages_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[Pages] NOCHECK CONSTRAINT [FK_Pages_Visitors]
GO

ALTER TABLE [dbo].[Profiles]  WITH NOCHECK ADD  CONSTRAINT [FK_Profiles_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[Profiles] NOCHECK CONSTRAINT [FK_Profiles_Visitors]
GO

ALTER TABLE [dbo].[VisitorTags]  WITH NOCHECK ADD  CONSTRAINT [FK_VisitorTags_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[VisitorTags] NOCHECK CONSTRAINT [FK_VisitorTags_Visitors]
GO

ALTER TABLE [dbo].[Visits]  WITH NOCHECK ADD  CONSTRAINT [FK_Visits_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[Visits] NOCHECK CONSTRAINT [FK_Visits_Visitors]
GO

ALTER TABLE [dbo].[AutomationStates]  WITH NOCHECK ADD  CONSTRAINT [FK_AutomationStates_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[AutomationStates] NOCHECK CONSTRAINT [FK_AutomationStates_Visitors]
GO

ALTER TABLE [dbo].[PageEvents]  WITH NOCHECK ADD  CONSTRAINT [FK_PageEvents_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[PageEvents] NOCHECK CONSTRAINT [FK_PageEvents_Visitors]
GO
/*******************************************************************/


/****** Object:  Index [PK_VisitorTags] ******/
ALTER TABLE [dbo].[VisitorTags] DROP CONSTRAINT [PK_VisitorTags]
GO

ALTER TABLE [dbo].[VisitorTags] ADD  CONSTRAINT [PK_VisitorTags] PRIMARY KEY NONCLUSTERED 
(
	[VisitorTagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
/*******************************************************************/


/****** Object:  Index [dbo].[Visits].[PK_Visits] ******/
ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [FK_PageEvents_Visits]
GO

ALTER TABLE [dbo].[Pages] DROP CONSTRAINT [FK_Pages_Visits]
GO

ALTER TABLE [dbo].[PageEvents] DROP CONSTRAINT [FK_PageEvents_Visitors]
GO

ALTER TABLE [dbo].[Profiles] DROP CONSTRAINT [FK_Profile_Visits]
GO

ALTER TABLE [dbo].[Visits] DROP CONSTRAINT [PK_Visits]
GO

ALTER TABLE [dbo].[Visits] ADD  CONSTRAINT [PK_Visits] PRIMARY KEY NONCLUSTERED 
(
	[VisitId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

ALTER TABLE [dbo].[Profiles]  WITH NOCHECK ADD  CONSTRAINT [FK_Profile_Visits] FOREIGN KEY([VisitId])
REFERENCES [dbo].[Visits] ([VisitId])
GO

ALTER TABLE [dbo].[Profiles] NOCHECK CONSTRAINT [FK_Profile_Visits]
GO

ALTER TABLE [dbo].[PageEvents]  WITH NOCHECK ADD  CONSTRAINT [FK_PageEvents_Visitors] FOREIGN KEY([VisitorId])
REFERENCES [dbo].[Visitors] ([VisitorId])
GO

ALTER TABLE [dbo].[PageEvents] NOCHECK CONSTRAINT [FK_PageEvents_Visitors]
GO

ALTER TABLE [dbo].[Pages]  WITH NOCHECK ADD  CONSTRAINT [FK_Pages_Visits] FOREIGN KEY([VisitId])
REFERENCES [dbo].[Visits] ([VisitId])
GO

ALTER TABLE [dbo].[Pages] NOCHECK CONSTRAINT [FK_Pages_Visits]
GO

ALTER TABLE [dbo].[PageEvents]  WITH NOCHECK ADD  CONSTRAINT [FK_PageEvents_Visits] FOREIGN KEY([VisitId])
REFERENCES [dbo].[Visits] ([VisitId])
GO

ALTER TABLE [dbo].[PageEvents] NOCHECK CONSTRAINT [FK_PageEvents_Visits]
GO
/*******************************************************************/