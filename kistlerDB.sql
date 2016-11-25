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
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[UserProfiles]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[UserMaster]
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[TaxNShipping]
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[ShippingAddresses]
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[Setup]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[OrderMaster]
GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[OrderImpDetails]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[OfferMaster]
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[OfferDetails]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 11/25/2016 9:20:10 AM ******/
DROP TABLE [dbo].[CreditCards]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[Setup]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 11/25/2016 9:20:10 AM ******/
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
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 11/25/2016 9:20:10 AM ******/
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

INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (6, N'2014 Kistler - Chardonnay Sonoma Mountain', CAST(60 AS Decimal(4, 0)), N'b', 5, N'Lorem ipsum dolor sit amet, ea his quando maiorum verterem. Ei pri everti consulatu definitiones, qui magna putent evertitur ad, at mei duis error sapientem. No est ipsum ignota platonem, iisque laoreet feugait an sit. Ad nemore prodesset vix. Pro congue soluta et, ullamcorper complectitur est te', N'img1.jpg', N'Lorem ipsum dolor sit amet, te quaeque maiestatis reprimique mel. Cu quo dolores offendit. Autem imperdiet nam ei. Modo epicuri in duo, ex qui amet sanctus volutpat. Ius dicit integre appareat et')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (7, N'2014 Kistler - Chardonnay Dutton Ranch (formerly RRV)', CAST(100 AS Decimal(4, 0)), N'b', 4, N'Odio ipsum mei no, in usu labore utamur intellegat. Duo ferri atomorum an, his alii consequat eu. Ne zril hendrerit his, in euismod fierent fastidii vel. Eam an amet nisl tincidunt, est ex errem laboramus constituto. Nec graecis epicurei aliquando cu. Mei cu alii meliore vivendo, mea ut ceteros percipit.
', N'img2.jpg', N'Eum ad utinam salutandi. Ne sit case legimus voluptatum. Modus everti vocent ius ex, vim choro fuisset pertinacia in, velit vivendum prodesset ea vix. Ad eos invidunt voluptaria, petentium interesset duo ex. V')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (8, N'2014 Kistler - Chardonnay Durell Vineyard', CAST(100 AS Decimal(4, 0)), N'p', 2, N'Ea qui option mentitum abhorreant. Elit scripta consulatu sed ei, qui tacimates pericula definitionem an. Ut tollit iracundia sed, eligendi menandri eam ne, cum aeterno officiis te. Duo ut discere scripserit liberavisse, eos te eripuit qualisque. Inani putent vis no. Et falli omnesque has, eum ut impedit antiopam.', N'img3.jpg', N'velit vivendum prodesset ea vix. Ad eos invidunt voluptaria, petentium interesset duo ex. Vit vim an, ne semper facilisis liberavisse usu. Sea expetenda molestiae ea')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (9, N'2013 Kistler - Chardonnay Hyde Vineyard', CAST(129 AS Decimal(4, 0)), N'b', 6, N'
Mollis animal has et. Vix timeam assueverit ex, at pro percipit intellegat omittantur, ei dicta solet iudico mei. Eu sumo insolens ius, no mei doctus expetenda. Nam viris fuisset adversarium ne, nec nisl invidunt dissentias cu, ea qui postea menandri maiestatis.', N'img4.jpg', N' Et volumus accumsan forensibus nec, persius repudiandae no qui, dico vituperatoribus te pro. No eos duis causae neglegentur, sed soleat sapientem assueverit cu. Qui')
INSERT [dbo].[OfferMaster] ([Id], [Item], [Price], [Packing], [AvailableQty], [TastingNotes], [ImageUrl], [Descr]) VALUES (10, N'2013 Kistler - Pinot Noir Kistler Vineyard', CAST(125 AS Decimal(4, 0)), N'b', 4, N'
Sonet option no qui, his reprimique necessitatibus eu, quod blandit comprehensam pro ex. Ei maiestatis voluptatum delicatissimi cum, te quod brute assum mei. Sea ne vocent assentior rationibus, velit nusquam sapientem eam te. Ei cum soluta platonem repudiare, ex per nostrud aliquid impedit.', N'img5.jpg', N'an, at nam quem omittam perpetua. Per ex delectus inciderint, at omittam convenire pro. ')
SET IDENTITY_INSERT [dbo].[OfferMaster] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (197, 60, 6, 1, 2, CAST(60 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (198, 60, 7, 1, 2, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (199, 60, 8, 2, 2, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (200, 60, 9, 3, 2, CAST(129 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (201, 60, 10, 2, 4, CAST(125 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (202, 61, 6, 1, 8, CAST(60 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (203, 61, 7, 4, 3, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (204, 61, 8, 8, 3, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (205, 61, 9, 5, 4, CAST(129 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (206, 61, 10, 4, 4, CAST(125 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (207, 62, 6, 3, 3, CAST(60 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (208, 62, 7, 2, 2, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (209, 62, 8, 0, 0, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (210, 62, 9, 2, 0, CAST(129 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (211, 62, 10, 2, 2, CAST(125 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (212, 63, 9, 1, 0, CAST(129 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (213, 64, 7, 1, 0, CAST(100 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (214, 65, 9, 0, 1, CAST(129 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (215, 66, 6, 1, 1, CAST(60 AS Decimal(10, 0)))
INSERT [dbo].[OrderDetails] ([Id], [OrderId], [OfferId], [OrderQty], [WishList], [Price]) VALUES (216, 66, 7, 0, 1, CAST(100 AS Decimal(10, 0)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderImpDetails] ON 

INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (15, 60, 6, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (16, 61, 6, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (17, 62, 1, 44)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (18, 63, 6, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (19, 64, 6, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (20, 65, 6, 43)
INSERT [dbo].[OrderImpDetails] ([Id], [OrderId], [AddressId], [CreditCardId]) VALUES (21, 66, 6, 43)
SET IDENTITY_INSERT [dbo].[OrderImpDetails] OFF
SET IDENTITY_INSERT [dbo].[OrderMaster] ON 

INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (60, CAST(N'2016-11-24' AS Date), N'24', 1, NULL, 0, NULL, CAST(2508 AS Decimal(10, 0)), CAST(84.75 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(997 AS Decimal(10, 0)), CAST(108.63 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(1278.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (61, CAST(N'2016-11-24' AS Date), N'25', 1, NULL, 0, NULL, CAST(4924 AS Decimal(10, 0)), CAST(204.43 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(2405 AS Decimal(10, 0)), CAST(178.16 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(2096.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (62, CAST(N'2016-11-24' AS Date), N'26', 1, NULL, 0, NULL, CAST(1687 AS Decimal(10, 0)), CAST(75.48 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(888 AS Decimal(10, 0)), CAST(53.55 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(630.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (63, CAST(N'2016-11-24' AS Date), N'27', 1, NULL, 0, NULL, CAST(180 AS Decimal(10, 0)), CAST(10.96 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(129 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (64, CAST(N'2016-11-24' AS Date), N'28', 1, NULL, 0, NULL, CAST(149 AS Decimal(10, 0)), CAST(8.50 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(100 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(0.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (65, CAST(N'2016-11-24' AS Date), N'29', 1, NULL, 0, NULL, CAST(180 AS Decimal(10, 0)), CAST(0.00 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(0 AS Decimal(10, 0)), CAST(10.96 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(129.00 AS Decimal(10, 2)))
INSERT [dbo].[OrderMaster] ([Id], [MDate], [OrderNo], [UserId], [Descr], [IsDelivered], [Invoice], [Amount], [SalesTaxWine], [ShippingWine], [TotalPriceWine], [SalesTaxAddl], [ShippingAddl], [TotalPriceAddl]) VALUES (66, CAST(N'2016-11-24' AS Date), N'30', 1, NULL, 0, NULL, CAST(279 AS Decimal(10, 0)), CAST(5.10 AS Decimal(10, 2)), CAST(20 AS Decimal(10, 0)), CAST(60 AS Decimal(10, 0)), CAST(13.60 AS Decimal(10, 2)), CAST(20.00 AS Decimal(10, 2)), CAST(160.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[OrderMaster] OFF
SET IDENTITY_INSERT [dbo].[Setup] ON 

INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (1, N'MaxOrderNumber', 30, NULL)
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (2, N'DefaultSalesTaxPerc', 0, N'8.5')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (3, N'DefaultShippingCharges', 0, N'20')
SET IDENTITY_INSERT [dbo].[Setup] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddresses] ON 

INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (1, 1, N'916 West Greystone Drive ', N'55372', N'Prior Lake', N'MN', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (2, 1, N'7977 Branch Street1 ', N'46201', N'Indianapolis', N'IN', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (4, 1, N'Atwater', N'95301', N'22 SE. Arlington St', N'CA', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (5, 1, N'vip road', N'700054', N'vip', N'Kolkata', 0)
INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [Street], [City], [IsDefault]) VALUES (6, 1, N'asda', N'dasdas', N'dasd', N'asdasd', 1)
SET IDENTITY_INSERT [dbo].[ShippingAddresses] OFF
SET IDENTITY_INSERT [dbo].[UserMaster] ON 

INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (1, N'sagarwal@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (4, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (5, N'sagarwal1@netwoven.com', N'dea5687d7786d43266cf55d7be014530', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (6, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (7, N'sa@gmail.com', N'abcd', N'U')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (8, N'tchakraborty@netwoven.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (9, N'ssaha@netwoven.com', N'827ccb0eea8a706c4c34a16891f84e7b', N'u')
INSERT [dbo].[UserMaster] ([Id], [Email], [PwdHash], [Role]) VALUES (10, N'sa@gmail.com', N'abcd', N'U')
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
