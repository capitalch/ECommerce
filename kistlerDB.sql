USE [KistlerDB]
GO
ALTER TABLE [dbo].[UserProfiles] DROP CONSTRAINT [FK_UserProfiles_UserMaster]
GO
ALTER TABLE [dbo].[ShippingAddresses] DROP CONSTRAINT [FK_ShippingAddresses_UserMaster]
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
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[UserProfiles]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[UserMaster]
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[TaxNShipping]
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[ShippingAddresses]
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[Setup]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[OrderMaster]
GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[OrderImpDetails]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[OfferMaster]
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[OfferDetails]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 11/23/2016 12:36:12 PM ******/
DROP TABLE [dbo].[CreditCards]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
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
 CONSTRAINT [PK_OfferMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[Setup]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 11/23/2016 12:36:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingAddresses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Address1] [varchar](256) NOT NULL,
	[Zip] [varchar](50) NOT NULL,
	[Street] [varchar](256) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_ShippingAddresses_IsDefault]  DEFAULT ((0)),
 CONSTRAINT [PK_ShippingAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 11/23/2016 12:36:12 PM ******/
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
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 11/23/2016 12:36:12 PM ******/
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
 CONSTRAINT [PK_UserProfiles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[CreditCards] ON 

INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (42, N'Visa', 1, N'5655567556766556567', CAST(N'2019-11-22 00:00:00' AS SmallDateTime), 0)
INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (43, N'Master Card', 1, N'1211212', CAST(N'2019-12-11 00:00:00' AS SmallDateTime), 1)
INSERT [dbo].[CreditCards] ([Id], [CardName], [UserId], [CardNumber], [ExpiryDate], [IsDefault]) VALUES (44, N'American Express', 1, N'45454444555', CAST(N'2020-11-12 00:00:00' AS SmallDateTime), 0)
SET IDENTITY_INSERT [dbo].[CreditCards] OFF
SET IDENTITY_INSERT [dbo].[OfferMaster] ON 

INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty]) VALUES (1, N'1792 Full Proof', CAST(120 AS Decimal(4, 0)), N'p', 14)
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty]) VALUES (2, N'200th Anniversary Evan Williams', CAST(200 AS Decimal(4, 0)), N'b', 12)
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty]) VALUES (3, N'A.H. Hirsch Finest Reserve 20', CAST(123 AS Decimal(4, 0)), N'b', 12)
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty]) VALUES (4, N'Aberlour 12 Double Cask Matured', CAST(250 AS Decimal(4, 0)), N'p', 4)
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty]) VALUES (5, N'Aberlour 18 year', CAST(450 AS Decimal(4, 0)), N'b', 6)
SET IDENTITY_INSERT [dbo].[OfferMaster] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (152, 51, 1, 2, 1, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (153, 51, 2, 1, 4, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (154, 51, 3, 6, 2, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (155, 51, 4, 2, 2, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (156, 51, 5, 1, 2, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (157, 52, 1, 1, 2, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (158, 52, 2, 2, 4, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (159, 52, 3, 2, 2, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (160, 52, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (161, 52, 5, 2, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (162, 53, 1, 1, 1, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (163, 53, 2, 1, 1, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (164, 53, 3, 0, 0, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (165, 53, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (166, 53, 5, 0, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (167, 54, 1, 1, 0, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (168, 54, 2, 1, 0, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (169, 54, 3, 1, 0, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (170, 54, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (171, 54, 5, 0, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (172, 55, 1, 1, 0, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (173, 55, 2, 1, 0, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (174, 55, 3, 0, 0, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (175, 55, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (176, 55, 5, 0, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (177, 56, 1, 1, 0, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (178, 56, 2, 1, 0, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (179, 56, 3, 0, 0, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (180, 56, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (181, 56, 5, 0, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (182, 57, 1, 1, 0, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (183, 57, 2, 1, 0, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (184, 57, 3, 0, 0, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (185, 57, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (186, 57, 5, 0, 0, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (187, 58, 1, 1, 1, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (188, 58, 2, 1, 1, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (189, 58, 3, 1, 1, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (190, 58, 4, 1, 1, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (191, 58, 5, 1, 1, CAST(450 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (192, 59, 1, 1, 0, CAST(120 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (193, 59, 2, 1, 1, CAST(200 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (194, 59, 3, 1, 1, CAST(123 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (195, 59, 4, 0, 0, CAST(250 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (196, 59, 5, 0, 1, CAST(450 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderImpDetails] ON 

INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (6, 51, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (7, 52, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (8, 53, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (9, 54, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (10, 55, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (11, 56, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (12, 57, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (13, 58, 4, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (14, 59, 4, 43)
SET IDENTITY_INSERT [dbo].[OrderImpDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderMaster] ON 

INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (46, CAST(N'2016-11-23' AS Date), N'10', 1, NULL, 0, NULL, CAST(7803 AS Decimal(10, 0)), CAST(461.55 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(5430 AS Decimal(10, 0)), CAST(146.63 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(1725.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (47, CAST(N'2016-11-23' AS Date), N'11', 1, NULL, 0, NULL, CAST(5669 AS Decimal(10, 0)), CAST(208.68 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(2455 AS Decimal(10, 0)), CAST(232.31 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(2733.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (48, CAST(N'2016-11-23' AS Date), N'12', 1, NULL, 0, NULL, CAST(13033 AS Decimal(10, 0)), CAST(421.51 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(4959 AS Decimal(10, 0)), CAST(596.36 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(7016.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (49, CAST(N'2016-11-23' AS Date), N'13', 1, NULL, 0, NULL, CAST(13033 AS Decimal(10, 0)), CAST(421.51 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(4959 AS Decimal(10, 0)), CAST(596.36 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(7016.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (50, CAST(N'2016-11-23' AS Date), N'14', 1, NULL, 0, NULL, CAST(7442 AS Decimal(10, 0)), CAST(236.56 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(2783 AS Decimal(10, 0)), CAST(343.31 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(4039.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (51, CAST(N'2016-11-23' AS Date), N'15', 1, NULL, 0, NULL, CAST(5133 AS Decimal(10, 0)), CAST(180.88 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(2128 AS Decimal(10, 0)), CAST(218.11 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(2566.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (52, CAST(N'2016-11-23' AS Date), N'16', 1, NULL, 0, NULL, CAST(3243 AS Decimal(10, 0)), CAST(141.61 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(1666 AS Decimal(10, 0)), CAST(109.31 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(1286.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (53, CAST(N'2016-11-23' AS Date), N'17', 1, NULL, 0, NULL, CAST(734 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(320 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(320.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (54, CAST(N'2016-11-23' AS Date), N'18', 1, NULL, 0, NULL, CAST(521 AS Decimal(10, 0)), CAST(37.66 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(443 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (55, CAST(N'2016-11-23' AS Date), N'19', 1, NULL, 0, NULL, CAST(387 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(320 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (56, CAST(N'2016-11-23' AS Date), N'20', 1, NULL, 0, NULL, CAST(387 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(320 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (57, CAST(N'2016-11-23' AS Date), N'21', 1, NULL, 0, NULL, CAST(387 AS Decimal(10, 0)), CAST(27.20 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(320 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (58, CAST(N'2016-11-23' AS Date), N'22', 1, NULL, 0, NULL, CAST(2520 AS Decimal(10, 0)), CAST(97.16 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(1143 AS Decimal(10, 0)), CAST(97.16 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(1143.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (59, CAST(N'2016-11-23' AS Date), N'23', 1, NULL, 0, NULL, CAST(1359 AS Decimal(10, 0)), CAST(37.66 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(443 AS Decimal(10, 0)), CAST(65.70 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(773.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderMaster] OFF
SET IDENTITY_INSERT [dbo].[Setup] ON 

INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (1, N'MaxOrderNumber', 23, NULL)
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (2, N'DefaultSalesTaxPerc', 0, N'8.5')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (3, N'DefaultShippingCharges', 0, N'20')
SET IDENTITY_INSERT [dbo].[Setup] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddresses] ON 

INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (1, 1, N'916 West Greystone Drive ', N'55372', N'Prior Lake', N'MN', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (2, 1, N'7977 Branch Street ', N'46201', N'Indianapolis', N'IN', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (4, 1, N'Atwater', N'95301', N'22 SE. Arlington St', N'CA', 1)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (5, 1, N'vip road', N'700054', N'vip', N'Kolkata', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (6, 1, N'asda', N'dasdas', N'dasd', N'asdasd', 0)
SET IDENTITY_INSERT [dbo].[ShippingAddresses] OFF
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (1, N'sagarwal@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (4, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (5, N'sagarwal1@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (6, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (7, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (8, N'tchakraborty@netwoven.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'u')
SET IDENTITY_INSERT [dbo].[UserMaster] OFF
SET IDENTITY_INSERT [dbo].[UserProfiles] ON 

INSERT [dbo].[UserProfiles] ([Id], [FirstName], [LastName], [Phone], [BirthDay], [MailingAddress1], [MailingAddress2], [MailingCity], [MailingState], [MailingZip], [UserId], [PrevBalanceWine], [PrevBalanceAddl]) VALUES (1, N'Sushant', N'Agrawal', N'99988876', CAST(N'1963-11-07 00:00:00' AS SmallDateTime), N'a', N'a', N'a', N'a', N'700012', 1, CAST(200.00 AS Decimal(12, 2)), CAST(-190.00 AS Decimal(12, 2)))
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
REFERENCES [dbo].[ShippingAddresses] ([Id])
GO
ALTER TABLE [dbo].[OrderImpDetails] CHECK CONSTRAINT [FK_OrderImpDetails_ShippingAddresses]
GO
ALTER TABLE [dbo].[OrderMaster]  WITH CHECK ADD  CONSTRAINT [FK_OrderMaster_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[OrderMaster] CHECK CONSTRAINT [FK_OrderMaster_UserMaster]
GO
ALTER TABLE [dbo].[ShippingAddresses]  WITH CHECK ADD  CONSTRAINT [FK_ShippingAddresses_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[ShippingAddresses] CHECK CONSTRAINT [FK_ShippingAddresses_UserMaster]
GO
ALTER TABLE [dbo].[UserProfiles]  WITH CHECK ADD  CONSTRAINT [FK_UserProfiles_UserMaster] FOREIGN KEY([UserId])
REFERENCES [dbo].[UserMaster] ([Id])
GO
ALTER TABLE [dbo].[UserProfiles] CHECK CONSTRAINT [FK_UserProfiles_UserMaster]
GO
