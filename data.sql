USE [master]
GO
/****** Object:  Database [Assignment3_HuynhGiaBao]    Script Date: 07/03/2021 12:05:21 PM ******/
CREATE DATABASE [Assignment3_HuynhGiaBao]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Assignment3_HuynhGiaBao', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Assignment3_HuynhGiaBao.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Assignment3_HuynhGiaBao_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Assignment3_HuynhGiaBao_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Assignment3_HuynhGiaBao].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ARITHABORT OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET  MULTI_USER 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET QUERY_STORE = OFF
GO
USE [Assignment3_HuynhGiaBao]
GO
/****** Object:  Table [dbo].[tblCars]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCars](
	[carID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[color] [nvarchar](10) NOT NULL,
	[year] [int] NOT NULL,
	[categoryID] [varchar](10) NOT NULL,
	[price] [float] NOT NULL,
	[quantity] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblCars] PRIMARY KEY CLUSTERED 
(
	[carID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryID] [varchar](10) NOT NULL,
	[name] [varchar](10) NOT NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiscount]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscount](
	[discountID] [varchar](10) NOT NULL,
	[name] [nchar](10) NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[value] [int] NOT NULL,
 CONSTRAINT [PK_tblDiscount] PRIMARY KEY CLUSTERED 
(
	[discountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFeedbacks]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFeedbacks](
	[feedbackID] [int] IDENTITY(1,1) NOT NULL,
	[carID] [int] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[points] [int] NOT NULL,
	[comment] [varchar](500) NOT NULL,
	[orderDetailID] [int] NOT NULL,
 CONSTRAINT [PK_tblFeedbacks] PRIMARY KEY CLUSTERED 
(
	[feedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetails]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetails](
	[orderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[carID] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [float] NOT NULL,
	[orderID] [int] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[days] [int] NOT NULL,
 CONSTRAINT [PK_tblOrderDetails] PRIMARY KEY CLUSTERED 
(
	[orderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrders]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrders](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[total] [float] NOT NULL,
	[email] [varchar](50) NOT NULL,
	[discountID] [varchar](10) NULL,
	[status] [bit] NOT NULL,
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 07/03/2021 12:05:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[email] [varchar](50) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
	[password] [varchar](100) NOT NULL,
	[phone] [varchar](10) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[status] [bit] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[code] [varchar](4) NOT NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCars] ON 

INSERT [dbo].[tblCars] ([carID], [name], [color], [year], [categoryID], [price], [quantity], [createDate]) VALUES (1, N'Fortuner', N'Black', 2020, N'suv', 100, 5, CAST(N'2021-02-27T00:00:00.000' AS DateTime))
INSERT [dbo].[tblCars] ([carID], [name], [color], [year], [categoryID], [price], [quantity], [createDate]) VALUES (6, N'Honda Civic', N'White', 2019, N'sedan', 70, 5, CAST(N'2021-02-28T00:00:00.000' AS DateTime))
INSERT [dbo].[tblCars] ([carID], [name], [color], [year], [categoryID], [price], [quantity], [createDate]) VALUES (7, N'Toyota Innova', N'Gray', 2016, N'suv', 60, 10, CAST(N'2021-03-06T16:38:44.523' AS DateTime))
SET IDENTITY_INSERT [dbo].[tblCars] OFF
GO
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'sedan', N'SEDAN')
INSERT [dbo].[tblCategory] ([categoryID], [name]) VALUES (N'suv', N'SUV')
GO
INSERT [dbo].[tblDiscount] ([discountID], [name], [startDate], [endDate], [value]) VALUES (N'TOTAL20', N'20%       ', CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(N'2021-03-06T00:00:00.000' AS DateTime), 20)
GO
SET IDENTITY_INSERT [dbo].[tblOrderDetails] ON 

INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (1, 6, 1, 70, 1, CAST(N'2021-03-04T00:00:00.000' AS DateTime), CAST(N'2021-03-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (2, 6, 4, 70, 1, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-09T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (5, 1, 1, 100, 5, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (6, 1, 1, 100, 5, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (7, 1, 1, 100, 6, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (8, 1, 15, 100, 6, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (9, 1, 1, 100, 7, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (10, 1, 1, 100, 7, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (11, 1, 1, 100, 8, CAST(N'2021-03-12T00:00:00.000' AS DateTime), CAST(N'2021-03-12T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (12, 1, 5, 100, 8, CAST(N'2021-03-08T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (15, 1, 1, 100, 11, CAST(N'2021-03-06T00:00:00.000' AS DateTime), CAST(N'2021-03-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[tblOrderDetails] ([orderDetailID], [carID], [quantity], [price], [orderID], [startDate], [endDate], [days]) VALUES (16, 1, 3, 100, 11, CAST(N'2021-03-05T00:00:00.000' AS DateTime), CAST(N'2021-03-07T00:00:00.000' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[tblOrderDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[tblOrders] ON 

INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (1, CAST(N'2021-03-04T07:33:31.213' AS DateTime), 1260, N'user@gmail.com', NULL, 1)
INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (5, CAST(N'2021-03-06T00:06:06.110' AS DateTime), 600, N'user@gmail.com', N'total20', 1)
INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (6, CAST(N'2021-03-06T00:41:36.350' AS DateTime), 4800, N'user@gmail.com', NULL, 1)
INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (7, CAST(N'2021-03-06T00:46:18.833' AS DateTime), 600, N'user@gmail.com', NULL, 0)
INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (8, CAST(N'2021-03-06T00:48:42.103' AS DateTime), 1800, N'user@gmail.com', NULL, 0)
INSERT [dbo].[tblOrders] ([orderID], [date], [total], [email], [discountID], [status]) VALUES (11, CAST(N'2021-03-06T21:48:32.270' AS DateTime), 1200, N'user@gmail.com', NULL, 1)
SET IDENTITY_INSERT [dbo].[tblOrders] OFF
GO
INSERT [dbo].[tblUsers] ([email], [name], [password], [phone], [address], [status], [createDate], [code]) VALUES (N'user@gmail.com', N'User', N'1', N'0123456789', N'HCM', 1, CAST(N'2021-02-26T00:00:00.000' AS DateTime), N'1111')
GO
ALTER TABLE [dbo].[tblCars] ADD  CONSTRAINT [DF_tblCars_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[tblOrders] ADD  CONSTRAINT [DF_tblOrders_status]  DEFAULT ((1)) FOR [status]
GO
ALTER TABLE [dbo].[tblCars]  WITH CHECK ADD  CONSTRAINT [FK_tblCars_tblCategory] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tblCategory] ([categoryID])
GO
ALTER TABLE [dbo].[tblCars] CHECK CONSTRAINT [FK_tblCars_tblCategory]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblCars] FOREIGN KEY([carID])
REFERENCES [dbo].[tblCars] ([carID])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblCars]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblOrderDetails] FOREIGN KEY([orderDetailID])
REFERENCES [dbo].[tblOrderDetails] ([orderDetailID])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblOrderDetails]
GO
ALTER TABLE [dbo].[tblFeedbacks]  WITH CHECK ADD  CONSTRAINT [FK_tblFeedbacks_tblUsers] FOREIGN KEY([email])
REFERENCES [dbo].[tblUsers] ([email])
GO
ALTER TABLE [dbo].[tblFeedbacks] CHECK CONSTRAINT [FK_tblFeedbacks_tblUsers]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetails_tblCars] FOREIGN KEY([carID])
REFERENCES [dbo].[tblCars] ([carID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_tblOrderDetails_tblCars]
GO
ALTER TABLE [dbo].[tblOrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetails_tblOrders] FOREIGN KEY([orderID])
REFERENCES [dbo].[tblOrders] ([orderID])
GO
ALTER TABLE [dbo].[tblOrderDetails] CHECK CONSTRAINT [FK_tblOrderDetails_tblOrders]
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD  CONSTRAINT [FK_tblOrders_tblDiscount] FOREIGN KEY([discountID])
REFERENCES [dbo].[tblDiscount] ([discountID])
GO
ALTER TABLE [dbo].[tblOrders] CHECK CONSTRAINT [FK_tblOrders_tblDiscount]
GO
ALTER TABLE [dbo].[tblOrders]  WITH CHECK ADD  CONSTRAINT [FK_tblOrders_tblUsers] FOREIGN KEY([email])
REFERENCES [dbo].[tblUsers] ([email])
GO
ALTER TABLE [dbo].[tblOrders] CHECK CONSTRAINT [FK_tblOrders_tblUsers]
GO
USE [master]
GO
ALTER DATABASE [Assignment3_HuynhGiaBao] SET  READ_WRITE 
GO
