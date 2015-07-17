--Global veriables
declare @schema_name nvarchar(100)
set @schema_name = 'dbo'
declare @i int
declare @cnt int

-- Remove Extended properties
declare @database_properties table (idx int identity(1,1), propertyName nvarchar(100));
declare @dropTableExtendedProperty nvarchar(500);
declare @propertyName nvarchar(100)

insert into @database_properties (propertyName)
	select 'MS_DiagramPane1' union
	select 'MS_DiagramPaneCount'

select @i = min(idx) - 1, @cnt = max(idx) from @database_properties
while @i < @cnt
begin
     select @i = @i + 1
     select @propertyName =  propertyName from @database_properties where idx = @i

	 set @dropTableExtendedProperty = (select 'EXEC sp_dropextendedproperty
     @name = ' + @propertyName + ' 
    ,@level0type = ''schema''
    ,@level0name = ' + object_schema_name(extended_properties.major_id) + '
    ,@level1type = ''view''
    ,@level1name = ' + object_name(extended_properties.major_id)
    from sys.extended_properties
    where extended_properties.class_desc = 'OBJECT_OR_COLUMN' and extended_properties.minor_id = 0 and extended_properties.name = @propertyName)

	set @propertyName = 'MS_DiagramPane1'
	exec sp_executesql @dropTableExtendedProperty
end

-- Disable asp.net membership obsolete properties
declare @aspnet_properties table (idx int identity(1,1), tableName nvarchar(100))
declare @table_name nvarchar(100);

insert into @aspnet_properties 
select name from sys.tables
where objectproperty(object_id,'tabletextinrowlimit') <> 0

select @i = min(idx) - 1, @cnt = max(idx) from @aspnet_properties
while @i < @cnt
begin
     select @i = @i + 1
     select @table_name = tableName from @aspnet_properties where idx = @i

	 EXECUTE sp_tableoption @table_name, 'text in row', 'OFF';
end

-- Update aspnet_Membership_GetNumberOfUsersOnline Store procedure
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[aspnet_Membership_GetNumberOfUsersOnline]') AND type in (N'P', N'PC'))
exec ('
ALTER PROCEDURE [aspnet_Membership_GetNumberOfUsersOnline]
    @ApplicationName            nvarchar(256),
    @MinutesSinceLastInActive   int,
    @CurrentTimeUtc             datetime
AS
BEGIN
    DECLARE @DateActive datetime
    SELECT  @DateActive = DATEADD(minute,  -(@MinutesSinceLastInActive), @CurrentTimeUtc)

    DECLARE @NumOnline int
    SELECT  @NumOnline = COUNT(*)
    FROM    dbo.aspnet_Users u WITH (NOLOCK),
            dbo.aspnet_Applications a WITH (NOLOCK),
            dbo.aspnet_Membership m WITH (NOLOCK)
    WHERE   u.ApplicationId = a.ApplicationId                  AND
            LastActivityDate > @DateActive                     AND
            a.LoweredApplicationName = LOWER(@ApplicationName) AND
            u.UserId = m.UserId
    RETURN(@NumOnline)
END
')

-- Remove unnecessary clustered indexes

declare @count int
declare @index_name nvarchar(100)
declare @index_key_columns nvarchar(100)
declare @drop_index nvarchar(MAX)
declare @add_index nvarchar(MAX)

declare @tables_to_proceed table(idx int identity(1,1), table_name nvarchar(100), index_name nvarchar(100), index_key_columns nvarchar(100))

insert into @tables_to_proceed (table_name, index_name, index_key_columns)
    select 'AccessControl',       'PK_AccessControl',       '[Id] ASC'                         union
    select 'Archive',             'PK_Archive',             '[ArchivalId] ASC'                 union
    select 'ArchivedVersions',    'PK_ArchivedVersions',    '[VersionId] ASC'                  union
    select 'Descendants',         'Descendants_PK',         '[Ancestor] ASC, [Descendant] ASC'

select @i = min(idx) - 1, @count = max(idx) from @tables_to_proceed

while @i < @count
begin
  select @i = @i + 1
   
  select @table_name = table_name, @index_name = index_name, @index_key_columns = index_key_columns from @tables_to_proceed where idx = @i
  if (EXISTS (SELECT * 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = @schema_name 
    AND  TABLE_NAME = @table_name))
  begin
    set @drop_index = 'ALTER TABLE [dbo].[' + @table_name + '] DROP CONSTRAINT [' + @index_name + ']'
    set @add_index =  'ALTER TABLE [dbo].[' + @table_name + '] ADD  CONSTRAINT [' + @index_name + '] PRIMARY KEY NONCLUSTERED 
    (' + @index_key_columns + ')
    WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]'

    begin tran
      if  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[' + @table_name + ']') AND name = @index_name)
      begin
        exec sp_executesql @drop_index;
      end

      exec sp_executesql @add_index;
    commit
  end
end

-- Add clustered indexes
declare @tables table(idx int identity(1,1), table_name nvarchar(100))

insert into @tables (table_name)
    select 'AccessControl' union
    select 'Archive' union
    select 'ArchivedVersions' union
    select 'Descendants' union
    select 'Blobs' union
    select 'ArchivedItems' union
    select 'Links' union
    select 'Notifications' union
    select 'ArchivedFields' union
    select 'WorkflowHistory' union
    select 'Tasks' union
    select 'ClientData' union
    select 'Properties' union
    select 'PublishQueue' union
    select 'IDTable' union
    select 'Shadows' union
    select 'SharedFields' union
    select 'UnversionedFields' union
    select 'VersionedFields' union
    select 'Items' union
    select 'History' union
    select 'RolesInRoles'


declare @name nvarchar(100);
declare @add_Column_Sql nvarchar(255);
declare @add_ClusteredIndex_Sql nvarchar(255);

select @i = min(idx) - 1, @cnt = max(idx) from @tables

while @i < @cnt
begin
     select @i = @i + 1
     select @name =  table_name from @tables where idx = @i

	 set @add_Column_Sql = 'ALTER TABLE [dbo].['+ @name +'] ADD DAC_Index int NULL;'
	 set @add_ClusteredIndex_Sql = 'CREATE CLUSTERED INDEX [DAC_Clustered] ON [dbo].[' + @name +']
	 (
	   [DAC_Index] ASC
	 )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)'

	 IF (EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = @schema_name 
                 AND  TABLE_NAME = @name))
	BEGIN
		if NOT exists(select * from sys.columns 
            where Name = N'DAC_Index' and Object_ID = Object_ID(@name))
		begin
			exec sp_executesql @add_Column_Sql;			
			exec sp_executesql @add_ClusteredIndex_Sql;			
		end
	END
end