USE [C305050_Khanawal]
GO
/****** Object:  StoredProcedure [dbo].[ListingSearch]    Script Date: 02/13/2013 20:39:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[ListingSearch] 
	@SearchText varchar(3000)
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from dbo.listing where ID in	(select ID from [dbo].[Search_Listing] where freetext(*, @SearchText))
END

