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
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_TotalPriceAddl]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_ShippingAddl]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_SalesTaxAddl]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_TotalPrice]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_Shipping]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_SalesTax]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_Amount]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_IsSupplied]
GO
ALTER TABLE [dbo].[OrderMaster] DROP CONSTRAINT [DF_OrderMaster_MDate]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [DF_OrderDetails_Price]
GO
ALTER TABLE [dbo].[OrderDetails] DROP CONSTRAINT [DF_OrderDetails_WishList]
GO
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[UserProfiles]
GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[UserMaster]
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[TaxNShipping]
GO
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[ShippingAddresses]
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[Setup]
GO
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[OrderMaster]
GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[OrderImpDetails]
GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[OrderDetails]
GO
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[OfferMaster]
GO
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[OfferDetails]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 12/1/2016 12:41:19 PM ******/
DROP TABLE [dbo].[CreditCards]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[OfferDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[OfferMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OrderId] [int] NOT NULL,
	[OfferId] [int] NOT NULL,
	[OrderQty] [smallint] NOT NULL,
	[WishList] [smallint] NOT NULL,
	[Price] [decimal](10, 0) NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderImpDetails]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[OrderMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OrderMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MDate] [date] NOT NULL,
	[OrderNo] [varchar](50) NOT NULL,
	[UserId] [int] NOT NULL,
	[Descr] [varchar](50) NULL,
	[IsDelivered] [bit] NOT NULL,
	[Invoice] [varchar](50) NULL,
	[Amount] [decimal](10, 0) NOT NULL,
	[SalesTaxWine] [decimal](10, 2) NOT NULL,
	[ShippingWine] [decimal](10, 0) NOT NULL,
	[TotalPriceWine] [decimal](10, 0) NOT NULL,
	[SalesTaxAddl] [decimal](10, 2) NOT NULL,
	[ShippingAddl] [decimal](10, 2) NOT NULL,
	[TotalPriceAddl] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_OrderMaster] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Setup]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[ShippingAddresses]    Script Date: 12/1/2016 12:41:19 PM ******/
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
	[City] [varchar](50) NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_ShippingAddresses_IsDefault]  DEFAULT ((0)),
	[State] [varchar](50) NULL,
 CONSTRAINT [PK_ShippingAddresses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TaxNShipping]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[UserMaster]    Script Date: 12/1/2016 12:41:19 PM ******/
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
/****** Object:  Table [dbo].[UserProfiles]    Script Date: 12/1/2016 12:41:19 PM ******/
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
SET IDENTITY_INSERT [dbo].[Setup] ON 

INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (1, N'MaxOrderNumber', 36, NULL)
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (2, N'DefaultSalesTaxPerc', 0, N'8.5')
INSERT [dbo].[Setup] ([Id], [MKey], [IntValue], [StringValue]) VALUES (3, N'DefaultShippingCharges', 0, N'20')
SET IDENTITY_INSERT [dbo].[Setup] OFF
SET IDENTITY_INSERT [dbo].[ShippingAddresses] ON 

INSERT [dbo].[ShippingAddresses] ([Id], [UserId], [Address1], [Zip], [City], [IsDefault], [State]) VALUES (22, 1, N'P 161', N'22287', N'Kolkata', 1, N'WB')
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
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_WishList]  DEFAULT ((0)) FOR [WishList]
GO
ALTER TABLE [dbo].[OrderDetails] ADD  CONSTRAINT [DF_OrderDetails_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_MDate]  DEFAULT (getdate()) FOR [MDate]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_IsSupplied]  DEFAULT ((0)) FOR [IsDelivered]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_SalesTax]  DEFAULT ((0)) FOR [SalesTaxWine]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_Shipping]  DEFAULT ((0)) FOR [ShippingWine]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_TotalPrice]  DEFAULT ((0)) FOR [TotalPriceWine]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_SalesTaxAddl]  DEFAULT ((0)) FOR [SalesTaxAddl]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_ShippingAddl]  DEFAULT ((0)) FOR [ShippingAddl]
GO
ALTER TABLE [dbo].[OrderMaster] ADD  CONSTRAINT [DF_OrderMaster_TotalPriceAddl]  DEFAULT ((0)) FOR [TotalPriceAddl]
GO
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
