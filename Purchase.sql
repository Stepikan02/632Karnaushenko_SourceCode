USE [master]
GO
/****** Object:  Database [Purchase]    Script Date: 06.06.2021 16:50:30 ******/
CREATE DATABASE [Purchase]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Purchase', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Purchase.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Purchase_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Purchase_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Purchase] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Purchase].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Purchase] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Purchase] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Purchase] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Purchase] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Purchase] SET ARITHABORT OFF 
GO
ALTER DATABASE [Purchase] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Purchase] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Purchase] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Purchase] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Purchase] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Purchase] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Purchase] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Purchase] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Purchase] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Purchase] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Purchase] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Purchase] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Purchase] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Purchase] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Purchase] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Purchase] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Purchase] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Purchase] SET RECOVERY FULL 
GO
ALTER DATABASE [Purchase] SET  MULTI_USER 
GO
ALTER DATABASE [Purchase] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Purchase] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Purchase] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Purchase] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Purchase] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Purchase', N'ON'
GO
ALTER DATABASE [Purchase] SET QUERY_STORE = OFF
GO
USE [Purchase]
GO
/****** Object:  Table [dbo].[Catalog]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Catalog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[ProviderId] [int] NOT NULL,
 CONSTRAINT [PK_Catalog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Successful] [bit] NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CatalogId] [int] NOT NULL,
	[Count] [int] NOT NULL,
	[Cost] [money] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[TypeId] [nchar](2) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductType]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductType](
	[id] [nchar](2) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Provider]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Provider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[CountOfStars] [int] NOT NULL,
 CONSTRAINT [PK_Provider] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 06.06.2021 16:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Login] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Catalog] ON 

INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (1, 3, CAST(100 AS Decimal(18, 0)), 1)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (2, 1, CAST(170 AS Decimal(18, 0)), 2)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (3, 3, CAST(115 AS Decimal(18, 0)), 3)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (4, 2, CAST(140 AS Decimal(18, 0)), 3)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (6, 4, CAST(200 AS Decimal(18, 0)), 1)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (7, 4, CAST(170 AS Decimal(18, 0)), 3)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (9, 5, CAST(500 AS Decimal(18, 0)), 3)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (10, 6, CAST(3000 AS Decimal(18, 0)), 1)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (11, 6, CAST(1000 AS Decimal(18, 0)), 4)
INSERT [dbo].[Catalog] ([Id], [ProductId], [Price], [ProviderId]) VALUES (12, 2, CAST(100 AS Decimal(18, 0)), 3)
SET IDENTITY_INSERT [dbo].[Catalog] OFF
GO
SET IDENTITY_INSERT [dbo].[History] ON 

INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (1, N'admin', CAST(N'2021-05-22T17:45:05.183' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (2, N'irinManager', CAST(N'2021-05-22T17:49:32.780' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (3, N'irinManager', CAST(N'2021-05-22T17:53:45.853' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (4, N'irinManager', CAST(N'2021-05-22T17:57:43.760' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (5, N'irinManager', CAST(N'2021-05-22T17:58:32.830' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (6, N'irinManager', CAST(N'2021-05-22T18:09:21.397' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (7, N'irinManager', CAST(N'2021-05-22T18:11:49.613' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (8, N'irinManager', CAST(N'2021-05-22T18:46:39.073' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (9, N'irinManager', CAST(N'2021-05-22T18:54:18.000' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (10, N'irinManager', CAST(N'2021-05-22T18:54:54.940' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (11, N'irinManager', CAST(N'2021-05-22T18:57:59.703' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (12, N'irinManager', CAST(N'2021-05-22T19:00:11.823' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (13, N'irinManager', CAST(N'2021-05-22T19:05:48.890' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (14, N'irinManager', CAST(N'2021-05-22T19:06:25.087' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (15, N'irinManager', CAST(N'2021-05-22T19:07:35.777' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (16, N'irinManager', CAST(N'2021-05-22T19:08:33.083' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (17, N'irinManager', CAST(N'2021-05-22T19:11:47.167' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (18, N'irinManager', CAST(N'2021-05-22T19:14:06.793' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (19, N'irinManager', CAST(N'2021-05-22T19:14:45.353' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (20, N'irinManager', CAST(N'2021-05-22T19:15:36.073' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (21, N'irinManager', CAST(N'2021-05-22T19:21:05.690' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (22, N'irinManager', CAST(N'2021-05-22T19:26:55.453' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (23, N'irinManager', CAST(N'2021-05-22T19:28:14.993' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (24, N'irinManager', CAST(N'2021-05-22T19:38:03.897' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (25, N'irinManager', CAST(N'2021-05-22T19:49:16.363' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (26, N'irinManager', CAST(N'2021-05-22T19:49:37.017' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (27, N'irinManager', CAST(N'2021-05-22T19:49:59.137' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (28, N'irinManager', CAST(N'2021-05-22T19:55:42.370' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (29, N'irinManager', CAST(N'2021-05-22T19:58:10.017' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (30, N'irinManager', CAST(N'2021-05-22T20:01:17.573' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (31, N'irinManager', CAST(N'2021-05-22T20:02:52.950' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (32, N'irinManager', CAST(N'2021-05-22T20:03:52.020' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (33, N'irinManager', CAST(N'2021-05-22T20:05:28.287' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (34, N'irinManager', CAST(N'2021-05-22T20:06:09.833' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (35, N'irinManager', CAST(N'2021-05-23T10:10:17.850' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (36, N'irinManager', CAST(N'2021-05-23T10:11:05.380' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (37, N'irinManager', CAST(N'2021-05-23T10:11:37.977' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (38, N'irinManager', CAST(N'2021-05-23T10:12:24.133' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (39, N'irinManager', CAST(N'2021-05-23T10:16:28.463' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (40, N'irinManager', CAST(N'2021-05-23T10:17:03.703' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (41, N'irinManager', CAST(N'2021-05-23T10:18:51.110' AS DateTime), 0)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (42, N'irinManager', CAST(N'2021-05-23T10:18:53.633' AS DateTime), 0)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (43, N'irinManager', CAST(N'2021-05-23T10:18:57.587' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (44, N'irinManager', CAST(N'2021-05-23T10:21:39.503' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (45, N'irinManager', CAST(N'2021-05-23T10:33:42.457' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (46, N'irinManager', CAST(N'2021-05-23T10:34:33.377' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (47, N'irinManager', CAST(N'2021-05-23T10:34:54.843' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (48, N'irinManager', CAST(N'2021-05-23T10:36:58.793' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (49, N'irinManager', CAST(N'2021-05-23T15:07:00.857' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (50, N'irinManager', CAST(N'2021-05-23T15:07:41.980' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (51, N'irinManager', CAST(N'2021-05-23T15:16:07.540' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (52, N'irinManager', CAST(N'2021-05-23T15:17:26.467' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (53, N'irinManager', CAST(N'2021-05-23T15:17:52.027' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (54, N'irinManager', CAST(N'2021-05-23T15:18:31.363' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (55, N'irinManager', CAST(N'2021-05-23T15:20:36.970' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (56, N'irinManager', CAST(N'2021-05-23T15:21:55.667' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (57, N'irinManager', CAST(N'2021-05-23T15:40:00.423' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (58, N'irinManager', CAST(N'2021-05-23T15:44:58.693' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (59, N'irinManager', CAST(N'2021-05-23T15:46:23.073' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (60, N'irinManager', CAST(N'2021-05-23T15:47:31.577' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (61, N'irinManager', CAST(N'2021-05-23T15:57:32.830' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (62, N'irinManager', CAST(N'2021-05-23T15:59:01.760' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (63, N'irinManager', CAST(N'2021-05-23T15:59:26.257' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (64, N'admin', CAST(N'2021-05-23T16:00:22.990' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (65, N'irinManager', CAST(N'2021-05-23T16:04:21.400' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (66, N'irinManager', CAST(N'2021-05-23T16:07:33.543' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (67, N'irinManager', CAST(N'2021-05-23T16:10:46.400' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (68, N'irinManager', CAST(N'2021-05-23T16:11:29.907' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (69, N'irinManager', CAST(N'2021-05-23T16:15:32.347' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (70, N'irinManager', CAST(N'2021-05-23T16:16:32.367' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (71, N'irinManager', CAST(N'2021-05-23T16:19:24.613' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (72, N'irinManager', CAST(N'2021-05-23T16:37:14.493' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (73, N'irinManager', CAST(N'2021-05-23T16:42:00.853' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (74, N'irinManager', CAST(N'2021-05-23T16:58:12.243' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (75, N'irinManager', CAST(N'2021-05-23T17:03:26.643' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (76, N'irinManager', CAST(N'2021-05-23T17:04:37.547' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (77, N'irinManager', CAST(N'2021-05-23T17:05:24.667' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (78, N'irinManager', CAST(N'2021-05-23T17:05:58.420' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (79, N'irinManager', CAST(N'2021-05-23T17:07:17.430' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (80, N'irinManager', CAST(N'2021-05-23T17:09:00.827' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (81, N'irinManager', CAST(N'2021-05-23T17:10:22.993' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (82, N'irinManager', CAST(N'2021-05-23T17:22:09.250' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (83, N'irinManager', CAST(N'2021-05-23T17:28:18.047' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (84, N'irinManager', CAST(N'2021-05-23T17:29:44.847' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (85, N'irinManager', CAST(N'2021-05-23T17:30:48.340' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (86, N'irinManager', CAST(N'2021-05-23T17:41:12.553' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (87, N'irinManager', CAST(N'2021-05-23T17:42:43.353' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (88, N'irinManager', CAST(N'2021-05-23T17:47:11.233' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (89, N'irinManager', CAST(N'2021-05-23T17:53:25.787' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (90, N'irinManager', CAST(N'2021-05-23T18:03:49.807' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (91, N'irinManager', CAST(N'2021-05-23T18:06:26.453' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (92, N'irinManager', CAST(N'2021-05-23T18:08:56.063' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (93, N'irinManager', CAST(N'2021-05-23T18:19:16.113' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (94, N'irinManager', CAST(N'2021-05-23T18:27:32.353' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (95, N'irinManager', CAST(N'2021-05-23T18:29:31.973' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (96, N'irinManager', CAST(N'2021-05-23T18:33:02.973' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (97, N'irinManager', CAST(N'2021-05-23T18:34:05.127' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (98, N'irinManager', CAST(N'2021-05-23T18:56:33.253' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (99, N'irinManager', CAST(N'2021-05-23T18:57:43.247' AS DateTime), 1)
GO
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (100, N'irinManager', CAST(N'2021-05-23T19:06:56.817' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (101, N'irinManager', CAST(N'2021-05-23T19:09:38.093' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (102, N'irinManager', CAST(N'2021-05-23T19:12:14.967' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (103, N'irinManager', CAST(N'2021-05-23T19:14:05.143' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (104, N'irinManager', CAST(N'2021-05-23T19:16:32.777' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (105, N'irinManager', CAST(N'2021-05-23T19:17:47.337' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (106, N'irinManager', CAST(N'2021-05-23T19:19:43.900' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (107, N'irinManager', CAST(N'2021-05-23T19:31:32.193' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (108, N'irinManager', CAST(N'2021-05-23T19:35:03.883' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (109, N'irinManager', CAST(N'2021-05-23T19:40:33.920' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (110, N'irinManager', CAST(N'2021-05-23T19:42:31.063' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (111, N'irinManager', CAST(N'2021-05-23T19:45:04.837' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (112, N'irinManager', CAST(N'2021-05-23T19:45:41.423' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (113, N'irinManager', CAST(N'2021-05-23T19:47:59.233' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (114, N'irinManager', CAST(N'2021-05-23T19:48:52.550' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (115, N'irinManager', CAST(N'2021-05-23T20:06:54.163' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (116, N'irinManager', CAST(N'2021-05-23T20:08:55.753' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (117, N'irinManager', CAST(N'2021-05-23T20:10:32.950' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (118, N'irinManager', CAST(N'2021-05-23T20:19:55.783' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (119, N'irinManager', CAST(N'2021-05-23T20:27:27.300' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (120, N'irinManager', CAST(N'2021-05-23T20:48:58.953' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (121, N'irinManager', CAST(N'2021-05-26T21:05:40.303' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (122, N'irinManager', CAST(N'2021-05-26T21:09:24.143' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (123, N'admin', CAST(N'2021-05-26T21:20:58.237' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (124, N'admin', CAST(N'2021-05-26T21:32:50.707' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (125, N'irinManager', CAST(N'2021-05-27T19:03:24.167' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (126, N'irinManager', CAST(N'2021-05-27T19:04:02.597' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (127, N'irinManager', CAST(N'2021-05-27T19:06:12.807' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (128, N'irinManager', CAST(N'2021-05-27T19:07:03.833' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (129, N'irinManager', CAST(N'2021-05-27T19:07:57.630' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (130, N'irinManager', CAST(N'2021-05-27T19:11:37.727' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (131, N'irinManager', CAST(N'2021-05-27T19:12:01.650' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (132, N'irinManager', CAST(N'2021-05-27T19:12:41.180' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (133, N'irinManager', CAST(N'2021-05-27T19:31:51.540' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (134, N'irinManager', CAST(N'2021-05-27T19:33:25.047' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (135, N'irinManager', CAST(N'2021-05-27T19:33:53.823' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (136, N'irinManager', CAST(N'2021-05-27T19:34:59.233' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (137, N'irinManager', CAST(N'2021-05-27T19:37:09.873' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (138, N'irinManager', CAST(N'2021-05-27T19:37:49.377' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (139, N'irinManager', CAST(N'2021-05-27T19:45:42.043' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (140, N'irinManager', CAST(N'2021-05-27T19:47:46.500' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (141, N'irinManager', CAST(N'2021-05-27T19:48:51.723' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (142, N'irinManager', CAST(N'2021-05-27T19:59:45.690' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (143, N'irinManager', CAST(N'2021-05-27T20:02:45.667' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (144, N'irinManager', CAST(N'2021-05-27T20:08:22.990' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (145, N'irinManager', CAST(N'2021-05-27T20:32:55.510' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (146, N'irinManager', CAST(N'2021-05-27T20:33:14.450' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (147, N'irinManager', CAST(N'2021-05-27T20:37:54.997' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (148, N'irinManager', CAST(N'2021-05-27T20:39:55.883' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (149, N'irinManager', CAST(N'2021-05-27T20:42:50.017' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (150, N'irinManager', CAST(N'2021-05-27T20:51:01.260' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (151, N'irinManager', CAST(N'2021-05-27T20:52:55.167' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (152, N'irinManager', CAST(N'2021-05-27T20:54:01.337' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (153, N'irinManager', CAST(N'2021-05-27T20:54:48.027' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (154, N'irinManager', CAST(N'2021-05-27T20:57:36.167' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (155, N'irinManager', CAST(N'2021-05-27T20:58:40.193' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (156, N'irinManager', CAST(N'2021-05-27T21:03:32.193' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (157, N'irinManager', CAST(N'2021-05-27T21:03:49.807' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (158, N'irinManager', CAST(N'2021-05-27T21:05:07.700' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (159, N'irinManager', CAST(N'2021-05-27T21:07:59.030' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (160, N'irinManager', CAST(N'2021-05-27T21:08:40.890' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (161, N'irinManager', CAST(N'2021-05-27T21:10:10.250' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (162, N'irinManager', CAST(N'2021-05-27T21:14:42.020' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (163, N'irinManager', CAST(N'2021-05-27T21:20:31.003' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (164, N'irinManager', CAST(N'2021-05-27T21:28:32.473' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (165, N'irinManager', CAST(N'2021-05-27T21:35:32.347' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (166, N'irinManager', CAST(N'2021-05-27T21:40:43.913' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (167, N'irinManager', CAST(N'2021-05-27T21:59:50.603' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (168, N'irinManager', CAST(N'2021-05-27T22:07:06.683' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (169, N'irinManager', CAST(N'2021-05-27T22:13:50.300' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (170, N'irinManager', CAST(N'2021-05-27T22:15:59.427' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (171, N'irinManager', CAST(N'2021-05-27T22:17:10.547' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (172, N'irinManager', CAST(N'2021-05-28T19:09:58.380' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (173, N'irinManager', CAST(N'2021-05-28T19:11:46.730' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (174, N'irinManager', CAST(N'2021-05-28T19:14:27.437' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (175, N'irinManager', CAST(N'2021-05-28T19:25:24.777' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (176, N'admin', CAST(N'2021-05-30T14:47:08.377' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (177, N'irinManager', CAST(N'2021-05-30T14:48:11.330' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (178, N'irinManager', CAST(N'2021-05-30T14:50:31.857' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (179, N'admin', CAST(N'2021-05-30T14:52:47.907' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (180, N'irinManager', CAST(N'2021-05-30T16:30:10.127' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (181, N'irinManager', CAST(N'2021-05-30T16:51:37.200' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (182, N'irinManager', CAST(N'2021-05-30T17:03:47.693' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (183, N'irinManager', CAST(N'2021-05-30T17:08:34.660' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (184, N'irinManager', CAST(N'2021-05-30T17:28:36.120' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (185, N'irinManager', CAST(N'2021-05-30T17:29:24.063' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (186, N'irinManager', CAST(N'2021-05-30T17:38:13.603' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (187, N'irinManager', CAST(N'2021-05-30T17:44:18.833' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (188, N'irinManager', CAST(N'2021-05-30T17:45:37.577' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (189, N'irinManager', CAST(N'2021-05-30T17:46:39.967' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (190, N'irinManager', CAST(N'2021-05-30T18:04:40.270' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (191, N'irinManager', CAST(N'2021-05-30T18:05:43.040' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (192, N'irinManager', CAST(N'2021-05-30T18:06:36.963' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (193, N'irinManager', CAST(N'2021-05-30T18:07:13.460' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (194, N'irinManager', CAST(N'2021-05-30T18:08:47.777' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (195, N'irinManager', CAST(N'2021-05-30T18:09:19.740' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (196, N'irinManager', CAST(N'2021-05-30T18:47:01.403' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (197, N'irinManager', CAST(N'2021-05-30T18:51:27.500' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (198, N'irinManager', CAST(N'2021-05-30T18:52:48.520' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (199, N'irinManager', CAST(N'2021-05-30T18:53:27.557' AS DateTime), 1)
GO
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (200, N'irinManager', CAST(N'2021-05-30T18:54:01.707' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (201, N'irinManager', CAST(N'2021-05-30T18:55:00.140' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (202, N'irinManager', CAST(N'2021-05-30T18:59:31.427' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (203, N'irinManager', CAST(N'2021-05-30T19:01:48.317' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (204, N'irinManager', CAST(N'2021-05-30T19:03:05.737' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (205, N'irinManager', CAST(N'2021-05-30T19:03:34.597' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (206, N'irinManager', CAST(N'2021-05-30T19:03:56.043' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (207, N'irinManager', CAST(N'2021-05-30T19:45:43.963' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (208, N'irinManager', CAST(N'2021-05-30T19:53:48.533' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (209, N'irinManager', CAST(N'2021-05-30T19:56:10.627' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (210, N'irinManager', CAST(N'2021-05-30T19:56:36.970' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (211, N'irinManager', CAST(N'2021-05-30T19:57:25.790' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (212, N'irinManager', CAST(N'2021-05-30T19:58:40.763' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (213, N'irinManager', CAST(N'2021-05-30T19:59:46.253' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (214, N'irinManager', CAST(N'2021-05-30T20:35:38.253' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (215, N'irinManager', CAST(N'2021-05-30T20:38:39.473' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (216, N'irinManager', CAST(N'2021-05-30T20:39:49.637' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (217, N'irinManager', CAST(N'2021-05-30T20:40:27.433' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (218, N'irinManager', CAST(N'2021-05-30T20:42:20.533' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (219, N'irinManager', CAST(N'2021-05-30T20:43:29.160' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (220, N'irinManager', CAST(N'2021-05-30T20:44:54.127' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (221, N'irinManager', CAST(N'2021-05-30T20:47:18.197' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (222, N'irinManager', CAST(N'2021-05-30T20:49:15.600' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (223, N'irinManager', CAST(N'2021-05-30T20:50:19.820' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (224, N'irinManager', CAST(N'2021-05-30T20:51:08.263' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (225, N'irinManager', CAST(N'2021-05-30T21:01:45.597' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (226, N'irinManager', CAST(N'2021-05-30T21:02:56.267' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (227, N'irinManager', CAST(N'2021-05-30T21:03:18.543' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (228, N'irinManager', CAST(N'2021-05-30T21:04:00.427' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (229, N'irinManager', CAST(N'2021-05-30T21:04:21.887' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (230, N'irinManager', CAST(N'2021-05-30T21:04:41.270' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (231, N'irinManager', CAST(N'2021-05-30T21:06:02.493' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (232, N'irinManager', CAST(N'2021-05-30T21:08:34.793' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (233, N'irinManager', CAST(N'2021-05-30T21:09:19.360' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (234, N'irinManager', CAST(N'2021-05-31T20:04:21.687' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (235, N'irinManager', CAST(N'2021-05-31T22:11:41.947' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (236, N'irinManager', CAST(N'2021-06-01T17:36:55.977' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (237, N'irinManager', CAST(N'2021-06-01T17:37:01.497' AS DateTime), 0)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (238, N'irinManager', CAST(N'2021-06-01T17:37:06.560' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (239, N'irinManager', CAST(N'2021-06-01T19:48:37.670' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (240, N'irinManager', CAST(N'2021-06-01T19:49:24.483' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (241, N'irinManager', CAST(N'2021-06-01T19:56:59.267' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (242, N'irinManager', CAST(N'2021-06-01T19:59:19.023' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (243, N'irinManager', CAST(N'2021-06-01T20:11:06.993' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (244, N'irinManager', CAST(N'2021-06-01T20:21:56.330' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (245, N'admin', CAST(N'2021-06-02T17:21:40.040' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (246, N'irinManager', CAST(N'2021-06-02T17:21:59.027' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (247, N'admin', CAST(N'2021-06-02T17:39:22.300' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (248, N'admin', CAST(N'2021-06-02T17:46:16.820' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (249, N'irinManager', CAST(N'2021-06-02T18:03:26.103' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (250, N'irinManager', CAST(N'2021-06-02T18:04:07.927' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (251, N'irinManager', CAST(N'2021-06-02T18:05:03.833' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (252, N'irinManager', CAST(N'2021-06-02T18:06:33.723' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (253, N'irinManager', CAST(N'2021-06-02T18:07:18.253' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (254, N'irinManager', CAST(N'2021-06-02T18:20:28.563' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (257, N'irinManager', CAST(N'2021-06-02T21:22:51.523' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (258, N'irinManager', CAST(N'2021-06-02T21:24:26.757' AS DateTime), 0)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (259, N'irinManager', CAST(N'2021-06-02T21:25:48.127' AS DateTime), 0)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (260, N'irinManager', CAST(N'2021-06-02T21:25:51.260' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (261, N'admin', CAST(N'2021-06-06T12:18:05.127' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (262, N'irinManager', CAST(N'2021-06-06T12:21:01.227' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (263, N'admin', CAST(N'2021-06-06T13:59:16.560' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (264, N'irinManager', CAST(N'2021-06-06T14:02:05.723' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (265, N'irinManager', CAST(N'2021-06-06T14:05:15.233' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (266, N'irinManager', CAST(N'2021-06-06T14:07:02.650' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (267, N'irinManager', CAST(N'2021-06-06T14:08:44.787' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (268, N'irinManager', CAST(N'2021-06-06T14:10:20.680' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (269, N'irinManager', CAST(N'2021-06-06T14:13:38.550' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (270, N'irinManager', CAST(N'2021-06-06T14:14:05.267' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (271, N'irinManager', CAST(N'2021-06-06T14:14:56.957' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (272, N'irinManager', CAST(N'2021-06-06T14:15:40.393' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (273, N'irinManager', CAST(N'2021-06-06T14:22:06.097' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (274, N'irinManager', CAST(N'2021-06-06T14:23:30.553' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (275, N'irinManager', CAST(N'2021-06-06T14:24:56.020' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (276, N'irinManager', CAST(N'2021-06-06T14:37:35.810' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (277, N'irinManager', CAST(N'2021-06-06T14:45:08.523' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (278, N'irinManager', CAST(N'2021-06-06T15:56:55.913' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (279, N'irinManager', CAST(N'2021-06-06T16:46:47.030' AS DateTime), 1)
INSERT [dbo].[History] ([Id], [Login], [Date], [Successful]) VALUES (280, N'irinManager', CAST(N'2021-06-06T16:47:12.817' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (1, 1, 5, 500.0000, CAST(N'2021-05-22T00:00:00.000' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (3, 2, 10, 1700.0000, CAST(N'2021-05-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (7, 1, 3, 420.0000, CAST(N'2021-05-27T20:40:05.177' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (9, 3, 3, 345.0000, CAST(N'2021-05-27T20:51:07.713' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (10, 2, 3, 510.0000, CAST(N'2021-05-27T21:03:58.303' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (11, 2, 3, 510.0000, CAST(N'2021-05-27T21:05:16.330' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (12, 4, 100, 14000.0000, CAST(N'2021-05-27T21:15:36.397' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (13, 2, 4, 680.0000, CAST(N'2021-05-28T19:15:08.007' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (14, 3, 5, 500.0000, CAST(N'2021-05-30T14:51:22.000' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (15, 7, 4, 680.0000, CAST(N'2021-05-30T18:09:44.807' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (16, 9, 5, 2500.0000, CAST(N'2021-05-30T18:48:12.057' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (17, 11, 3, 3000.0000, CAST(N'2021-05-30T20:52:16.873' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (18, 2, 5, 850.0000, CAST(N'2021-06-02T18:21:02.627' AS DateTime))
INSERT [dbo].[Order] ([Id], [CatalogId], [Count], [Cost], [OrderDate]) VALUES (19, 9, 5, 2500.0000, CAST(N'2021-06-06T14:03:06.593' AS DateTime))
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (1, N'Бананы', N'fr', N'Не очень жирный, но весьма питательный и энергетически ценный продукт')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (2, N'Огурцы', N'vg', N'Самый низкокалорийный и водянистый из овощей, ведь он на 96% состоит из воды')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (3, N'Капуста', N'vg', N'Род растений семейства Капустные')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (4, N'Яблоко', N'fr', N'Фкусный фрукт верь мне я не обману')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (5, N'Авокадо', N'fr', N'Тот ещё фрукт')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (6, N'Клубничка', N'vg', N'Клубничка с грядки Александера который Здорово')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (7, N'Картофель', N'vg', N'приветик')
INSERT [dbo].[Product] ([Id], [Title], [TypeId], [Description]) VALUES (8, N'Слава Мерлоу', N'vg', N'Ты горишь как агония')
SET IDENTITY_INSERT [dbo].[Product] OFF
GO
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (N'fr', N'Фрукт')
INSERT [dbo].[ProductType] ([id], [Type]) VALUES (N'vg', N'Овощ')
GO
SET IDENTITY_INSERT [dbo].[Provider] ON 

INSERT [dbo].[Provider] ([Id], [Name], [Description], [CountOfStars]) VALUES (1, N'BestFruits', N'Самые вкусные фрукты в городе', 5)
INSERT [dbo].[Provider] ([Id], [Name], [Description], [CountOfStars]) VALUES (2, N'VegetablesPlus', N'У нас есть все виды овощей', 4)
INSERT [dbo].[Provider] ([Id], [Name], [Description], [CountOfStars]) VALUES (3, N'Fruitella', N'Оптовые фрукты', 2)
INSERT [dbo].[Provider] ([Id], [Name], [Description], [CountOfStars]) VALUES (4, N'AlexFruit', N'Фрукты из Александрии', 5)
INSERT [dbo].[Provider] ([Id], [Name], [Description], [CountOfStars]) VALUES (5, N'OptovikFr', N'Оптовые товары по самым низким ценам', 2)
SET IDENTITY_INSERT [dbo].[Provider] OFF
GO
INSERT [dbo].[Role] ([Id], [Name]) VALUES (1, N'Администратор')
INSERT [dbo].[Role] ([Id], [Name]) VALUES (2, N'Менеджер')
GO
INSERT [dbo].[User] ([Login], [Password], [Name], [Surname], [RoleId]) VALUES (N'admin', N'admin123', N'Степан', N'Карнаушенко', 1)
INSERT [dbo].[User] ([Login], [Password], [Name], [Surname], [RoleId]) VALUES (N'Antonio123', N'anton', N'Антон', N'Инолин', 2)
INSERT [dbo].[User] ([Login], [Password], [Name], [Surname], [RoleId]) VALUES (N'inokent0', N'098765', N'Инокентий', N'Гаврилов', 2)
INSERT [dbo].[User] ([Login], [Password], [Name], [Surname], [RoleId]) VALUES (N'irinManager', N'123ira', N'Ирина', N'Копылина', 2)
INSERT [dbo].[User] ([Login], [Password], [Name], [Surname], [RoleId]) VALUES (N'manOleg', N'sidoroW', N'Олег ', N'Сидоров', 2)
GO
ALTER TABLE [dbo].[Catalog]  WITH CHECK ADD  CONSTRAINT [FK_Catalog_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_Product]
GO
ALTER TABLE [dbo].[Catalog]  WITH CHECK ADD  CONSTRAINT [FK_Catalog_Provider] FOREIGN KEY([ProviderId])
REFERENCES [dbo].[Provider] ([Id])
GO
ALTER TABLE [dbo].[Catalog] CHECK CONSTRAINT [FK_Catalog_Provider]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_User] FOREIGN KEY([Login])
REFERENCES [dbo].[User] ([Login])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_User]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Catalog] FOREIGN KEY([CatalogId])
REFERENCES [dbo].[Catalog] ([Id])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Catalog]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([TypeId])
REFERENCES [dbo].[ProductType] ([id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductType]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [Purchase] SET  READ_WRITE 
GO
