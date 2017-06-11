CREATE DATABASE [TestDb]
GO
USE [TestDb]
GO
CREATE LOGIN [so] WITH PASSWORD='H3lloWorld!', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
CREATE USER [so] FOR LOGIN [so] WITH DEFAULT_SCHEMA=[so]
GO
ALTER ROLE [db_owner] ADD MEMBER [so]
GO
CREATE SCHEMA [so]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [so].[AccountTypes](
	[account_type_id] [int] NOT NULL,
	[description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AccountType_ID] PRIMARY KEY CLUSTERED
(
	[account_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [so].[AccountTypes] ([account_type_id], [description]) VALUES (0, N'Select Account Type')
INSERT [so].[AccountTypes] ([account_type_id], [description]) VALUES (1, N'Personal')
INSERT [so].[AccountTypes] ([account_type_id], [description]) VALUES (2, N'Office')
INSERT [so].[AccountTypes] ([account_type_id], [description]) VALUES (3, N'Integrated')
