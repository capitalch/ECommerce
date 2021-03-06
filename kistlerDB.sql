USE [KistlerDB]
GO
ALTER TABLE [dbo].[UserProfiles] DROP CONSTRAINT [FK_UserProfiles_UserMaster]
GO
ALTER TABLE [dbo].[States] DROP CONSTRAINT [FK_States_Countries]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [FK_OrderMaster_UserMaster]
GO
ALTER TABLE [dbo].[OrderImpDetails] DROP CONSTRAINT [FK_OrderImpDetails_ShippingAddresses]
GO
ALTER TABLE [dbo].[OrderImpDetails] DROP CONSTRAINT [FK_OrderImpDetails_PaymentMethods]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_OrderMaster]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_OfferMaster]
GO
ALTER TABLE [dbo].[TaxNShipping] DROP CONSTRAINT [DF_TaxNShipping_ShippingCharges]
GO
ALTER TABLE [dbo].[TaxNShipping] DROP CONSTRAINT [DF_TaxNShipping_SalesTaxPerc]
GO
/****** Object:  Table [dbo].[UsrLog]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[UsrLog]
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[UserProfiles]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[UserMaster]
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[TaxNShipping]
GO
/****** Object:  Table [dbo].[SysParms]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[SysParms]
GO
/****** Object:  Table [dbo].[States]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[States]
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[ShippingAddresses]
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[Setup]
GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[PaymentMethods]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[OrderMaster]
GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[OrderImpDetails]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[OfferMaster]
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[OfferDetails]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 1/26/2017 8:58:21 AM ******/
DROP TABLE [dbo].[Countries]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryId] [int] NOT NULL,
	[CountryName] [nvarchar](23) NOT NULL,
	[ISOCode] [nchar](2) NOT NULL,
	[RequiresZip] [bit] NOT NULL CONSTRAINT [DF_Countries_RequiresZip]  DEFAULT ((1)),
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OfferDetails](
	[Id] [int] NOT NULL,
	[OfferId] [int] NOT NULL,
	[Spec] [varchar](200) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OfferMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Item] [varchar](100) NOT NULL,
	[Price] [decimal](4, 0) NOT NULL,
	[Packing] [char](1) NOT NULL,
	[AvailableQty] [smallint] NOT NULL,
	[TastingNotes] [varchar](1032) NULL,
	[ImageUrl] [varchar](256) NULL,
	[Descr] [varchar](256) NULL,
 CONSTRAINT [PK_OfferMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[OfferId] [int] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[WishList] [smallint] NOT NULL CONSTRAINT [DF_OrderDetails_WishList]  DEFAULT ((0)),
	[Price] [decimal](10, 0) NOT NULL CONSTRAINT [DF_OrderDetails_Price]  DEFAULT ((0)),
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderImpDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[CreditCardId] [int] NULL,
	[CardName] [nchar](100) NULL,
	[CCFirstName] [nchar](100) NULL,
	[CCLastName] [nchar](100) NULL,
	[CCType] [nchar](100) NULL,
	[CCNumber] [nchar](100) NULL,
	[CCExpiryMonth] [nchar](100) NULL,
	[CCExpiryYear] [nchar](100) NULL,
	[CCSecurityCode] [nchar](100) NULL,
	[Name] [nchar](100) NULL,
	[Phone] [nchar](100) NULL,
	[Co] [nchar](100) NULL,
	[Street1] [nchar](100) NULL,
	[Street2] [nchar](100) NULL,
	[City] [nchar](100) NULL,
	[State] [nchar](100) NULL,
	[Zip] [nchar](100) NULL,
	[Country] [nchar](100) NULL,
	[ISOCode] [nchar](100) NULL,
 CONSTRAINT [PK_OrderImpDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MDate] [date] NOT NULL CONSTRAINT [DF_OrderMaster_MDate]  DEFAULT (getdate()),
	[OrderNo] [varchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[Descr] [varchar](50) NULL,
	[IsDelivered] [bit] NOT NULL CONSTRAINT [DF_OrderMaster_IsSupplied]  DEFAULT ((0)),
	[Invoice] [varchar](50) NULL,
	[Amount] [decimal](10, 0) NOT NULL CONSTRAINT [DF_OrderMaster_Amount]  DEFAULT ((0)),
	[SalesTaxWine] [decimal](10, 2) NOT NULL CONSTRAINT [DF_OrderMaster_SalesTax]  DEFAULT ((0)),
	[ShippingWine] [decimal](10, 0) NOT NULL CONSTRAINT [DF_OrderMaster_Shipping]  DEFAULT ((0)),
	[TotalPriceWine] [decimal](10, 0) NOT NULL CONSTRAINT [DF_OrderMaster_TotalPrice]  DEFAULT ((0)),
	[SalesTaxAddl] [decimal](10, 2) NOT NULL CONSTRAINT [DF_OrderMaster_SalesTaxAddl]  DEFAULT ((0)),
	[ShippingAddl] [decimal](10, 2) NOT NULL CONSTRAINT [DF_OrderMaster_ShippingAddl]  DEFAULT ((0)),
	[TotalPriceAddl] [decimal](10, 2) NOT NULL CONSTRAINT [DF_OrderMaster_TotalPriceAddl]  DEFAULT ((0)),
 CONSTRAINT [PK_OrderMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](8) NULL,
	[CardName] [nvarchar](100) NOT NULL,
	[CCFirstName] [nvarchar](100) NOT NULL,
	[CCLastName] [nvarchar](100) NOT NULL,
	[CCType] [nvarchar](100) NOT NULL,
	[CCNumber] [nvarchar](100) NOT NULL,
	[CCExpiryMonth] [nvarchar](100) NOT NULL,
	[CCExpiryYear] [nvarchar](100) NOT NULL,
	[CCSecurityCode] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Co] [nvarchar](100) NULL,
	[Street1] [nvarchar](100) NOT NULL,
	[Street2] [nvarchar](100) NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](11) NOT NULL,
	[Zip] [nvarchar](15) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[ISOCode] [nchar](2) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[userId] [int] NOT NULL,
 CONSTRAINT [PK_PaymentMethods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Setup]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Setup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MKey] [varchar](64) NOT NULL,
	[IntValue] [int] NOT NULL CONSTRAINT [DF_Setup_IntValue]  DEFAULT ((0)),
	[StringValue] [varchar](256) NULL,
 CONSTRAINT [PK_Setup] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShippingAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [nvarchar](8) NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Co] [nvarchar](100) NULL,
	[Street1] [nvarchar](100) NOT NULL,
	[Street2] [nvarchar](100) NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](11) NOT NULL,
	[Zip] [nvarchar](15) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[ISOCode] [nchar](2) NOT NULL,
	[IsDefault] [bit] NOT NULL,
	[userId] [int] NOT NULL,
	[IsAddressVerified] [bit] NOT NULL CONSTRAINT [DF_ShippingAddresses_IsAddressVerified]  DEFAULT ((0)),
 CONSTRAINT [PK_ShippingAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[States]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[States](
	[StateAbbr] [nchar](2) NOT NULL,
	[CountryId] [int] NOT NULL CONSTRAINT [DF_States_CountryId]  DEFAULT ((246)),
	[StateName] [nvarchar](50) NOT NULL,
	[IsNoShip] [bit] NOT NULL CONSTRAINT [DF_States_IsNoShip]  DEFAULT ((0)),
 CONSTRAINT [PK_States] PRIMARY KEY CLUSTERED 
(
	[StateAbbr] ASC,
	[CountryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SysParms]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysParms](
	[id] [tinyint] NOT NULL,
	[DisableOnlineOrderForm] [bit] NOT NULL CONSTRAINT [DF_SysParms_DisableOnlineOrderForm]  DEFAULT ((0)),
	[Login_Page] [nvarchar](max) NULL,
	[NewUser_Page] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TaxNShipping](
	[Zip] [varchar](50) NOT NULL,
	[SalesTaxPerc] [decimal](10, 2) NOT NULL,
	[ShippingCharges] [decimal](10, 0) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[PwdHash] [varchar](100) NOT NULL,
	[Role] [char](1) NOT NULL,
	[Code] [varchar](10) NULL,
	[OfferId] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserProfiles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](256) NOT NULL,
	[LastName] [varchar](256) NOT NULL,
	[Phone] [varchar](64) NOT NULL,
	[BirthDay] [smalldatetime] NOT NULL,
	[MailingAddress1] [varchar](512) NOT NULL,
	[MailingAddress2] [varchar](512) NULL,
	[MailingCity] [varchar](64) NOT NULL,
	[MailingState] [varchar](64) NOT NULL,
	[MailingZip] [varchar](64) NOT NULL,
	[UserId] [int] NOT NULL,
	[PrevBalanceWine] [decimal](12, 2) NOT NULL CONSTRAINT [DF_UserProfiles_PrevBalance]  DEFAULT ((0)),
	[PrevBalanceAddl] [decimal](12, 2) NOT NULL CONSTRAINT [DF_UserProfiles_PrevBalanceAddl]  DEFAULT ((0)),
	[MailingCountry] [varchar](64) NULL,
	[IsAddressVerified] [bit] NOT NULL CONSTRAINT [DF_UserProfiles_IsVerified]  DEFAULT ((0)),
	[Co] [nvarchar](100) NULL,
 CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UsrLog]    Script Date: 1/26/2017 8:58:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UsrLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](50) NOT NULL,
	[mdate] [datetime] NOT NULL CONSTRAINT [DF_UsrLog_mdate]  DEFAULT (getdate()),
	[mType] [varchar](15) NOT NULL,
 CONSTRAINT [PK_UsrLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (1, N'Afghanistan', N'AF', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (2, N'Åland Islands', N'AX', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (3, N'Albania', N'AL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (4, N'Algeria', N'DZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (5, N'American Samoa', N'AS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (6, N'Andorra', N'AD', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (7, N'Angola', N'AO', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (8, N'Anguilla', N'AI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (9, N'Antarctica', N'AQ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (10, N'Antigua and Barbuda', N'AG', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (11, N'Argentina', N'AR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (12, N'Armenia', N'AM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (13, N'Aruba', N'AW', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (14, N'Australia', N'AU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (15, N'Austria', N'AT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (16, N'Azerbaijan', N'AZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (17, N'Bahamas', N'BS', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (18, N'Bahrain', N'BH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (19, N'Bangladesh', N'BD', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (20, N'Barbados', N'BB', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (21, N'Belarus', N'BY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (22, N'Belgium', N'BE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (23, N'Belize', N'BZ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (24, N'Benin', N'BJ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (25, N'Bermuda', N'BM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (26, N'Bhutan', N'BT', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (27, N'Bolivia', N'BO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (28, N'Bosnia and Herzegovina', N'BA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (29, N'Botswana', N'BW', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (30, N'Bouvet Island', N'BV', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (31, N'Brazil', N'BR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (32, N'Indian Ocean Territory', N'IO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (33, N'Brunei Darussalam', N'BN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (34, N'Bulgaria', N'BG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (35, N'Burkina Faso', N'BF', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (36, N'Burundi', N'BI', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (37, N'Cambodia', N'KH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (38, N'Cameroon', N'CM', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (39, N'Canada', N'CA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (40, N'Cape Verde', N'CV', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (41, N'Cayman Islands', N'KY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (42, N'Central African Rep.', N'CF', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (43, N'Chad', N'TD', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (44, N'Chile', N'CL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (45, N'China', N'CN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (46, N'Christmas Island', N'CX', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (47, N'Cocos Islands', N'CC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (48, N'Keeling Islands', N'CC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (49, N'Colombia', N'CO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (50, N'Comoros', N'KM', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (51, N'Congo (Brazzaville)', N'CG', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (52, N'Dem. Republic of Congo', N'CD', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (53, N'Cook Islands', N'CK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (54, N'Costa Rica', N'CR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (55, N'Côte d''Ivoire', N'CI', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (56, N'Croatia', N'HR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (57, N'Cuba', N'CU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (58, N'Cyprus', N'CY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (59, N'Czech Republic', N'CZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (60, N'Denmark', N'DK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (61, N'Djibouti', N'DJ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (62, N'Dominica', N'DM', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (63, N'Dominican Republic', N'DO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (64, N'Ecuador', N'EC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (65, N'Egypt', N'EG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (66, N'El Salvador', N'SV', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (67, N'Equatorial Guinea', N'GQ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (68, N'Eritrea', N'ER', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (69, N'Estonia', N'EE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (70, N'Ethiopia', N'ET', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (71, N'Falkland Islands', N'FK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (72, N'Malvinas', N'FK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (73, N'Faroe Islands', N'FO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (74, N'Fiji', N'FJ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (75, N'Finland', N'FI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (76, N'France', N'FR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (77, N'French Guiana', N'GF', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (78, N'French Polynesia', N'PF', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (79, N'French Southern Lands', N'TF', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (80, N'Gabon', N'GA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (81, N'Gambia', N'GM', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (82, N'Georgia', N'GE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (83, N'Germany', N'DE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (84, N'Ghana', N'GH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (85, N'Gibraltar', N'GI', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (86, N'Greece', N'GR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (87, N'Greenland', N'GL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (88, N'Grenada', N'GD', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (89, N'Guadeloupe', N'GP', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (90, N'Guam', N'GU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (91, N'Guatemala', N'GT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (92, N'Guernsey', N'GG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (93, N'Guinea', N'GN', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (94, N'Guinea-Bissau', N'GW', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (95, N'Guyana', N'GY', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (96, N'Haiti', N'HT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (97, N'McDonald Islands', N'HM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (98, N'Heard Island', N'HM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (99, N'Vatican City', N'VA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (100, N'Holy See', N'VA', 1)
GO
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (101, N'Honduras', N'HN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (102, N'Hong Kong', N'HK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (103, N'Hungary', N'HU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (104, N'Iceland', N'IS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (105, N'India', N'IN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (106, N'Indonesia', N'ID', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (107, N'Iran', N'IR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (108, N'Iraq', N'IQ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (109, N'Ireland', N'IE', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (110, N'Isle of Man', N'IM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (111, N'Israel', N'IL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (112, N'Italy', N'IT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (113, N'Jamaica', N'JM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (114, N'Japan', N'JP', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (115, N'Jersey', N'JE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (116, N'Jordan', N'JO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (117, N'Kazakhstan', N'KZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (118, N'Kenya', N'KE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (119, N'Kiribati', N'KI', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (120, N'North Korea', N'KP', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (121, N'South Korea', N'KR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (122, N'Kuwait', N'KW', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (123, N'Kyrgyzstan', N'KG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (124, N'Laos', N'LA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (125, N'Latvia', N'LV', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (126, N'Lebanon', N'LB', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (127, N'Lesotho', N'LS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (128, N'Liberia', N'LR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (129, N'Libyan Arab Jamahiriya', N'LY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (130, N'Liechtenstein', N'LI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (131, N'Lithuania', N'LT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (132, N'Luxembourg', N'LU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (133, N'Macao', N'MO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (134, N'Macedonia', N'MK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (135, N'Madagascar', N'MG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (136, N'Malawi', N'MW', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (137, N'Malaysia', N'MY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (138, N'Maldives', N'MV', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (139, N'Mali', N'ML', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (140, N'Malta', N'MT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (141, N'Marshall Islands', N'MH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (142, N'Martinique', N'MQ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (143, N'Mauritania', N'MR', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (144, N'Mauritius', N'MU', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (145, N'Mayotte', N'YT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (146, N'Mexico', N'MX', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (147, N'Micronesia', N'FM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (148, N'Moldova', N'MD', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (149, N'Monaco', N'MC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (150, N'Mongolia', N'MN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (151, N'Montenegro', N'ME', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (152, N'Montserrat', N'MS', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (153, N'Morocco', N'MA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (154, N'Mozambique', N'MZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (155, N'Myanmar', N'MM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (156, N'Namibia', N'NA', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (157, N'Nauru', N'NR', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (158, N'Nepal', N'NP', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (159, N'Netherlands', N'NL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (160, N'Netherlands Antilles', N'AN', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (161, N'New Caledonia', N'NC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (162, N'New Zealand', N'NZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (163, N'Nicaragua', N'NI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (164, N'Niger', N'NE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (165, N'Nigeria', N'NG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (166, N'Niue', N'NU', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (167, N'Norfolk Island', N'NF', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (168, N'Northern Mariana Isl.', N'MP', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (169, N'Norway', N'NO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (170, N'Oman', N'OM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (171, N'Pakistan', N'PK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (172, N'Palau', N'PW', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (173, N'Palestinian Territory', N'PS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (174, N'Panama', N'PA', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (175, N'Papua New Guinea', N'PG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (176, N'Paraguay', N'PY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (177, N'Peru', N'PE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (178, N'Philippines', N'PH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (179, N'Pitcairn', N'PN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (180, N'Poland', N'PL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (181, N'Portugal', N'PT', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (182, N'Puerto Rico', N'PR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (183, N'Qatar', N'QA', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (184, N'Réunion', N'RE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (185, N'Romania', N'RO', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (186, N'Russian Federation', N'RU', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (187, N'Rwanda', N'RW', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (188, N'Saint Barthélemy', N'BL', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (189, N'Saint Helena', N'SH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (190, N'Ascension', N'SH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (191, N'Tristan da Cunha', N'SH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (192, N'Saint Kitts and Nevis', N'KN', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (193, N'Saint Lucia', N'LC', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (194, N'Saint Martin (French)', N'MF', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (195, N'Saint Pierre', N'PM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (196, N'Miquelon', N'PM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (197, N'Saint Vincent', N'VC', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (198, N'Grenadines', N'VC', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (199, N'Samoa', N'WS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (200, N'San Marino', N'SM', 1)
GO
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (201, N'Sao Tome and Principe', N'ST', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (202, N'Saudi Arabia', N'SA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (203, N'Senegal', N'SN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (204, N'Serbia', N'RS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (205, N'Seychelles', N'SC', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (206, N'Sierra Leone', N'SL', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (207, N'Singapore', N'SG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (208, N'Slovakia', N'SK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (209, N'Slovenia', N'SI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (210, N'Solomon Islands', N'SB', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (211, N'Somalia', N'SO', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (212, N'South Africa', N'ZA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (213, N'South Georgia', N'GS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (214, N'South Sandwich Islands', N'GS', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (215, N'Spain', N'ES', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (216, N'Sri Lanka', N'LK', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (217, N'Sudan', N'SD', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (218, N'Suriname', N'SR', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (219, N'Svalbard and Jan Mayen', N'SJ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (220, N'Swaziland', N'SZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (221, N'Sweden', N'SE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (222, N'Switzerland', N'CH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (223, N'Syrian Arab Republic', N'SY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (224, N'Taiwan', N'TW', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (225, N'Tajikistan', N'TJ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (226, N'Tanzania', N'TZ', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (227, N'Thailand', N'TH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (228, N'Timor-Leste', N'TL', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (229, N'Togo', N'TG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (230, N'Tokelau', N'TK', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (231, N'Tonga', N'TO', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (232, N'Trinidad', N'TT', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (233, N'Tobago', N'TT', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (234, N'Tunisia', N'TN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (235, N'Turkey', N'TR', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (236, N'Turkmenistan', N'TM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (237, N'Caicos Islands', N'TC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (238, N'Turks', N'TC', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (239, N'Tuvalu', N'TV', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (240, N'Uganda', N'UG', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (241, N'Ukraine', N'UA', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (242, N'United Arab Emirates', N'AE', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (243, N'United Kingdom', N'GB', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (244, N'England', N'GB', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (245, N'Great Britain', N'GB', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (246, N'United States', N'US', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (247, N'US Minor Outlying Isl.', N'UM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (248, N'Uruguay', N'UY', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (249, N'Uzbekistan', N'UZ', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (250, N'Vanuatu', N'VU', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (251, N'Venezuela', N'VE', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (252, N'Viet Nam', N'VN', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (253, N'British Virgin Islands', N'VG', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (254, N'US Virgin Islands', N'VI', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (255, N'Wallis and Futuna', N'WF', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (256, N'Western Sahara', N'EH', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (257, N'Yemen', N'YE', 0)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (258, N'Zambia', N'ZM', 1)
INSERT [dbo].[Countries] ([CountryId], [CountryName], [ISOCode], [RequiresZip]) VALUES (259, N'Zimbabwe', N'ZW', 0)
SET IDENTITY_INSERT [dbo].[OfferMaster] ON 

INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (6, N'2014 Dutton Ranch Chardonnay ', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Produced since 1979. Wine grapes planted to what was once the premiere apple growing region of western Sonoma County, located in the heart of the Sonoma Coast region. Annually results in a wine of precision, with focused, structural acids layered ...', N'img5.jpg', N'Antonio Galloni Score: 91-94 <br/> The 2014 Chardonnay Dutton Ranch is beautifully centered. Hints of almond, white flowers and lemon peel flesh out in a Chardonnay that exudes depth. Oily and textured on the palate, yet also tightly wound…')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (7, N'2014 Hudson Vineyard Chardonnay', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Sourced since 1994. Located in the southwestern reaches of Napa County, where a rare mix of volcanic and marine sediment soils meet to produce a wine of depth and elegance, often touched with high pitched tones of iodine, and an oyster shell like minerality...', N'img2.jpg', N'Antonio Galloni Score: 94-97 <br/> One of the clear highlights today, the 2014 Chardonnay Hudson Vineyard is simply magnificent. Striking aromatics make a strong first impression. Yellow orchard fruit, mint and white pepper are all finely knit ...')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (8, N'2014 Stone Flat Chardonnay', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Sourced since 2002. Located in the western portion of Carneros, where the soils are driven by heavy river run cobble, but the air is dominated by afternoon winds from the Pacific. Produces a wine that strikes an impeccable balance ...', N'img3.jpg', N'Antonio Galloni Score: 91-94 <br/> The 2014 Chardonnay Stone Flat Vineyard is right across the road from Durrell, yet it is so remarkably different in style. Candied lemon, honey and mint are all pushed forward.')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (9, N'2014 Pinot Noir Kistler Vineyard', CAST(90 AS Decimal(4, 0)), N'b', 6, N'This ridge-top vineyard looks to the coast in one direction and the Russian River Valley in the other. The Vineyard sits on layers of sandstone, granular sediments and some petrified wood ...', N'img4.jpg', N'Robert Parker Jr. Score: 90-92 <br/> The two tank samples of the 2014 Pinot Noirs showed a more restrained, softer style of wines that are more front-end loaded. ...')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (10, N'2014 6-Bottle Pinot Noir Package*', CAST(540 AS Decimal(4, 0)), N'p', 3, N'', N'img1.jpg', N'6 Bottles of 2014 Kistler Pinot Noir.')
SET IDENTITY_INSERT [dbo].[OfferMaster] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (234, 84, 7, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (235, 85, 6, 1, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (236, 85, 7, 3, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (237, 85, 8, 5, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (238, 86, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (239, 87, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (240, 88, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (241, 89, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (242, 90, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (243, 91, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (244, 92, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (245, 93, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (246, 93, 7, 4, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (247, 94, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (248, 94, 7, 4, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (249, 95, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (250, 96, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (251, 96, 7, 1, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (252, 97, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (253, 97, 7, 1, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (254, 97, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (255, 98, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (256, 98, 7, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (257, 99, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (258, 100, 10, 0, 1, CAST(540 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (259, 101, 10, 0, 1, CAST(540 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (260, 102, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (261, 103, 10, 1, 0, CAST(540 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (262, 104, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (263, 105, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (264, 106, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (265, 107, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (266, 107, 7, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (267, 108, 6, 1, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (268, 109, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (269, 110, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (270, 111, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (271, 112, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (272, 113, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (273, 114, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (274, 115, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (275, 116, 8, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (276, 117, 8, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (277, 118, 6, 5, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (278, 119, 6, 5, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (279, 120, 6, 4, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (280, 120, 7, 4, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (281, 120, 8, 5, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (282, 120, 9, 5, 0, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (283, 121, 6, 4, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (284, 121, 8, 0, 4, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (285, 122, 9, 0, 1, CAST(90 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (286, 122, 10, 0, 1, CAST(540 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (287, 123, 10, 0, 1, CAST(540 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (288, 124, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (292, 128, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (295, 131, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (296, 132, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (300, 136, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (301, 137, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (302, 137, 7, 1, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (303, 138, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (304, 139, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (305, 140, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (306, 141, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (307, 142, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (308, 143, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (309, 144, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (314, 149, 6, 3, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (315, 150, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (316, 151, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (317, 152, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (318, 153, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (319, 154, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (320, 155, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (321, 156, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (322, 157, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1321, 1156, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1322, 1157, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1323, 1158, 6, 1, 0, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1324, 1159, 6, 0, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1325, 1160, 6, 6, 1, CAST(80 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (1326, 1160, 7, 1, 0, CAST(80 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderImpDetails] ON 

INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (37, 84, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (38, 85, 6, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (39, 86, 6, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (40, 87, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (41, 88, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (42, 89, 2, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (43, 90, 6, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (44, 91, 6, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (45, 92, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (46, 93, 6, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (47, 94, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (48, 95, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (49, 96, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (50, 97, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (51, 98, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (52, 99, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (53, 100, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (54, 101, 3, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (55, 102, 4, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (56, 103, 13, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (57, 104, 13, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (58, 105, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (59, 106, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (60, 107, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (61, 108, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (62, 109, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (63, 110, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (64, 111, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (65, 112, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (66, 113, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (67, 114, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (68, 115, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (69, 116, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (70, 117, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (71, 118, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (72, 119, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (73, 120, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (74, 121, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (75, 122, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (76, 123, 13, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (77, 124, 13, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (78, 128, 13, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (79, 131, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (80, 132, 13, NULL, NULL, NULL, NULL, NULL, N'378734493671000                                                                                     ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (81, 136, 13, NULL, N'New Card                                                                                            ', N'11212                                                                                               ', N'121212                                                                                              ', N'Visa                                                                                                ', N'378734493671000                                                                                     ', N'1                                                                                                   ', N'2017                                                                                                ', N'12112                                                                                               ', NULL, N'(121) 121-2222                                                                                      ', N'                                                                                                    ', N'121221                                                                                              ', N'12122                                                                                               ', N'121212                                                                                              ', N'12121                                                                                               ', N'11221                                                                                               ', N'US                                                                                                  ', N'                                                                                                    ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (82, 137, 13, NULL, N'My New Card                                                                                         ', N'Sushant                                                                                             ', N'Agrawal                                                                                             ', N'Visa                                                                                                ', N'378734493671001                                                                                     ', N'1                                                                                                   ', N'2017                                                                                                ', N'111                                                                                                 ', NULL, N'(121) 121-2212                                                                                      ', N'                                                                                                    ', N'21212                                                                                               ', N'2112                                                                                                ', N'1212                                                                                                ', N'1212                                                                                                ', N'1212                                                                                                ', N'US                                                                                                  ', N'                                                                                                    ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (83, 138, 13, NULL, N'12212                                                                                               ', N'222                                                                                                 ', N'12212                                                                                               ', N'Visa                                                                                                ', N'378734493671000                                                                                     ', N'1                                                                                                   ', N'2017                                                                                                ', N'121212                                                                                              ', NULL, N'(211) 212-1222                                                                                      ', N'                                                                                                    ', N'21212                                                                                               ', N'1222                                                                                                ', N'21212                                                                                               ', N'1212                                                                                                ', N'2                                                                                                   ', N'US                                                                                                  ', N'                                                                                                    ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (84, 139, 15, 1032, N'My New Card                                                                                         ', N'Sushant                                                                                             ', N'Agrawal                                                                                             ', N'Visa                                                                                                ', N'3566002020360505                                                                                    ', N'1                                                                                                   ', N'2017                                                                                                ', N'1212                                                                                                ', NULL, N'(121) 222-2111                                                                                      ', N'                                                                                                    ', N'121212                                                                                              ', N'1212                                                                                                ', N'121212                                                                                              ', N'121212                                                                                              ', N'121212                                                                                              ', N'US                                                                                                  ', N'                                                                                                    ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (85, 140, 14, NULL, N'New Card1                                                                                           ', N'SSS                                                                                                 ', N'AGR                                                                                                 ', N'Visa                                                                                                ', N'3530111333300000                                                                                    ', N'1                                                                                                   ', N'2017                                                                                                ', N'12                                                                                                  ', NULL, N'(111) 222-2222                                                                                      ', N'                                                                                                    ', N'12                                                                                                  ', N'212                                                                                                 ', N'22                                                                                                  ', N'1                                                                                                   ', N'1                                                                                                   ', N'US                                                                                                  ', N'US                                                                                                  ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (86, 141, 14, NULL, N'New Card2                                                                                           ', N'sss                                                                                                 ', N'aaa                                                                                                 ', N'Visa                                                                                                ', N'3530111333300000                                                                                    ', N'1                                                                                                   ', N'2017                                                                                                ', N'121                                                                                                 ', NULL, N'(121) 212-1222                                                                                      ', N'                                                                                                    ', N'22212                                                                                               ', N'112                                                                                                 ', N'2212                                                                                                ', N'1212                                                                                                ', N'121212                                                                                              ', N'US                                                                                                  ', N'US                                                                                                  ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (87, 142, 14, NULL, N'1212                                                                                                ', N'1212                                                                                                ', N'211212                                                                                              ', N'Visa                                                                                                ', N'3530111333300000                                                                                    ', N'1                                                                                                   ', N'2017                                                                                                ', N'121                                                                                                 ', NULL, N'(121) 212-2222                                                                                      ', N'                                                                                                    ', N'22                                                                                                  ', N'2                                                                                                   ', N'1221                                                                                                ', N'121212                                                                                              ', N'12122                                                                                               ', N'United States                                                                                       ', N'US                                                                                                  ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (88, 143, 14, NULL, N'Test 1                                                                                              ', N'1212                                                                                                ', N'121212                                                                                              ', N'Visa                                                                                                ', N'6011111111111117                                                                                    ', N'1                                                                                                   ', N'2017                                                                                                ', N'234                                                                                                 ', NULL, N'(212) 112-2332                                                                                      ', N'                                                                                                    ', N' 8070 Monet Ave                                                                                     ', N'Fort Smith                                                                                          ', N'Rancho Cucamonga                                                                                    ', N'CA                                                                                                  ', N'91739                                                                                               ', N'United States                                                                                       ', N'US                                                                                                  ')
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (89, 144, 14, 19, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (94, 149, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (95, 150, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (96, 151, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (97, 152, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (98, 153, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (99, 154, 14, 1035, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (100, 155, 14, 1036, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (101, 156, 14, 1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (102, 157, 14, 1038, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (1101, 1156, 13, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (1102, 1157, 13, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (1103, 1158, 42, 1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (1104, 1159, 46, 1037, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode]) VALUES (1105, 1160, 46, 1038, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[OrderImpDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderMaster] ON 

INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (84, CAST(N'2016-12-18' AS Date), N'44', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (85, CAST(N'2016-12-18' AS Date), N'45', 1, NULL, 0, NULL, CAST(995 AS Decimal(10, 0)), CAST(61.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(720 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(160.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (86, CAST(N'2016-12-18' AS Date), N'46', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (87, CAST(N'2016-12-18' AS Date), N'47', 1, NULL, 0, NULL, CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (88, CAST(N'2016-12-18' AS Date), N'48', 1, NULL, 0, NULL, CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (89, CAST(N'2016-12-18' AS Date), N'49', 1, NULL, 0, NULL, CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (90, CAST(N'2016-12-18' AS Date), N'50', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (91, CAST(N'2016-12-18' AS Date), N'51', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (92, CAST(N'2016-12-18' AS Date), N'52', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (93, CAST(N'2016-12-18' AS Date), N'53', 1, NULL, 0, NULL, CAST(474 AS Decimal(10, 0)), CAST(34.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(400 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (94, CAST(N'2016-12-18' AS Date), N'54', 1, NULL, 0, NULL, CAST(474 AS Decimal(10, 0)), CAST(34.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(400 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (95, CAST(N'2016-12-19' AS Date), N'55', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (96, CAST(N'2016-12-20' AS Date), N'56', 1, NULL, 0, NULL, CAST(300 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(160 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (97, CAST(N'2016-12-20' AS Date), N'57', 1, NULL, 0, NULL, CAST(387 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(160 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(160.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (98, CAST(N'2016-12-20' AS Date), N'58', 1, NULL, 0, NULL, CAST(214 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(160.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (99, CAST(N'2016-12-20' AS Date), N'59', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (100, CAST(N'2016-12-20' AS Date), N'60', 1, NULL, 0, NULL, CAST(626 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(45.90 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(540.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (101, CAST(N'2016-12-20' AS Date), N'61', 1, NULL, 0, NULL, CAST(626 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(45.90 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(540.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (102, CAST(N'2016-12-21' AS Date), N'62', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (103, CAST(N'2016-12-21' AS Date), N'63', 1, NULL, 0, NULL, CAST(626 AS Decimal(10, 0)), CAST(45.90 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(540 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (104, CAST(N'2016-12-23' AS Date), N'64', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (105, CAST(N'2016-12-23' AS Date), N'65', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (106, CAST(N'2016-12-23' AS Date), N'66', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (107, CAST(N'2016-12-23' AS Date), N'67', 1, NULL, 0, NULL, CAST(214 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(160 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (108, CAST(N'2016-12-23' AS Date), N'68', 1, NULL, 0, NULL, CAST(214 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (109, CAST(N'2016-12-23' AS Date), N'69', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (110, CAST(N'2016-12-23' AS Date), N'70', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (111, CAST(N'2016-12-23' AS Date), N'71', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (112, CAST(N'2016-12-23' AS Date), N'72', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (113, CAST(N'2016-12-24' AS Date), N'73', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (114, CAST(N'2016-12-24' AS Date), N'74', 1, NULL, 0, NULL, CAST(138 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(7.65 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(90.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (115, CAST(N'2016-12-24' AS Date), N'75', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (116, CAST(N'2016-12-24' AS Date), N'76', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (117, CAST(N'2016-12-24' AS Date), N'77', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (118, CAST(N'2016-12-24' AS Date), N'78', 1, NULL, 0, NULL, CAST(474 AS Decimal(10, 0)), CAST(34.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(400 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (119, CAST(N'2016-12-24' AS Date), N'79', 1, NULL, 0, NULL, CAST(474 AS Decimal(10, 0)), CAST(34.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(400 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (120, CAST(N'2016-12-24' AS Date), N'80', 1, NULL, 0, NULL, CAST(1657 AS Decimal(10, 0)), CAST(126.65 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(1490 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (121, CAST(N'2016-12-24' AS Date), N'81', 1, NULL, 0, NULL, CAST(734 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(320 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(320.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (122, CAST(N'2016-12-24' AS Date), N'82', 1, NULL, 0, NULL, CAST(724 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(53.55 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(630.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (123, CAST(N'2016-12-24' AS Date), N'83', 1, NULL, 0, NULL, CAST(626 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(45.90 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(540.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (124, CAST(N'2017-01-04' AS Date), N'84', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (128, CAST(N'2017-01-04' AS Date), N'85', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (131, CAST(N'2017-01-04' AS Date), N'86', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (132, CAST(N'2017-01-04' AS Date), N'87', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (136, CAST(N'2017-01-04' AS Date), N'88', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (137, CAST(N'2017-01-04' AS Date), N'89', 1, NULL, 0, NULL, CAST(300 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(160.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (138, CAST(N'2017-01-04' AS Date), N'90', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (139, CAST(N'2017-01-06' AS Date), N'91', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (140, CAST(N'2017-01-06' AS Date), N'92', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (141, CAST(N'2017-01-06' AS Date), N'93', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (142, CAST(N'2017-01-06' AS Date), N'94', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (143, CAST(N'2017-01-11' AS Date), N'95', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (144, CAST(N'2017-01-12' AS Date), N'96', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (149, CAST(N'2017-01-12' AS Date), N'97', 16, NULL, 0, NULL, CAST(300 AS Decimal(10, 0)), CAST(20.40 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(240 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (150, CAST(N'2017-01-12' AS Date), N'98', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (151, CAST(N'2017-01-12' AS Date), N'99', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (152, CAST(N'2017-01-12' AS Date), N'100', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (153, CAST(N'2017-01-12' AS Date), N'101', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (154, CAST(N'2017-01-12' AS Date), N'102', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (155, CAST(N'2017-01-12' AS Date), N'103', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (156, CAST(N'2017-01-13' AS Date), N'104', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (157, CAST(N'2017-01-13' AS Date), N'105', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (1156, CAST(N'2017-01-18' AS Date), N'106', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (1157, CAST(N'2017-01-18' AS Date), N'107', 1, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (1158, CAST(N'2017-01-20' AS Date), N'108', 16, NULL, 0, NULL, CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0 AS Decimal(10, 0)), CAST(80 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (1159, CAST(N'2017-01-20' AS Date), N'109', 16, NULL, 0, NULL, CAST(127 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (1160, CAST(N'2017-01-23' AS Date), N'110', 16, NULL, 0, NULL, CAST(734 AS Decimal(10, 0)), CAST(47.60 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(560 AS Decimal(10, 0)), CAST(6.80 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(80.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderMaster] OFF
SET IDENTITY_INSERT [dbo].[PaymentMethods] ON 

INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (4, NULL, N'American Express', N'James
', N'Butt
', N'Credit Card', N'378282246310005', N'12', N'2019', N'122', N'James
 Butt
', N'504-621-8927
', NULL, N'6649 N Blue Gum St
', NULL, N'New Orleans
', N'LA
', N'70116
', N'Orleans
', N'OR', 0, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (9, NULL, N'My master card', N'Sushant', N'Agrawal', N'American Express', N'371449635398431', N'12', N'2016', N'223', N'www', N'(111) 111-1111', NULL, N'www', N'www', N'ww', N'www', N'111111111111', N'Bangladesh', N'BD', 0, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (16, NULL, N'My personal card', N'Sushant', N'Agrawal', N'MasterCard', N'3566002020360505', N'12', N'2016', N'123', N'Sushant Agrawal', N'(121) 212-1222', NULL, N'11', N'1', N'11', N'11', N'1', N'United States', N'US', 0, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (17, NULL, N'My Card', N'Sushant', N'Agrawal', N'Visa', N'371449635398431', N'1', N'2017', N'123', N'Sushant Agrawal', N'(788) 778-8778', NULL, N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 1, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (19, NULL, N'My Personal Card', N'1222', N'12122', N'Visa', N'38520000023237', N'1', N'2017', N'122', N'1222 12122', N'(212) 112-2332', NULL, N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1022, NULL, N'w', N'e', N'e', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N'e', N'test', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 1, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1025, NULL, N'eee', N'sss', N'ddd', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N'w', N'sss ddd', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 1, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1032, NULL, N'test3', N'aa3', N'bb3', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N's', N'aa3 bb3', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 1, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1033, NULL, N'test4', N'aaa4', N'bbb4', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N'q', N'aaa4 bbb4', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1034, NULL, N'test4', N'aaa4', N'bbb4', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N'q', N'aaa4 bbb4', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1035, NULL, N'test5', N'aa5', N'bb5', N'Visa', N'3782 XXXX XXXX 0005', N'1', N'2017', N'aa5', N'aa5 bb5', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1036, NULL, N'test6', N'aa6', N'bb6', N'Visa', N'378282246310005', N'1', N'2017', N'11', N'aa6 bb6', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1037, NULL, N'test7', N'aaa7', N'bbb7', N'Visa', N'378282246310005', N'1', N'2017', N'qq', N'aaa7 bbb7', N'(112) 221-2222', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (1038, NULL, N'test8', N'aaa8', N'bbb8', N'Visa', N'378282246310005', N'1', N'2017', N'222', N'aaa8 bbb8', N'(212) 112-2332', N'', N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16)
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
SET IDENTITY_INSERT [dbo].[Setup] ON 

INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (1, N'MaxOrderNumber', 110, NULL)
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (2, N'DefaultSalesTaxPerc', 0, N'8.5')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (3, N'DefaultShippingCharges', 0, N'20')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (4, N'AdminPwdHash', 0, N'21232f297a57a5a743894a0e4a801fc3')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (5, N'AdminIp', 0, N'223.29.199.212')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (6, N'SmartyStreetApiKey', 0, N'21047913783681978')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (7, N'SmartyStreetAuthToken', 0, N'ikDR4hndQSAScpWSPdj8')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (8, N'SmartyStreetAuthId', 0, N'63395b2b-4df2-c8c7-a487-21ecc25979c8')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (9, N'CreditCardTypes', 0, N'Visa, MasterCard, American Express, Discover')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (10, N'NeedHelpText', 0, N'Please contact the sales representative at XXX')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (11, N'DisableOnLineOrderText', 0, N'Allotment of orders is closed')
SET IDENTITY_INSERT [dbo].[Setup] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddresses] ON 

INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (2, N'sagarwal', N'James Butt1', N'(454) 555-5455', NULL, N' 525 Wyoming Blvd NE', N'', N'Albuquerque', N'NM', N'87123', N'United States', N'US', 0, 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (3, N'sagarwal', N'Josephine Darakjy
', N'810-292-9388', NULL, N' 525 Wyoming Blvd NE', N'', N'Albuquerque', N'NM', N'87123', N'United States', N'US', 0, 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (4, N'sagarwal', N'Mc Donald', N'(983) 105-2442', NULL, N'N 1000 18th St ', N'Test', N'Centerville', N'IA', N'52544', N'United States', N'US', 0, 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (5, N'sagarwal', N'Mc Donald', N'(777) 765-6665', NULL, N'SE 2441 Washington Blvd ', N'', N'Bartlesville', N'OK', N'74006', N'United States', N'US', 0, 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (6, N'Test', N'Mc Donald', N'(676) 676-7676', NULL, N' 100 Woodside Dr ', N'', N'Havelock', N'NC', N'28532', N'United States', N'US', 0, 1, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (10, N'Test', N'Mc Donald', N'(566) 666-5555', NULL, N'S 1975 Union Ave ', N'', N'Tacoma', N'WA', N'98405', N'United States', N'US', 0, 1, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (12, N'Test', N'Mc Donald', N'(121) 221-2122', NULL, N' 28624 Highway 290  ', N'West', N'Cypress', N'TX', N'77433', N'United States', N'US', 0, 1, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (13, N'sagarwal', N'Mc Donald', N'(222) 878-8412', NULL, N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 1, 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (14, N'sa6', N'Sushant Agrawal', N'(212) 112-2332', NULL, N' 8070 Monet Ave ', N'Fort Smith', N'Rancho Cucamonga', N'CA', N'91739', N'United States', N'US', 0, 16, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (15, N'sa6', N'Sushant Agrawal', N'(121) 212-2222', N'test', N'test1', N'test2', N'test', N'test', N'3323', N'United States', N'US', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (16, N'sa6', N'SSS', N'(676) 777-7777', N'667', N'677', N'6767', N'7676', N'6767', N'6777', N'United States', N'US', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (17, N'sa6', N'Sush', N'(983) 105-2332', N'sush1', N'test1', N'test2', N'Kol', N'wb', N'777014', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (36, N'sa6', N'111', N'(111) 111-1111', N'111', N'111', N'111', N'111', N'111', N'111', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (37, N'sa6', N'222', N'(222) 222-2222', N'222', N'222', N'222', N'222', N'2222', N'222', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (38, N'sa6', N'333', N'(333) 333-3333', N'333', N'333', N'333', N'333', N'333', N'333', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (41, N'sa6', N'444', N'(444) 444-4444', N'444', N'444', N'444', N'444', N'444', N'444', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (42, N'sa6', N'555', N'(555) 555-5555', N'555', N'555', N'5555', N'555', N'555', N'555', N'India', N'IN', 0, 16, 0)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId], [IsAddressVerified]) VALUES (46, N'sa6', N'Sushant', N'(411) 455-5411', N'Walt', N'S 1975 Union Ave ', N'', N'Tacoma', N'WA', N'98405', N'United States', N'US', 1, 16, 1)
SET IDENTITY_INSERT [dbo].[ShippingAddresses] OFF
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'AB', 39, N'Alberta', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'AK', 246, N'Alaska', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'AL', 246, N'Alabama', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'AR', 246, N'Arkansas', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'AZ', 246, N'Arizona', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'BC', 39, N'British Columbia', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'CA', 246, N'California', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'CO', 246, N'Colorado', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'CT', 246, N'Connecticut', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'DC', 246, N'Washington, DC', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'DE', 246, N'Delaware', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'FL', 246, N'Florida', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'GA', 246, N'Georgia', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'HI', 246, N'Hawaii', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'IA', 246, N'Iowa', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'ID', 246, N'Idaho', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'IL', 246, N'Illinois', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'IN', 246, N'Indiana', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'KS', 246, N'Kansas', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'KY', 246, N'Kentucky', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'LA', 246, N'Louisiana', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MA', 246, N'Massachusetts', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MB', 39, N'Manitoba', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MD', 246, N'Maryland', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'ME', 246, N'Maine', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MI', 246, N'Michigan', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MN', 246, N'Minnesota', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MO', 246, N'Missouri', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MS', 246, N'Mississippi', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'MT', 246, N'Montana', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NB', 39, N'New Brunswick', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NC', 246, N'North Carolina', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'ND', 246, N'North Dakota', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NE', 246, N'Nebraska', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NH', 246, N'New Hampshire', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NJ', 246, N'New Jersey', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NL', 39, N'Newfoundland/Labrador', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NM', 246, N'New Mexico', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NS', 39, N'Nova Scotia', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NT', 39, N'Northwest Territories', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NU', 39, N'Nunavut', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NV', 246, N'Nevada', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'NY', 246, N'New York', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'OH', 246, N'Ohio', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'OK', 246, N'Oklahoma', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'ON', 39, N'Ontario', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'OR', 246, N'Oregon', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'PA', 246, N'Pennsylvania', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'PE', 39, N'Prince Edward Island', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'PR', 246, N'Puerto Rico', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'QC', 39, N'Quebec', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'RI', 246, N'Rhode Island', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'SC', 246, N'South Carolina', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'SD', 246, N'South Dakota', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'SK', 39, N'Saskatchewan', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'TN', 246, N'Tennessee', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'TX', 246, N'Texas', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'UT', 246, N'Utah', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'VA', 246, N'Virginia', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'VT', 246, N'Vermont', 1)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'WA', 246, N'Washington', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'WI', 246, N'Wisconsin', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'WV', 246, N'West Virginia', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'WY', 246, N'Wyoming', 0)
INSERT [dbo].[States] ([StateAbbr], [CountryId], [StateName], [IsNoShip]) VALUES (N'YT', 39, N'Yukon', 0)
INSERT [dbo].[SysParms] ([id], [DisableOnlineOrderForm], [Login_Page], [NewUser_Page]) VALUES (1, 0, N'Welcome to Kistler', N'Please give a password to be registered with Kistler database')
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (1, N'sagarwal@netwoven.com', N'42b86bd9f4fe360155efb557e5bd1ec5', N'u', N'sagarwal', N'zzz')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (4, N'sa@gmail.com', N'dea5687d7786d43266cf55d7be014530', N'U', N'sushant', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (5, N'sagarwal1@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u', N'sushant1', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (6, N'sa@gmail.com', N'dea5687d7786d43266cf55d7be014530', N'U', N'aa', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (7, N'sa@gmail.com', N'dea5687d7786d43266cf55d7be014530', N'U', N'sa1', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (8, N'tchakraborty1@netwoven.com', N'ceb6c970658f31504a901b89dcd3e461', N'u', N'tanmoy', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (9, N'ssaha1@netwoven.com', N'ceb6c970658f31504a901b89dcd3e461', N'u', N'ssaha', N'x1245')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (10, N'sas@gmail.com', N'dea5687d7786d43266cf55d7be014530', N'U', N'sa2', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (11, N'ssaha@netwoven.com', N'ceb6c970658f31504a901b89dcd3e461', N'U', N'sa3', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (12, N'sas@gmail.com', N'dea5687d7786d43266cf55d7be014530', N'U', N'sa4', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (15, N'sas@gmail.com', N'', N'u', N'sa5', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (16, N'sagarwal@netwoven.com', N'42b86bd9f4fe360155efb557e5bd1ec5', N'u', N'sa6', N'zzz')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (17, N'jmore51@aol.com', N'42b86bd9f4fe360155efb557e5bd1ec5', N'e', N'BARR6', NULL)
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role], [Code], [OfferId]) VALUES (20, N'lseigel@ix.netcom.com', N'42b86bd9f4fe360155efb557e5bd1ec5', N'e', N'SEIG1', NULL)
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
SET IDENTITY_INSERT [dbo].[UserProfiles] ON 

INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry], [IsAddressVerified], [Co]) VALUES (1, N'Sushant', N'Agrawal', N'9998887612', CAST(N'1963-11-19 00:00:00' AS SmallDateTime), N'a1', N'a', N'a', N'a', N'700012', 4, CAST(200.00 AS Decimal(12, 2)), CAST(-190.00 AS Decimal(12, 2)), NULL, 0, NULL)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry], [IsAddressVerified], [Co]) VALUES (7, N'Sushant', N'Agrawal', N'9831052332', CAST(N'1963-11-07 00:00:00' AS SmallDateTime), N'12 JL', NULL, N'Kolkata', N'WB', N'7000133', 4, CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), NULL, 0, NULL)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry], [IsAddressVerified], [Co]) VALUES (11, N'Tanmoy123', N'Chakravorty', N'(122) 222-2222', CAST(N'1980-01-16 00:00:00' AS SmallDateTime), N'  Test1  ', N'Test2', N'Brooklyn22da sdad', N'NYs', N'11245', 1, CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'United States', 0, NULL)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry], [IsAddressVerified], [Co]) VALUES (16, N'Test First Name', N'Last Name', N'(222) 222-2223', CAST(N'2017-01-25 00:00:00' AS SmallDateTime), N'test1', N'test2', N'12', N'2we', N'212', 16, CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'United States', 0, N'eee')
SET IDENTITY_INSERT [dbo].[UserProfiles] OFF
SET IDENTITY_INSERT [dbo].[UsrLog] ON 

INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1, N'sagarwal', CAST(N'2016-12-22 00:38:53.760' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2, N'sagarwal', CAST(N'2016-12-22 09:32:34.380' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3, N'sagarwal', CAST(N'2016-12-22 20:50:00.650' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (4, N'sagarwal', CAST(N'2016-12-22 20:51:28.330' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (5, N'sagarwal', CAST(N'2016-12-22 21:05:57.860' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (6, N'sagarwal', CAST(N'2016-12-22 21:52:37.987' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (7, N'sagarwal', CAST(N'2016-12-22 22:11:54.090' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (8, N'sagarwal', CAST(N'2016-12-22 22:14:21.387' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (9, N'sagarwal', CAST(N'2016-12-22 22:15:24.280' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (10, N'sagarwal', CAST(N'2016-12-22 22:15:28.120' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (11, N'sagarwal', CAST(N'2016-12-22 22:15:52.697' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (12, N'sagarwal', CAST(N'2016-12-22 22:16:26.260' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (13, N'sagarwal', CAST(N'2016-12-22 22:17:48.893' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (14, N'sagarwal', CAST(N'2016-12-22 23:40:42.600' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (15, N'sagarwal', CAST(N'2016-12-23 00:29:44.750' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (16, N'sagarwal', CAST(N'2016-12-23 00:29:59.957' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (17, N'sagarwal', CAST(N'2016-12-23 04:05:54.707' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (18, N'sagarwal', CAST(N'2016-12-23 15:27:11.650' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (19, N'sagarwal', CAST(N'2016-12-23 15:40:43.433' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (20, N'sagarwal', CAST(N'2016-12-23 15:46:16.560' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (21, N'sagarwal', CAST(N'2016-12-23 15:46:41.087' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (22, N'sagarwal', CAST(N'2016-12-23 16:02:50.233' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (23, N'sagarwal', CAST(N'2016-12-23 16:03:24.143' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (24, N'sagarwal', CAST(N'2016-12-23 16:05:03.587' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (25, N'sagarwal', CAST(N'2016-12-23 16:06:01.197' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (26, N'sagarwal', CAST(N'2016-12-23 17:30:14.397' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (27, N'sagarwal', CAST(N'2016-12-24 00:38:29.507' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (28, N'sagarwal', CAST(N'2016-12-24 00:40:13.460' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (29, N'sagarwal', CAST(N'2016-12-24 00:51:53.423' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (30, N'sagarwal', CAST(N'2016-12-24 01:11:33.280' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (31, N'sagarwal', CAST(N'2016-12-24 09:42:37.707' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (32, N'sagarwal', CAST(N'2016-12-24 10:10:58.987' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (33, N'sagarwal', CAST(N'2016-12-24 10:11:56.830' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (34, N'sagarwal', CAST(N'2016-12-24 10:36:16.290' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (35, N'sagarwal', CAST(N'2016-12-24 10:38:12.667' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (36, N'sagarwal', CAST(N'2016-12-24 10:38:32.553' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (37, N'sagarwal', CAST(N'2016-12-24 10:39:22.293' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (38, N'sagarwal', CAST(N'2016-12-24 10:39:36.207' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (39, N'sagarwal', CAST(N'2016-12-24 14:03:36.643' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (40, N'sagarwal', CAST(N'2016-12-24 14:04:23.000' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (41, N'sagarwal', CAST(N'2016-12-24 14:05:04.710' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (42, N'sagarwal', CAST(N'2016-12-24 14:05:27.970' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (43, N'sagarwal', CAST(N'2016-12-24 14:05:39.447' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (44, N'sagarwal', CAST(N'2016-12-24 14:05:54.380' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (45, N'sagarwal', CAST(N'2016-12-24 14:06:53.947' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (46, N'sagarwal', CAST(N'2016-12-24 14:07:13.580' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (47, N'sagarwal', CAST(N'2016-12-24 14:08:22.380' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (48, N'sagarwal', CAST(N'2016-12-24 14:08:54.527' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (49, N'sagarwal', CAST(N'2016-12-24 14:13:14.193' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (50, N'sagarwal', CAST(N'2016-12-24 14:15:03.540' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (51, N'sagarwal', CAST(N'2016-12-24 14:20:02.120' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (52, N'sagarwal', CAST(N'2016-12-24 14:21:01.937' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (53, N'sagarwal', CAST(N'2016-12-24 19:11:37.253' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (54, N'sagarwal', CAST(N'2016-12-24 19:12:12.270' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (55, N'sagarwal', CAST(N'2016-12-24 19:14:03.947' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (56, N'sagarwal', CAST(N'2016-12-24 19:14:26.230' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (57, N'sagarwal', CAST(N'2016-12-24 19:14:58.240' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (58, N'sagarwal', CAST(N'2016-12-24 19:15:37.437' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (59, N'sagarwal', CAST(N'2016-12-24 19:16:33.077' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (60, N'sagarwal', CAST(N'2016-12-24 19:16:53.300' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (61, N'sagarwal', CAST(N'2016-12-24 19:29:21.813' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (62, N'sagarwal', CAST(N'2016-12-24 19:29:41.840' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (63, N'sagarwal', CAST(N'2016-12-24 19:31:13.647' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (64, N'sagarwal', CAST(N'2016-12-24 20:48:59.173' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (65, N'sagarwal', CAST(N'2016-12-30 19:14:28.003' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (66, N'sagarwal', CAST(N'2016-12-30 20:06:16.800' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (67, N'sagarwal', CAST(N'2016-12-30 20:07:03.600' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (68, N'sagarwal', CAST(N'2016-12-30 20:16:58.470' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (69, N'sagarwal', CAST(N'2016-12-30 21:58:58.537' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (70, N'sagarwal', CAST(N'2016-12-30 23:22:46.070' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (71, N'sagarwal', CAST(N'2017-01-02 08:31:45.053' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (72, N'sagarwal', CAST(N'2017-01-02 08:32:54.210' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (73, N'sagarwal', CAST(N'2017-01-02 08:34:19.483' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (74, N'sagarwal', CAST(N'2017-01-02 08:51:19.550' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (75, N'sagarwal', CAST(N'2017-01-02 08:51:47.323' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (76, N'sagarwal', CAST(N'2017-01-02 09:04:17.727' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (77, N'sagarwal', CAST(N'2017-01-02 09:05:22.340' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (78, N'sagarwal', CAST(N'2017-01-02 09:13:30.767' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (79, N'sagarwal', CAST(N'2017-01-02 09:14:20.057' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (80, N'sagarwal', CAST(N'2017-01-02 09:35:39.437' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (81, N'sagarwal', CAST(N'2017-01-02 09:38:57.347' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (82, N'sagarwal', CAST(N'2017-01-02 09:39:32.633' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (83, N'sagarwal', CAST(N'2017-01-02 09:55:57.420' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (84, N'sagarwal', CAST(N'2017-01-02 09:56:53.590' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (85, N'sagarwal', CAST(N'2017-01-02 09:58:04.140' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (86, N'sagarwal', CAST(N'2017-01-02 10:15:04.733' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (87, N'sagarwal', CAST(N'2017-01-02 10:16:38.437' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (88, N'sagarwal', CAST(N'2017-01-02 10:19:39.940' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (89, N'sagarwal', CAST(N'2017-01-02 10:25:57.937' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (90, N'sagarwal', CAST(N'2017-01-02 10:36:19.587' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (91, N'sagarwal', CAST(N'2017-01-02 10:39:58.343' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (92, N'sagarwal', CAST(N'2017-01-02 10:43:56.197' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (93, N'sagarwal', CAST(N'2017-01-02 10:45:11.077' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (94, N'sagarwal', CAST(N'2017-01-02 10:49:53.463' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (95, N'sagarwal', CAST(N'2017-01-02 11:06:03.690' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (96, N'sagarwal', CAST(N'2017-01-02 11:08:51.367' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (97, N'sagarwal', CAST(N'2017-01-02 11:10:20.740' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (98, N'sagarwal', CAST(N'2017-01-02 11:12:00.420' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (99, N'sagarwal', CAST(N'2017-01-02 17:57:40.563' AS DateTime), N'login')
GO
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (100, N'sagarwal', CAST(N'2017-01-02 18:00:45.857' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (101, N'sagarwal', CAST(N'2017-01-02 22:04:16.060' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (102, N'sagarwal', CAST(N'2017-01-02 22:31:22.507' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (103, N'sagarwal', CAST(N'2017-01-02 23:44:12.470' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (104, N'sagarwal', CAST(N'2017-01-03 00:44:13.280' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (105, N'sagarwal', CAST(N'2017-01-03 09:13:14.397' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (106, N'sagarwal', CAST(N'2017-01-03 09:29:25.167' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (107, N'sagarwal', CAST(N'2017-01-03 09:29:31.520' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (108, N'sagarwal', CAST(N'2017-01-03 13:50:35.800' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (109, N'sagarwal', CAST(N'2017-01-03 15:09:46.840' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (110, N'sagarwal', CAST(N'2017-01-03 16:42:28.473' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (111, N'sagarwal', CAST(N'2017-01-03 17:18:43.777' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (112, N'sagarwal', CAST(N'2017-01-03 21:59:49.430' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (113, N'sagarwal', CAST(N'2017-01-03 23:01:36.220' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (114, N'sagarwal', CAST(N'2017-01-04 15:07:58.470' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (115, N'sagarwal', CAST(N'2017-01-04 16:38:26.760' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (116, N'sagarwal', CAST(N'2017-01-04 19:37:46.597' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (117, N'sagarwal', CAST(N'2017-01-04 20:40:54.443' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (118, N'sagarwal', CAST(N'2017-01-04 22:44:51.310' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (119, N'sagarwal', CAST(N'2017-01-05 10:08:20.423' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (120, N'sagarwal', CAST(N'2017-01-05 15:51:57.963' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (121, N'sagarwal', CAST(N'2017-01-05 16:33:58.997' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (122, N'sagarwal', CAST(N'2017-01-05 16:40:36.030' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (123, N'sagarwal', CAST(N'2017-01-05 18:30:05.417' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (124, N'sagarwal', CAST(N'2017-01-05 18:31:38.537' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (125, N'sagarwal', CAST(N'2017-01-05 19:04:24.887' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (126, N'sagarwal', CAST(N'2017-01-06 09:33:03.587' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (127, N'sa6', CAST(N'2017-01-06 12:42:21.403' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (128, N'sa6', CAST(N'2017-01-06 13:08:38.587' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (129, N'sa6', CAST(N'2017-01-06 13:11:49.767' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (130, N'sa6', CAST(N'2017-01-06 14:40:12.617' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (131, N'sa6', CAST(N'2017-01-06 14:47:35.627' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (132, N'sa6', CAST(N'2017-01-06 15:16:56.217' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (133, N'sa6', CAST(N'2017-01-06 16:29:31.103' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (134, N'sa6', CAST(N'2017-01-06 18:30:28.433' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (135, N'sagarwal', CAST(N'2017-01-06 20:10:21.903' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (136, N'sa6', CAST(N'2017-01-06 20:36:24.497' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (137, N'sa6', CAST(N'2017-01-06 23:00:59.817' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (138, N'sa6', CAST(N'2017-01-07 00:13:38.703' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (139, N'sa6', CAST(N'2017-01-07 10:09:05.343' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (140, N'sa6', CAST(N'2017-01-07 12:11:38.900' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (141, N'sa6', CAST(N'2017-01-07 13:20:00.617' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (142, N'sa6', CAST(N'2017-01-07 13:43:36.107' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (143, N'sa6', CAST(N'2017-01-08 00:35:47.327' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (144, N'sagarwal', CAST(N'2017-01-08 00:39:27.007' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (145, N'sagarwal', CAST(N'2017-01-08 01:17:25.027' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (146, N'sagarwal', CAST(N'2017-01-08 08:41:03.380' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (147, N'sagarwal', CAST(N'2017-01-08 08:49:39.940' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (148, N'sagarwal', CAST(N'2017-01-08 10:12:51.757' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (149, N'sagarwal', CAST(N'2017-01-08 18:51:54.547' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (150, N'sagarwal', CAST(N'2017-01-08 18:56:38.533' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (151, N'sagarwal', CAST(N'2017-01-08 19:00:39.560' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (152, N'sagarwal', CAST(N'2017-01-08 19:14:21.433' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (153, N'sagarwal', CAST(N'2017-01-08 19:23:24.523' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (154, N'sagarwal', CAST(N'2017-01-08 19:24:31.260' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (155, N'sagarwal', CAST(N'2017-01-08 19:33:10.950' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (156, N'sagarwal', CAST(N'2017-01-08 19:35:11.753' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (157, N'ssaha', CAST(N'2017-01-08 21:39:02.533' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (158, N'ssaha', CAST(N'2017-01-08 22:11:00.907' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (159, N'ssaha', CAST(N'2017-01-09 11:51:51.620' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (160, N'ssaha', CAST(N'2017-01-09 13:06:08.993' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (161, N'ssaha', CAST(N'2017-01-09 16:04:36.443' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (162, N'ssaha', CAST(N'2017-01-09 17:16:07.087' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (163, N'ssaha', CAST(N'2017-01-09 17:46:40.537' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (164, N'ssaha', CAST(N'2017-01-09 17:48:22.400' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (165, N'sagarwal', CAST(N'2017-01-09 23:17:09.160' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (166, N'ssaha', CAST(N'2017-01-09 23:59:55.450' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (167, N'ssaha', CAST(N'2017-01-10 03:16:33.103' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (168, N'ssaha', CAST(N'2017-01-10 15:13:04.083' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (169, N'sa6', CAST(N'2017-01-10 23:31:41.037' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (170, N'sagarwal', CAST(N'2017-01-10 23:37:57.120' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (171, N'sa6', CAST(N'2017-01-11 10:03:30.600' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (172, N'ssaha', CAST(N'2017-01-11 23:04:45.247' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (173, N'tanmoy', CAST(N'2017-01-11 23:05:29.220' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (174, N'ssaha', CAST(N'2017-01-11 23:06:46.310' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (175, N'ssaha', CAST(N'2017-01-11 23:11:43.073' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (176, N'tanmoy', CAST(N'2017-01-11 23:12:18.533' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (177, N'ssaha', CAST(N'2017-01-11 23:24:18.217' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (178, N'tanmoy', CAST(N'2017-01-11 23:24:28.420' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (179, N'ssaha', CAST(N'2017-01-12 00:20:42.947' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (180, N'ssaha', CAST(N'2017-01-12 00:21:00.130' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (181, N'sagarwal', CAST(N'2017-01-12 00:25:51.380' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (182, N'sa6', CAST(N'2017-01-12 00:28:05.523' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (183, N'sagarwal', CAST(N'2017-01-12 00:30:17.680' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (184, N'sagarwal', CAST(N'2017-01-12 00:31:08.260' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (185, N'ssaha', CAST(N'2017-01-12 00:39:23.743' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (186, N'tanmoy', CAST(N'2017-01-12 00:40:42.667' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (187, N'sagarwal', CAST(N'2017-01-12 00:41:23.830' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (188, N'sagarwal', CAST(N'2017-01-12 00:47:34.140' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (189, N'ssaha', CAST(N'2017-01-12 00:47:52.277' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (190, N'ssaha', CAST(N'2017-01-12 00:48:51.320' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (191, N'sagarwal', CAST(N'2017-01-12 00:51:39.343' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (192, N'tanmoy', CAST(N'2017-01-12 00:52:18.347' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (193, N'tanmoy', CAST(N'2017-01-12 00:53:01.507' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (194, N'sa6', CAST(N'2017-01-12 00:55:09.720' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (195, N'ssaha', CAST(N'2017-01-12 00:57:56.267' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (196, N'sagarwal', CAST(N'2017-01-12 00:58:15.197' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (197, N'sa6', CAST(N'2017-01-12 09:07:36.887' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (198, N'sagarwal', CAST(N'2017-01-12 09:36:31.583' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (199, N'sa6', CAST(N'2017-01-12 09:40:10.667' AS DateTime), N'login')
GO
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (200, N'sa6', CAST(N'2017-01-12 11:53:56.270' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (201, N'ssaha', CAST(N'2017-01-12 15:25:42.513' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1197, N'sa6', CAST(N'2017-01-12 17:14:11.813' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1198, N'ssaha', CAST(N'2017-01-12 17:27:01.497' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1199, N'sa6', CAST(N'2017-01-12 18:12:25.000' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1200, N'sa6', CAST(N'2017-01-12 22:08:32.997' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1201, N'sa6', CAST(N'2017-01-13 00:00:07.540' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1202, N'sa6', CAST(N'2017-01-13 08:46:50.817' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1203, N'sa6', CAST(N'2017-01-13 09:23:20.717' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1204, N'sa6', CAST(N'2017-01-13 10:12:37.153' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (1205, N'sa6', CAST(N'2017-01-13 10:45:18.703' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2202, N'sa6', CAST(N'2017-01-13 12:55:02.180' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2203, N'sa6', CAST(N'2017-01-13 12:59:39.300' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2204, N'sa6', CAST(N'2017-01-13 14:44:41.850' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2205, N'sa6', CAST(N'2017-01-13 15:32:31.173' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2206, N'sa6', CAST(N'2017-01-13 17:42:01.947' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2207, N'ssaha', CAST(N'2017-01-13 18:25:31.750' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2208, N'ssaha', CAST(N'2017-01-13 19:08:00.990' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (2209, N'ssaha', CAST(N'2017-01-13 20:15:36.623' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3202, N'sa6', CAST(N'2017-01-14 10:50:55.757' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3203, N'sagarwal', CAST(N'2017-01-14 20:17:12.907' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3204, N'sagarwal', CAST(N'2017-01-15 00:18:01.447' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3205, N'sa6', CAST(N'2017-01-15 09:04:07.753' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3206, N'ssaha', CAST(N'2017-01-15 09:57:15.917' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3207, N'ssaha', CAST(N'2017-01-15 20:10:14.883' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3208, N'ssaha', CAST(N'2017-01-15 20:46:39.790' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3209, N'sa6', CAST(N'2017-01-17 11:08:26.817' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3210, N'sa6', CAST(N'2017-01-17 11:08:42.980' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3211, N'ssaha', CAST(N'2017-01-17 11:48:08.000' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3212, N'sa6', CAST(N'2017-01-17 13:18:51.737' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3213, N'sa6', CAST(N'2017-01-17 14:45:24.440' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3214, N'sa6', CAST(N'2017-01-17 20:29:23.083' AS DateTime), N'newUser')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3215, N'sagarwal', CAST(N'2017-01-18 12:40:05.030' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3216, N'sagarwal', CAST(N'2017-01-18 15:06:02.890' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3217, N'sa6', CAST(N'2017-01-18 23:11:22.033' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3218, N'sagarwal', CAST(N'2017-01-19 04:37:44.727' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3219, N'sa6', CAST(N'2017-01-19 09:36:03.193' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3220, N'sa6', CAST(N'2017-01-19 15:17:22.360' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3221, N'sa6', CAST(N'2017-01-19 15:19:35.990' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3222, N'sa6', CAST(N'2017-01-19 15:49:54.700' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3223, N'sagarwal', CAST(N'2017-01-19 16:02:46.730' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3224, N'sa6', CAST(N'2017-01-19 16:03:06.953' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3225, N'sa6', CAST(N'2017-01-19 17:41:12.087' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3226, N'sa6', CAST(N'2017-01-19 17:45:39.050' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3227, N'sa6', CAST(N'2017-01-19 17:47:57.437' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3228, N'sa6', CAST(N'2017-01-19 18:31:00.780' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3229, N'sa6', CAST(N'2017-01-19 20:48:48.603' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3230, N'sa6', CAST(N'2017-01-19 21:32:26.880' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3231, N'sa6', CAST(N'2017-01-19 21:57:02.587' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3232, N'sa6', CAST(N'2017-01-19 22:07:02.453' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3233, N'sa6', CAST(N'2017-01-19 23:18:49.147' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3234, N'sa6', CAST(N'2017-01-20 08:09:57.697' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3235, N'sa6', CAST(N'2017-01-20 08:42:42.650' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3236, N'sa6', CAST(N'2017-01-20 12:19:16.113' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3237, N'sagarwal', CAST(N'2017-01-20 16:22:23.980' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3238, N'sa6', CAST(N'2017-01-20 16:23:32.863' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3239, N'sa6', CAST(N'2017-01-20 17:14:00.800' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3240, N'sa6', CAST(N'2017-01-20 23:46:05.713' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3241, N'sa6', CAST(N'2017-01-21 00:02:37.310' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3242, N'sa6', CAST(N'2017-01-21 00:23:07.290' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3243, N'sa6', CAST(N'2017-01-21 00:24:41.000' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3244, N'sa6', CAST(N'2017-01-21 00:25:43.430' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3245, N'sa6', CAST(N'2017-01-21 00:32:18.397' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3246, N'sa6', CAST(N'2017-01-21 00:41:11.193' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3247, N'sa6', CAST(N'2017-01-21 10:54:40.710' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3248, N'sa6', CAST(N'2017-01-23 13:22:44.887' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3249, N'sa6', CAST(N'2017-01-23 18:07:01.793' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3250, N'sa6', CAST(N'2017-01-23 18:30:19.787' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3251, N'sa6', CAST(N'2017-01-24 00:30:02.603' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3252, N'sagarwal', CAST(N'2017-01-24 00:33:34.143' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3253, N'sa6', CAST(N'2017-01-24 00:34:46.227' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3254, N'sa6', CAST(N'2017-01-24 00:43:50.823' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3255, N'sa6', CAST(N'2017-01-24 07:47:05.477' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3256, N'sa6', CAST(N'2017-01-24 07:48:35.900' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3257, N'sa6', CAST(N'2017-01-24 07:49:30.067' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3258, N'sa6', CAST(N'2017-01-24 08:07:47.223' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3259, N'sa6', CAST(N'2017-01-24 08:08:56.697' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3260, N'sa6', CAST(N'2017-01-24 08:31:17.033' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3261, N'sa6', CAST(N'2017-01-24 08:38:41.003' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3262, N'sa6', CAST(N'2017-01-24 08:58:15.830' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3263, N'sa6', CAST(N'2017-01-24 09:29:55.980' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3264, N'sa6', CAST(N'2017-01-24 18:27:32.180' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3265, N'BARR6', CAST(N'2017-01-24 18:31:07.933' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3266, N'sa6', CAST(N'2017-01-24 18:34:02.537' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3267, N'sagarwal', CAST(N'2017-01-24 18:34:18.597' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3268, N'BARR6', CAST(N'2017-01-24 18:38:12.290' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3269, N'BARR6', CAST(N'2017-01-24 18:38:49.307' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3270, N'SEIG1', CAST(N'2017-01-24 18:39:45.573' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3271, N'sa6', CAST(N'2017-01-25 00:19:37.317' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3272, N'sagarwal', CAST(N'2017-01-25 00:20:49.033' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3273, N'sagarwal', CAST(N'2017-01-25 00:24:30.633' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3274, N'sagarwal', CAST(N'2017-01-25 00:26:15.630' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3275, N'sa6', CAST(N'2017-01-25 00:36:34.040' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3276, N'sa6', CAST(N'2017-01-25 09:27:22.490' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3277, N'sa6', CAST(N'2017-01-25 09:29:48.760' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3278, N'sa6', CAST(N'2017-01-25 09:31:48.763' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3279, N'sa6', CAST(N'2017-01-25 10:13:20.110' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3280, N'sa6', CAST(N'2017-01-25 10:19:46.850' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3281, N'sa6', CAST(N'2017-01-25 10:21:58.383' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3282, N'sa6', CAST(N'2017-01-25 10:22:25.973' AS DateTime), N'login')
GO
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3283, N'sa6', CAST(N'2017-01-25 11:01:14.223' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3284, N'sa6', CAST(N'2017-01-25 11:53:35.670' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3285, N'sa6', CAST(N'2017-01-25 11:54:15.990' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3286, N'sa6', CAST(N'2017-01-25 13:59:54.153' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3287, N'sa6', CAST(N'2017-01-25 16:25:58.140' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3288, N'sa6', CAST(N'2017-01-25 17:32:14.290' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3289, N'sa6', CAST(N'2017-01-25 20:24:09.360' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3290, N'sa6', CAST(N'2017-01-25 22:32:48.327' AS DateTime), N'login')
INSERT [dbo].[UsrLog] ([Id], [Code], [mdate], [mType]) VALUES (3291, N'sa6', CAST(N'2017-01-26 08:17:48.660' AS DateTime), N'login')
SET IDENTITY_INSERT [dbo].[UsrLog] OFF
ALTER TABLE [dbo].[TaxNShipping] ADD  CONSTRAINT [DF_TaxNShipping_SalesTaxPerc]  DEFAULT ((0)) FOR [SalesTaxPerc]
GO
ALTER TABLE [dbo].[TaxNShipping] ADD  CONSTRAINT [DF_TaxNShipping_ShippingCharges]  DEFAULT ((0)) FOR [ShippingCharges]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_OfferMaster] FOREIGN KEY([OfferId])
REFERENCES [dbo].[OfferMaster] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_OfferMaster]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_OrderMaster] FOREIGN KEY([OrderId])
REFERENCES [dbo].[OrderMaster] ([Id])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_OrderMaster]
GO
ALTER TABLE [dbo].[OrderImpDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderImpDetails_PaymentMethods] FOREIGN KEY([CreditCardId])
REFERENCES [dbo].[PaymentMethods] ([Id])
GO
ALTER TABLE [dbo].[OrderImpDetails] CHECK CONSTRAINT [FK_OrderImpDetails_PaymentMethods]
GO
ALTER TABLE [dbo].[OrderImpDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderImpDetails_ShippingAddresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[ShippingAddresses] ([Id])
GO
ALTER TABLE [dbo].[OrderImpDetails] CHECK CONSTRAINT [FK_OrderImpDetails_ShippingAddresses]
GO
ALTER TABLE [dbo].[OrderMaster]  WITH CHECK ADD  CONSTRAINT [FK_OrderMaster_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[OrderMaster] CHECK CONSTRAINT [FK_OrderMaster_UserMaster]
GO
ALTER TABLE [dbo].[States]  WITH NOCHECK ADD  CONSTRAINT [FK_States_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([CountryId])
GO
ALTER TABLE [dbo].[States] CHECK CONSTRAINT [FK_States_Countries]
GO
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD  CONSTRAINT [FK_UserProfiles_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[UserProfiles] CHECK CONSTRAINT [FK_UserProfiles_UserMaster]
GO
