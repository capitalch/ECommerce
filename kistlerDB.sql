USE [KistlerDB]
GO
ALTER TABLE [dbo].[UserProfiles] DROP CONSTRAINT [FK_UserProfiles_UserMaster]
GO
ALTER TABLE [dbo].[States] DROP CONSTRAINT [FK_States_Countries]
GO
ALTER TABLE [dbo].[ShippingAddressesOld] DROP CONSTRAINT [FK_ShippingAddresses_UserMaster]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [FK_OrderMaster_UserMaster]
GO
ALTER TABLE [dbo].[OrderImpDetails] DROP CONSTRAINT [FK_OrderImpDetails_ShippingAddresses]
GO
ALTER TABLE [dbo].[OrderImpDetails] DROP CONSTRAINT [FK_OrderImpDetails_CreditCards]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_OrderMaster]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [FK_OrderDetails_OfferMaster]
GO
ALTER TABLE [dbo].[CreditCards] DROP CONSTRAINT [FK_CreditCards_UserProfiles]
GO
ALTER TABLE [dbo].[TaxNShipping] DROP CONSTRAINT [DF_TaxNShipping_ShippingCharges]
GO
ALTER TABLE [dbo].[TaxNShipping] DROP CONSTRAINT [DF_TaxNShipping_SalesTaxPerc]
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[UserProfiles]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[UserMaster]
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[TaxNShipping]
GO
/****** Object:  Table [dbo].[States]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[States]
GO
/****** Object:  Table [dbo].[ShippingAddressesOld]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[ShippingAddressesOld]
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[ShippingAddresses]
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[Setup]
GO
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[PaymentMethods]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[OrderMaster]
GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[OrderImpDetails]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[OfferMaster]
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[OfferDetails]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[CreditCards]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 12/13/2016 6:18:17 PM ******/
DROP TABLE [dbo].[Countries]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[CreditCards]    Script Date: 12/13/2016 6:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CreditCards](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CardName] [varchar](64) NOT NULL,
	[UserId] [int] NOT NULL,
	[CardNumber] [varchar](50) NOT NULL,
	[ExpiryDate] [smalldatetime] NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_CreditCards_IsDefault]  DEFAULT ((0)),
 CONSTRAINT [PK_CreditCards] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 12/13/2016 6:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderImpDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[AddressId] [int] NOT NULL,
	[CreditCardId] [int] NOT NULL,
 CONSTRAINT [PK_OrderImpDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[PaymentMethods]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[Setup]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 12/13/2016 6:18:17 PM ******/
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
 CONSTRAINT [PK_ShippingAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShippingAddressesOld]    Script Date: 12/13/2016 6:18:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingAddressesOld](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Address1] [varchar](256) NOT NULL,
	[Zip] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_ShippingAddresses_IsDefault]  DEFAULT ((0)),
	[State] [varchar](50) NULL,
 CONSTRAINT [PK_ShippingAddressesOld] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[States]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 12/13/2016 6:18:17 PM ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 12/13/2016 6:18:17 PM ******/
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
 CONSTRAINT [PK_UserMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 12/13/2016 6:18:17 PM ******/
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
 CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED 
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
SET IDENTITY_INSERT [dbo].[CreditCards] ON 

INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (42, N'Visa', 1, N'5655567556766556567', CAST(N'2019-11-22 00:00:00' AS SmallDateTime), 1)
INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (43, N'Master Card', 1, N'1211212', CAST(N'2019-12-11 00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (44, N'American Express', 1, N'45454444555', CAST(N'2020-11-12 00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (45, N'wqwe', 9, N'qwewew', CAST(N'2016-11-25 00:00:00' AS SmallDateTime), 1)
SET IDENTITY_INSERT [dbo].[CreditCards] OFF
SET IDENTITY_INSERT [dbo].[OfferMaster] ON 

INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (6, N'2014 Dutton Ranch Chardonnay ', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Produced since 1979. Wine grapes planted to what was once the premiere apple growing region of western Sonoma County, located in the heart of the Sonoma Coast region. Annually results in a wine of precision, with focused, structural acids layered ...', N'img5.jpg', N'Antonio Galloni Score: 91-94 <br/> The 2014 Chardonnay Dutton Ranch is beautifully centered. Hints of almond, white flowers and lemon peel flesh out in a Chardonnay that exudes depth. Oily and textured on the palate, yet also tightly wound…')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (7, N'2014 Hudson Vineyard Chardonnay', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Sourced since 1994. Located in the southwestern reaches of Napa County, where a rare mix of volcanic and marine sediment soils meet to produce a wine of depth and elegance, often touched with high pitched tones of iodine, and an oyster shell like minerality...', N'img2.jpg', N'Antonio Galloni Score: 94-97 <br/> One of the clear highlights today, the 2014 Chardonnay Hudson Vineyard is simply magnificent. Striking aromatics make a strong first impression. Yellow orchard fruit, mint and white pepper are all finely knit ...')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (8, N'2014 Stone Flat Chardonnay', CAST(80 AS Decimal(4, 0)), N'b', 6, N'Sourced since 2002. Located in the western portion of Carneros, where the soils are driven by heavy river run cobble, but the air is dominated by afternoon winds from the Pacific. Produces a wine that strikes an impeccable balance ...', N'img3.jpg', N'Antonio Galloni Score: 91-94 <br/> The 2014 Chardonnay Stone Flat Vineyard is right across the road from Durrell, yet it is so remarkably different in style. Candied lemon, honey and mint are all pushed forward.')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (9, N'2014 Pinot Noir Kistler Vineyard', CAST(90 AS Decimal(4, 0)), N'b', 6, N'This ridge-top vineyard looks to the coast in one direction and the Russian River Valley in the other. The Vineyard sits on layers of sandstone, granular sediments and some petrified wood ...', N'img4.jpg', N'Robert Parker Jr. Score: 90-92 <br/> The two tank samples of the 2014 Pinot Noirs showed a more restrained, softer style of wines that are more front-end loaded. ...')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (10, N'2014 6-Bottle Pinot Noir Package*', CAST(540 AS Decimal(4, 0)), N'p', 3, N'', N'img1.jpg', N'6 Bottles of 2014 Kistler Pinot Noir.')
SET IDENTITY_INSERT [dbo].[OfferMaster] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (223, 73, 10, 0, 1, CAST(540 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderImpDetails] ON 

INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (28, 73, 22, 42)
SET IDENTITY_INSERT [dbo].[OrderImpDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderMaster] ON 

INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (73, CAST(N'2016-12-01' AS Date), N'37', 1, NULL, 0, NULL, CAST(626 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(45.90 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(540.00 AS Decimal(10, 2)))
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
', N'OR', 1, 1)
INSERT [dbo].[PaymentMethods] ([Id], [Code], [CardName], [CCFirstName], [CCLastName], [CCType], [CCNumber], [CCExpiryMonth], [CCExpiryYear], [CCSecurityCode], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (8, NULL, N'MasterCard', N'Donette
', N'Foller
', N'Master Card', N'5105105105105100', N'4', N'2025', N'332', N'Donette
 Foller
', N'513-570-1893
', NULL, N'34 Center St
', NULL, N'Hamilton
', N'OH
', N'45011
', N'Butler
', N'BU', 0, 1)
SET IDENTITY_INSERT [dbo].[PaymentMethods] OFF
SET IDENTITY_INSERT [dbo].[Setup] ON 

INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (1, N'MaxOrderNumber', 37, NULL)
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (2, N'DefaultSalesTaxPerc', 0, N'8.5')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (3, N'DefaultShippingCharges', 0, N'20')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (4, N'AdminPwdHash', 0, N'21232f297a57a5a743894a0e4a801fc3')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (5, N'AdminIp', 0, N'223.29.199.212')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (6, N'SmartyStreetApiKey', 0, N'21047913783681978')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (7, N'SmartyStreetAuthToken', 0, N'ikDR4hndQSAScpWSPdj8')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (8, N'SmartyStreetAuthId', 0, N'63395b2b-4df2-c8c7-a487-21ecc25979c8')
SET IDENTITY_INSERT [dbo].[Setup] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddresses] ON 

INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (2, N'Test', N'James Butt1', N'(454) 554-5455', NULL, N' 525 Wyoming Blvd NE', N'Ridge Blvd', N'Albuquerque', N'NM', N'87123', N'Angola', N'AO', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (3, N'Test', N'Josephine Darakjy
', N'810-292-9388', NULL, N' 525 Wyoming Blvd NE', N'', N'Albuquerque', N'NM', N'87123', N'Angola', N'AO', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (4, N'Test', N'qweqwe', N'(983) 105-2442', NULL, N'qweqweq', N'weqeqe', N'qweqe', N'qweqwe', N'12345', N'Albania', N'AL', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (5, N'Test', N'Sushant', N'(777) 765-6665', NULL, N'P 161', N'VIP', N'Kolkata', N'West Bengal', N'80001', N'Angola', N'AO', 1, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (6, N'Test', N'dsadadas', N'3333333', NULL, N'dasdasda', N'sdasd', N'asdsadasdasdada', N'dasdsa', N'dada', N'Bangladesh', N'BD', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (7, N'Test', N'adsas', N'1121212', NULL, N'dasdas', N'dasd', N'asdasd', N'asdasd', N'asdasdadasdasd', N'Albania', N'AL', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (8, N'Test', N's', N'(888) 888-8888', NULL, N's', N's', N's', N's', N'12222', N'Angola', N'AO', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (9, N'Test', N'Sushant Agrawal', N'8888777', NULL, N'12 j. L. Nehru Road', N'Esplanade', N'Kolkata', N'WB', N'70001', N'Bangladesh', N'BD', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (10, N'Test', N'dd', N'dddd', NULL, N'dd', N'dd', N'ddd', N'ddd', N's', N'Bahamas', N'BS', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (11, N'Test', N'12121', N'4444444', NULL, N'211221', N'454545', N'4545', N'4545', N'11111', N'Angola', N'AO', 0, 1)
INSERT [dbo].[ShippingAddresses] ([Id], [Code], [Name], [Phone], [Co], [Street1], [Street2], [City], [State], [Zip], [Country], [ISOCode], [IsDefault], [userId]) VALUES (12, N'Test', N'wwww', N'(121) 221-2122', NULL, N'ww', N'ww', N'www', N'w', N'11111', N'Angola', N'AO', 0, 1)
SET IDENTITY_INSERT [dbo].[ShippingAddresses] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddressesOld] ON 

INSERT [dbo].[ShippingAddressesOld] ([Id], [UserId], [Address1], [Zip], [City], [IsDefault], [State]) VALUES (22, 1, N'P 161', N'22287', N'Kolkata', 1, N'WB')
SET IDENTITY_INSERT [dbo].[ShippingAddressesOld] OFF
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
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (1, N'sagarwal@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (4, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (5, N'sagarwal1@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (6, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (7, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (8, N'tchakraborty@netwoven.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (9, N'ssaha@netwoven.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (10, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (11, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (12, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (15, N'sas@gmail.com', N'a8a64cef262a04de4872b68b63ab7cd8', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (16, N'sas1@gmail.com', N'a8a64cef262a04de4872b68b63ab7cd8', N'u')
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
SET IDENTITY_INSERT [dbo].[UserProfiles] ON 

INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry]) VALUES (1, N'Sushant', N'Agrawal', N'9998887612', CAST(N'1963-11-19 00:00:00' AS SmallDateTime), N'a1', N'a', N'a', N'a', N'700012', 4, CAST(200.00 AS Decimal(12, 2)), CAST(-190.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry]) VALUES (7, N'Sushant', N'Agrawal', N'9831052332', CAST(N'1963-11-07 00:00:00' AS SmallDateTime), N'12 JL', NULL, N'Kolkata', N'WB', N'7000133', 4, CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), NULL)
INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl], [MailingCountry]) VALUES (9, N'Sushant', N'Agrawal', N'(919) 831-0523', CAST(N'2016-12-12 00:00:00' AS SmallDateTime), N'aaa2', N'aaa1', N'aaa', N'2bv', N'2221', 1, CAST(0.00 AS Decimal(12, 2)), CAST(0.00 AS Decimal(12, 2)), N'Bahamas')
SET IDENTITY_INSERT [dbo].[UserProfiles] OFF
ALTER TABLE [dbo].[TaxNShipping] ADD  CONSTRAINT [DF_TaxNShipping_SalesTaxPerc]  DEFAULT ((0)) FOR [SalesTaxPerc]
GO
ALTER TABLE [dbo].[TaxNShipping] ADD  CONSTRAINT [DF_TaxNShipping_ShippingCharges]  DEFAULT ((0)) FOR [ShippingCharges]
GO
ALTER TABLE [dbo].[CreditCards]  WITH CHECK ADD  CONSTRAINT [FK_CreditCards_UserProfiles] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[CreditCards] CHECK CONSTRAINT [FK_CreditCards_UserProfiles]
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
ALTER TABLE [dbo].[OrderImpDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderImpDetails_CreditCards] FOREIGN KEY([CreditCardId])
REFERENCES [dbo].[CreditCards] ([Id])
GO
ALTER TABLE [dbo].[OrderImpDetails] CHECK CONSTRAINT [FK_OrderImpDetails_CreditCards]
GO
ALTER TABLE [dbo].[OrderImpDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderImpDetails_ShippingAddresses] FOREIGN KEY([AddressId])
REFERENCES [dbo].[ShippingAddressesOld] ([Id])
GO
ALTER TABLE [dbo].[OrderImpDetails] CHECK CONSTRAINT [FK_OrderImpDetails_ShippingAddresses]
GO
ALTER TABLE [dbo].[OrderMaster]  WITH CHECK ADD  CONSTRAINT [FK_OrderMaster_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[OrderMaster] CHECK CONSTRAINT [FK_OrderMaster_UserMaster]
GO
ALTER TABLE [dbo].[ShippingAddressesOld]  WITH CHECK ADD  CONSTRAINT [FK_ShippingAddresses_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[ShippingAddressesOld] CHECK CONSTRAINT [FK_ShippingAddresses_UserMaster]
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
