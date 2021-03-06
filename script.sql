USE [TaskManagementSystemDB]
GO
/****** Object:  StoredProcedure [dbo].[AddUserstoTeam]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddUserstoTeam] 
	-- Add the parameters for the stored procedure here
	@teamId int,
	@userId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [dbo].[Team_User] values(@teamId, @userId)
END
GO
/****** Object:  StoredProcedure [dbo].[CreateTeam]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateTeam] 
	-- Add the parameters for the stored procedure here
	@teamName varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [dbo].[Team] values(@teamName, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteTask]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTask] 
	-- Add the parameters for the stored procedure here
	@id int,
	@taskDetails varchar(max) = null,
	@taskAssignedDate varchar(50) = null,
	@taskEndDate varchar(50) = null,
	@responsibleUserId int = null,
	@status int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [dbo].[Task] 
	set
		taskDetails = ISNULL(@taskDetails, taskDetails),
		taskAssignedDate = ISNULL(@taskAssignedDate, taskAssignedDate),
		taskEndDate = ISNULL(@taskEndDate, taskEndDate),
		responsibleUserId = ISNULL(@responsibleUserId, responsibleUserId),
		status  =ISNULL(@status, status),
		isActive= 0
	where
		id=@id

END
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[DeleteUser]
	-- Add the parameters for the stored procedure here
	@id int,
	@userName varchar(50) = null,
	@password varchar(max) = null,
	@role int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [dbo].[User] set 
	userName = ISNULL(@userName, userName), 
	password = ISNULL (@password, password), 
	role = ISNULL (@role, role), 
	isActive= 0 
	where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[GetSavedTeamID]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetSavedTeamID] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select max(teamId) as maxId from [dbo].[Team] 
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamID]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[GetTeamID] 
	-- Add the parameters for the stored procedure here
	@userId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select teamId from [dbo].[Team_User] where userId=@userId
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamList]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[GetTeamList] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select teamId,teamName from [dbo].[Team] where isActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[GetTeamMembersList]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetTeamMembersList] 
	-- Add the parameters for the stored procedure here
	@teamId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select u.id,u.userName from [dbo].[User] u 
	inner join Team_User t on u.id=t.userId
	where t.teamId=@teamId and  (u.isActive=1 and u.role <> 2)
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserList]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserList] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select id,userName,role from [dbo].[User] where isActive=1
END
GO
/****** Object:  StoredProcedure [dbo].[GetUserListByRole]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetUserListByRole] 
	-- Add the parameters for the stored procedure here
	@role int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select id, userName, role from [dbo].[User]
 where role=@role and id not in
(
	select distinct u.id
	from [dbo].[User] u
	inner join 
	[dbo].[Team_User] t 
	on u.id=t.userId 
	where isActive=1
)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertTask]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertTask] 
	-- Add the parameters for the stored procedure here
	@taskDetails varchar(max),
	@taskAssignedDate varchar(50),
	@taskEndDate varchar(50),
	@responsibleUserId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [dbo].[Task] values(@taskDetails, @taskAssignedDate, @taskEndDate, @responsibleUserId, 1, 1)
END
GO
/****** Object:  StoredProcedure [dbo].[InsertUser]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertUser] 
	-- Add the parameters for the stored procedure here
	@userName varchar(50),
	@password varchar(max),
	@role int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into [dbo].[User] values(@userName, @password, @role,1)
END
GO
/****** Object:  StoredProcedure [dbo].[Login]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Login] 
	-- Add the parameters for the stored procedure here
	@userName varchar(50),
	@password varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select id,userName,role from [dbo].[User] where userName=@userName and password=@password
END
GO
/****** Object:  StoredProcedure [dbo].[TeamList]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[TeamList] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.teamId, t.teamName,u.userName as teamLead
  from Team t
  join Team_User tu 
  on t.teamId=tu.teamId
  join [dbo].[User] u
  on tu.userId=u.id
  where u.role=2
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateTask]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[UpdateTask] 
	-- Add the parameters for the stored procedure here
	@id int,
	@taskDetails varchar(max) = null,
	@taskAssignedDate varchar(50) = null,
	@taskEndDate varchar(50) = null,
	@responsibleUserId int = null,
	@status int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [dbo].[Task] 
	set
		taskDetails = ISNULL(@taskDetails, taskDetails),
		taskAssignedDate = ISNULL(@taskAssignedDate, taskAssignedDate),
		taskEndDate = ISNULL(@taskEndDate, taskEndDate),
		responsibleUserId = ISNULL(@responsibleUserId, responsibleUserId),
		status  =ISNULL(@status, status),
		isActive= 1
	where
		id=@id

END
GO
/****** Object:  StoredProcedure [dbo].[UpdateUsers]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUsers]
	-- Add the parameters for the stored procedure here
	@id int,
	@userName varchar(50) = null,
	@password varchar(max) = null,
	@role int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update [dbo].[User] set 
	userName = ISNULL(@userName, userName), 
	password = ISNULL (@password, password), 
	role = ISNULL (@role, role), 
	isActive= 1 
	where id = @id
END
GO
/****** Object:  StoredProcedure [dbo].[ViewTask]    Script Date: 11/22/2018 1:28:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ViewTask] 
	-- Add the parameters for the stored procedure here
	@id int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select 
		t.id, 
		t.taskDetails, 
		t.taskAssignedDate, 
		t.taskEndDate, 
		t.responsibleUserId,
		u.userName as responsibleUser,
		te.teamName as teamName,
		t.status 
	from Task t inner join [dbo].[User] u
	on t.responsibleUserId=u.id
	inner join Team_User tu on tu.userId=t.responsibleUserId
	inner join Team te on te.teamId = tu.teamId
	where 
		t.responsibleUserId= isnull (@id, responsibleUserId)
		and t.isActive=1
END
GO
