USE [master]
GO

CREATE DATABASE [HousingConstruction]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HousingConstruction', FILENAME = N'D:\SQL\Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HousingConstruction.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HousingConstruction_log', FILENAME = N'D:\SQL\Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\HousingConstruction_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HousingConstruction] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HousingConstruction].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HousingConstruction] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HousingConstruction] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HousingConstruction] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HousingConstruction] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HousingConstruction] SET ARITHABORT OFF 
GO
ALTER DATABASE [HousingConstruction] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [HousingConstruction] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HousingConstruction] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HousingConstruction] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HousingConstruction] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HousingConstruction] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HousingConstruction] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HousingConstruction] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HousingConstruction] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HousingConstruction] SET  ENABLE_BROKER 
GO
ALTER DATABASE [HousingConstruction] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HousingConstruction] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HousingConstruction] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HousingConstruction] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HousingConstruction] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HousingConstruction] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HousingConstruction] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HousingConstruction] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HousingConstruction] SET  MULTI_USER 
GO
ALTER DATABASE [HousingConstruction] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HousingConstruction] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HousingConstruction] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HousingConstruction] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HousingConstruction] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HousingConstruction] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [HousingConstruction] SET QUERY_STORE = ON
GO
ALTER DATABASE [HousingConstruction] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HousingConstruction]
GO
--Object:  UserDefinedFunction [dbo].[CalculateAveragePricePerHousingType]   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateAveragePricePerHousingType] (@HousingTypeID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @AveragePrice DECIMAL(10, 2);

    SELECT @AveragePrice = AVG(Price)
    FROM Housing
    WHERE HousingTypeID = @HousingTypeID;

    RETURN @AveragePrice;
END;
GO
--Object:  UserDefinedFunction [dbo].[CalculateTotalAreaByHousingType]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CalculateTotalAreaByHousingType] (@HousingTypeID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @TotalArea DECIMAL(10, 2);

    SELECT @TotalArea = SUM(Area)
    FROM Housing
    WHERE HousingTypeID = @HousingTypeID;

    RETURN @TotalArea;
END;
GO
 --Object:  UserDefinedFunction [dbo].[CountCompletedConstructionsByDeveloper]   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CountCompletedConstructionsByDeveloper] (@DeveloperID INT)
RETURNS INT
AS
BEGIN
    DECLARE @CompletedConstructionsCount INT;

    SELECT @CompletedConstructionsCount = COUNT(*)
    FROM Construction
    WHERE DeveloperID = @DeveloperID AND EndDate IS NOT NULL;

    RETURN @CompletedConstructionsCount;
END;
GO
Object:  UserDefinedFunction [dbo].[CountWorkersOnConstruction]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[CountWorkersOnConstruction] (@ConstructionID INT)
RETURNS INT
AS
BEGIN
    DECLARE @WorkerCount INT;

    SELECT @WorkerCount = COUNT(*)
    FROM Shift
    WHERE ConstructionID = @ConstructionID;

    RETURN @WorkerCount;
END;
GO
Object:  Table [dbo].[Construction]   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Construction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndDate] [date] NOT NULL,
	[DeveloperID] [int] NOT NULL,
	[HousingID] [int] NOT NULL,
 CONSTRAINT [PK__Construc__3214EC27762D670F] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
 Object:  Table [dbo].[Developer]   
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Developer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
	[Phone] [varchar](20) NOT NULL,
 CONSTRAINT [PK__Develope__3214EC27BBF85441] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
 Object:  View [dbo].[DeveloperStatistics] 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание представления со статистикой по застройщикам
CREATE VIEW [dbo].[DeveloperStatistics]
AS
SELECT
    d.ID as DeveloperID,
    d.Name AS DeveloperName,
    COUNT(c.ID) AS TotalBuildings,
    SUM(DATEDIFF(day, c.StartDate, c.EndDate)) AS TotalConstructionDurationDays,
    AVG(DATEDIFF(day, c.StartDate, c.EndDate)) AS AverageConstructionDurationDays
FROM
    Developer d
JOIN
    Construction c ON d.ID = c.DeveloperID
GROUP BY
    d.ID, d.Name;
GO
 Object:  Table [dbo].[Housing]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Housing](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Area] [float] NOT NULL,
	[RoomCount] [int] NULL,
	[Address] [varchar](255) NOT NULL,
	[Price] [money] NOT NULL,
	[HousingTypeID] [int] NOT NULL,
	[StatusID] [int] NOT NULL,
 CONSTRAINT [PK__Housing__3214EC2745C1E1A9] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
 Object:  UserDefinedFunction [dbo].[FindMostExpensiveHousing]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FindMostExpensiveHousing] ()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 *
    FROM Housing
    ORDER BY Price DESC
);
GO
 Object:  Table [dbo].[Worker]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Worker](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [varchar](255) NOT NULL,
	[PositionID] [int] NOT NULL,
	[PaymentPerShift] [money] NOT NULL,
 CONSTRAINT [PK__Worker__3214EC2747E13FFA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
 Object:  Table [dbo].[HousingType]    
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HousingType](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](255) NOT NULL,
 CONSTRAINT [PK__HousingT__3214EC27D58B14CD] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shift]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shift](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[WorkerID] [int] NOT NULL,
	[ConstructionID] [int] NOT NULL,
	[ShiftDate] [date] NOT NULL,
 CONSTRAINT [PK__Shift__3214EC27E4C74387] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](255) NOT NULL,
 CONSTRAINT [PK__Status__3214EC270CCE5D20] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ShiftSummary]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ShiftSummary] AS
SELECT
    S.ID as ShiftID,
    S.WorkerID as WorkerID,
    W.FullName,
	H.ID as HousingID,
	H.Address,
    HType.TypeName,
    HStatus.StatusName,
    S.ShiftDate
FROM
    Shift S
JOIN
    Worker W ON S.WorkerID = W.ID
JOIN
    Construction C ON S.ConstructionID = C.ID
JOIN
    Housing H ON S.ConstructionID = H.ID
JOIN
    HousingType HType ON H.HousingTypeID = HType.ID
JOIN
    Status HStatus ON H.StatusID = HStatus.ID;
GO
/****** Object:  View [dbo].[WorkerStatictics]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание представления для подсчета отработанных смен и оплаты для каждого сотрудника
CREATE VIEW [dbo].[WorkerStatictics]
AS
SELECT
    w.ID,
    w.FullName AS WorkerFullName,
    COUNT(s.ID) AS TotalShiftsWorked,
    SUM(w.PaymentPerShift) AS TotalPayment
FROM
    Worker w
JOIN
    Shift s ON w.ID = s.WorkerID
GROUP BY
    w.ID, w.FullName;
GO
/****** Object:  View [dbo].[SoldHousingInfo]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание представления для вывода сведений о жилье со статусом "Завершено"
CREATE VIEW [dbo].[SoldHousingInfo]
AS
SELECT
    h.ID as HousingID,
    hType.TypeName AS HousingType,
    h.Address AS HousingAddress,
    s.StatusName AS HousingStatus,
    c.StartDate AS ConstructionStartDate,
    c.EndDate AS ConstructionEndDate,
    d.ID as DeveloperID,
    d.Name AS DeveloperName
FROM
    Housing h
JOIN
    Construction c ON h.ID = c.HousingID
JOIN
    Developer d ON c.DeveloperID = d.ID
JOIN 
	HousingType hType ON h.HousingTypeID = hType.ID
JOIN 
	Status s ON h.StatusID = s.ID
WHERE
    h.StatusID = 3;
GO
/****** Object:  View [dbo].[CompletedHousingInfo]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание представления для вывода сведений о жилье со статусом "Завершено"
CREATE VIEW [dbo].[CompletedHousingInfo]
AS
SELECT
    h.ID as HousingID,
    hType.TypeName AS HousingType,
    h.Address AS HousingAddress,
    s.StatusName AS HousingStatus,
    c.StartDate AS ConstructionStartDate,
    c.EndDate AS ConstructionEndDate,
    d.ID as DeveloperID,
    d.Name AS DeveloperName
FROM
    Housing h
JOIN
    Construction c ON h.ID = c.HousingID
JOIN
    Developer d ON c.DeveloperID = d.ID
JOIN 
	HousingType hType ON h.HousingTypeID = hType.ID
JOIN 
	Status s ON h.StatusID = s.ID
WHERE
    h.StatusID = 2;
GO
/****** Object:  View [dbo].[InProgressHousingInfo]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание представления для вывода сведений о жилье со статусом "Завершено"
CREATE VIEW [dbo].[InProgressHousingInfo]
AS
SELECT
    h.ID as HousingID,
    hType.TypeName AS HousingType,
    h.Address AS HousingAddress,
    s.StatusName AS HousingStatus,
    c.StartDate AS ConstructionStartDate,
    c.EndDate AS ConstructionEndDate,
    d.ID as DeveloperID,
    d.Name AS DeveloperName
FROM
    Housing h
JOIN
    Construction c ON h.ID = c.HousingID
JOIN
    Developer d ON c.DeveloperID = d.ID
JOIN 
	HousingType hType ON h.HousingTypeID = hType.ID
JOIN 
	Status s ON h.StatusID = s.ID
WHERE
    h.StatusID = 1;
GO
/****** Object:  Table [dbo].[Position]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PositionName] [varchar](255) NOT NULL,
 CONSTRAINT [PK__Position__3214EC27D78AB34C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Construction] ON 

INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (2, CAST(N'2024-05-03' AS Date), CAST(N'2024-08-05' AS Date), 1, 2)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (3, CAST(N'2024-01-10' AS Date), CAST(N'2024-06-06' AS Date), 1, 3)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (4, CAST(N'2024-02-21' AS Date), CAST(N'2024-09-15' AS Date), 3, 4)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (5, CAST(N'2024-03-14' AS Date), CAST(N'2024-04-20' AS Date), 5, 5)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (6, CAST(N'2024-04-22' AS Date), CAST(N'2024-06-25' AS Date), 5, 6)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (7, CAST(N'2024-04-25' AS Date), CAST(N'2024-05-27' AS Date), 7, 7)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (8, CAST(N'2024-08-05' AS Date), CAST(N'2024-09-01' AS Date), 7, 8)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (9, CAST(N'2024-06-05' AS Date), CAST(N'2024-07-10' AS Date), 9, 9)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (10, CAST(N'2024-06-10' AS Date), CAST(N'2024-07-02' AS Date), 10, 10)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (11, CAST(N'2024-04-01' AS Date), CAST(N'2024-06-10' AS Date), 1, 11)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (12, CAST(N'2024-05-01' AS Date), CAST(N'2024-06-15' AS Date), 2, 12)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (13, CAST(N'2024-07-01' AS Date), CAST(N'2024-09-01' AS Date), 3, 13)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (14, CAST(N'2024-06-20' AS Date), CAST(N'2024-08-30' AS Date), 4, 14)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (15, CAST(N'2024-08-01' AS Date), CAST(N'2024-09-15' AS Date), 5, 15)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (16, CAST(N'2024-09-10' AS Date), CAST(N'2024-12-10' AS Date), 6, 16)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (17, CAST(N'2024-10-01' AS Date), CAST(N'2024-11-01' AS Date), 7, 17)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (18, CAST(N'2024-11-05' AS Date), CAST(N'2025-01-15' AS Date), 8, 18)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (19, CAST(N'2024-12-01' AS Date), CAST(N'2025-03-01' AS Date), 9, 19)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (20, CAST(N'2025-01-15' AS Date), CAST(N'2025-02-15' AS Date), 10, 20)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (21, CAST(N'2025-02-10' AS Date), CAST(N'2025-03-30' AS Date), 1, 21)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (22, CAST(N'2025-03-01' AS Date), CAST(N'2025-06-01' AS Date), 2, 22)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (23, CAST(N'2025-03-15' AS Date), CAST(N'2025-04-20' AS Date), 3, 23)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (24, CAST(N'2025-04-25' AS Date), CAST(N'2025-07-01' AS Date), 4, 24)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (25, CAST(N'2025-05-10' AS Date), CAST(N'2025-06-15' AS Date), 5, 25)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (26, CAST(N'2025-06-01' AS Date), CAST(N'2025-08-01' AS Date), 6, 26)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (27, CAST(N'2025-07-01' AS Date), CAST(N'2025-09-30' AS Date), 7, 27)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (28, CAST(N'2025-08-01' AS Date), CAST(N'2025-10-15' AS Date), 8, 28)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (29, CAST(N'2025-09-10' AS Date), CAST(N'2025-11-01' AS Date), 9, 29)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (30, CAST(N'2025-10-01' AS Date), CAST(N'2025-12-01' AS Date), 10, 30)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (31, CAST(N'2025-10-15' AS Date), CAST(N'2025-11-15' AS Date), 1, 31)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (32, CAST(N'2025-11-01' AS Date), CAST(N'2026-01-01' AS Date), 2, 32)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (33, CAST(N'2025-12-10' AS Date), CAST(N'2026-02-10' AS Date), 3, 33)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (34, CAST(N'2026-01-01' AS Date), CAST(N'2026-03-01' AS Date), 4, 34)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (35, CAST(N'2026-02-15' AS Date), CAST(N'2026-04-15' AS Date), 5, 35)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (36, CAST(N'2026-03-01' AS Date), CAST(N'2026-05-01' AS Date), 6, 36)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (37, CAST(N'2026-04-10' AS Date), CAST(N'2026-06-10' AS Date), 7, 37)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (38, CAST(N'2026-05-01' AS Date), CAST(N'2026-07-15' AS Date), 8, 38)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (39, CAST(N'2026-06-10' AS Date), CAST(N'2026-08-20' AS Date), 9, 39)
INSERT [dbo].[Construction] ([ID], [StartDate], [EndDate], [DeveloperID], [HousingID]) VALUES (40, CAST(N'2026-07-01' AS Date), CAST(N'2026-09-01' AS Date), 10, 40)
SET IDENTITY_INSERT [dbo].[Construction] OFF
GO
SET IDENTITY_INSERT [dbo].[Developer] ON 

INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (1, N'Builder Inc.', N'8-900-123-45-67')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (2, N'Construction Co.', N'8-911-234-56-78')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (3, N'Housing Developers', N'8-922-345-67-89')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (4, N'Builder Group', N'8-933-456-78-90')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (5, N'Home Builders', N'8-944-567-89-01')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (6, N'Property Development', N'8-955-678-90-12')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (7, N'House Construction', N'8-966-789-01-23')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (8, N'Real Estate Builders', N'8-977-890-12-34')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (9, N'Urban Developers', N'8-988-901-23-45')
INSERT [dbo].[Developer] ([ID], [Name], [Phone]) VALUES (10, N'Housing Corporation', N'8-999-012-34-56')
SET IDENTITY_INSERT [dbo].[Developer] OFF
GO
SET IDENTITY_INSERT [dbo].[Housing] ON 

INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (2, 80.5, 3, N'ул. Ленина, д. 10, кв. 5', 1500000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (3, 120, 4, N'ул. Пушкина, д. 25', 2500000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (4, 90, 2, N'пр. Октября, д. 15, кв. 12', 2100000.0000, 1, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (5, 150, 5, N'ул. Гагарина, д. 5', 3000000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (6, 100, 3, N'ул. Кирова, д. 8, кв. 6', 2000000.0000, 1, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (7, 70, 2, N'пр. Ленинградский, д. 20, кв. 9', 1600000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (8, 85, 3, N'ул. Московская, д. 30, кв. 7', 1700000.0000, 1, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (9, 130, 4, N'пр. Горького, д. 12', 2700000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (10, 110, 3, N'ул. Парковая, д. 40, кв. 4', 2100000.0000, 3, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (11, 95, 2, N'пр. Ленина, д. 50, кв. 11', 1900000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (12, 75, 2, N'ул. Кутузова, д. 18', 1400000.0000, 1, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (13, 160, 6, N'ул. Мира, д. 7', 3200000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (14, 50, 1, N'ул. Гагарина, д. 14', 1000000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (15, 95, 3, N'ул. Крылатская, д. 9', 2100000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (16, 120, 4, N'пр. Лермонтова, д. 22', 2600000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (17, 85, 3, N'ул. Кольцевая, д. 5', 1800000.0000, 1, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (18, 100, 2, N'ул. Зелёная, д. 8', 2000000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (19, 150, 5, N'пр. Советский, д. 30', 3100000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (20, 130, 4, N'ул. Набережная, д. 11', 2900000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (21, 90, 3, N'ул. Солнечная, д. 3', 2100000.0000, 1, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (22, 75, 2, N'ул. Фрунзе, д. 20', 1600000.0000, 3, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (23, 110, 4, N'пр. Мира, д. 5', 2400000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (24, 140, 5, N'ул. Чкалова, д. 18', 3200000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (25, 55, 2, N'ул. Лесная, д. 12', 1300000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (26, 95, 3, N'ул. Классическая, д. 17', 2100000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (27, 125, 4, N'ул. Белинского, д. 21', 2800000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (28, 110, 3, N'пр. Крупская, д. 5', 2400000.0000, 3, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (29, 80, 3, N'ул. Пирогова, д. 9', 1700000.0000, 1, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (30, 130, 4, N'ул. Садовая, д. 14', 2900000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (31, 60, 2, N'ул. Тихая, д. 22', 1400000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (32, 100, 3, N'пр. Пионерская, д. 3', 2100000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (33, 85, 3, N'ул. Мартынова, д. 7', 1800000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (34, 120, 4, N'ул. Ковальская, д. 8', 2600000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (35, 75, 2, N'пр. Центральная, д. 4', 1500000.0000, 3, 3)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (36, 145, 5, N'ул. Нагорная, д. 19', 3300000.0000, 2, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (37, 95, 3, N'ул. Шевченко, д. 15', 2000000.0000, 1, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (38, 130, 4, N'ул. Сибирская, д. 20', 2800000.0000, 2, 1)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (39, 85, 3, N'пр. Юбилейный, д. 1', 1800000.0000, 1, 2)
INSERT [dbo].[Housing] ([ID], [Area], [RoomCount], [Address], [Price], [HousingTypeID], [StatusID]) VALUES (40, 120, 4, N'ул. Восход, д. 2', 2500000.0000, 2, 2)
SET IDENTITY_INSERT [dbo].[Housing] OFF
GO
SET IDENTITY_INSERT [dbo].[HousingType] ON 

INSERT [dbo].[HousingType] ([ID], [TypeName]) VALUES (1, N'Квартира')
INSERT [dbo].[HousingType] ([ID], [TypeName]) VALUES (2, N'Частный Дом')
INSERT [dbo].[HousingType] ([ID], [TypeName]) VALUES (3, N'Апартаменты')
SET IDENTITY_INSERT [dbo].[HousingType] OFF
GO
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (1, N'Строитель')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (2, N'Архитектор')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (3, N'Мастер')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (4, N'Электрик')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (5, N'Сантехник')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (6, N'Плотник')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (7, N'Живописец')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (8, N'Каменщик')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (9, N'Инженер')
INSERT [dbo].[Position] ([ID], [PositionName]) VALUES (10, N'Руководитель проекта')
SET IDENTITY_INSERT [dbo].[Position] OFF
GO
SET IDENTITY_INSERT [dbo].[Shift] ON 

INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (1, 1, 2, CAST(N'2024-05-09' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (2, 2, 2, CAST(N'2024-05-09' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (3, 4, 2, CAST(N'2024-05-09' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (4, 9, 2, CAST(N'2024-05-09' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (5, 10, 2, CAST(N'2024-05-09' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (6, 1, 2, CAST(N'2024-05-10' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (7, 1, 2, CAST(N'2024-05-11' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (8, 4, 2, CAST(N'2024-05-12' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (9, 1, 2, CAST(N'2024-05-12' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (10, 1, 5, CAST(N'2024-03-19' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (11, 2, 5, CAST(N'2024-03-19' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (12, 4, 5, CAST(N'2024-03-19' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (13, 10, 5, CAST(N'2024-03-19' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (14, 1, 5, CAST(N'2024-03-23' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (15, 1, 5, CAST(N'2024-03-24' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (16, 1, 5, CAST(N'2024-03-25' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (17, 1, 5, CAST(N'2024-04-03' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (18, 4, 5, CAST(N'2024-04-03' AS Date))
INSERT [dbo].[Shift] ([ID], [WorkerID], [ConstructionID], [ShiftDate]) VALUES (19, 5, 5, CAST(N'2024-04-03' AS Date))
SET IDENTITY_INSERT [dbo].[Shift] OFF
GO
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (1, N'В процессе строительства')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (2, N'Завершено')
INSERT [dbo].[Status] ([ID], [StatusName]) VALUES (3, N'Продано')
SET IDENTITY_INSERT [dbo].[Status] OFF
GO
SET IDENTITY_INSERT [dbo].[Worker] ON 

INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (1, N'Иванов Алексей Игоревич', 1, 1500.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (2, N'Петров Сергей Павлович', 2, 1800.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (3, N'Сидоров Андрей Михайлович', 3, 2000.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (4, N'Николаев Дмитрий Владимирович', 4, 1700.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (5, N'Александров Константин Александрович', 5, 1600.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (6, N'Дмитриев Егор Николаевич', 6, 1900.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (7, N'Андреев Владимир Сергеевич', 7, 1750.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (8, N'Сергеев Виктор Иванович', 8, 2100.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (9, N'Антонов Максим Петрович', 9, 2200.0000)
INSERT [dbo].[Worker] ([ID], [FullName], [PositionID], [PaymentPerShift]) VALUES (10, N'Григорьев Роман Дмитриевич', 10, 1950.0000)
SET IDENTITY_INSERT [dbo].[Worker] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UNQ_Phone_Developer]    Script Date: 13.05.2024 18:54:16 ******/
ALTER TABLE [dbo].[Developer] ADD  CONSTRAINT [UNQ_Phone_Developer] UNIQUE NONCLUSTERED 
(
	[Phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Construction]  WITH CHECK ADD  CONSTRAINT [FK_Construction_Housing] FOREIGN KEY([HousingID])
REFERENCES [dbo].[Housing] ([ID])
GO
ALTER TABLE [dbo].[Construction] CHECK CONSTRAINT [FK_Construction_Housing]
GO
ALTER TABLE [dbo].[Construction]  WITH CHECK ADD  CONSTRAINT [FK_Developer_Construction] FOREIGN KEY([DeveloperID])
REFERENCES [dbo].[Developer] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Construction] CHECK CONSTRAINT [FK_Developer_Construction]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [FK_HousingType_Housing] FOREIGN KEY([HousingTypeID])
REFERENCES [dbo].[HousingType] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [FK_HousingType_Housing]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [FK_Status_Housing] FOREIGN KEY([StatusID])
REFERENCES [dbo].[Status] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [FK_Status_Housing]
GO
ALTER TABLE [dbo].[Shift]  WITH CHECK ADD  CONSTRAINT [FK_Construction_Shift] FOREIGN KEY([ConstructionID])
REFERENCES [dbo].[Construction] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Shift] CHECK CONSTRAINT [FK_Construction_Shift]
GO
ALTER TABLE [dbo].[Shift]  WITH CHECK ADD  CONSTRAINT [FK_Worker_Shift] FOREIGN KEY([WorkerID])
REFERENCES [dbo].[Worker] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Shift] CHECK CONSTRAINT [FK_Worker_Shift]
GO
ALTER TABLE [dbo].[Worker]  WITH CHECK ADD  CONSTRAINT [FK_Position_Worker] FOREIGN KEY([PositionID])
REFERENCES [dbo].[Position] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Worker] CHECK CONSTRAINT [FK_Position_Worker]
GO
ALTER TABLE [dbo].[Construction]  WITH CHECK ADD  CONSTRAINT [CHK_Construction_StartEndDate] CHECK  ((datediff(day,[StartDate],[EndDate])>=(0)))
GO
ALTER TABLE [dbo].[Construction] CHECK CONSTRAINT [CHK_Construction_StartEndDate]
GO
ALTER TABLE [dbo].[Developer]  WITH CHECK ADD  CONSTRAINT [CHK_PhoneFormat_Developer] CHECK  (([Phone] like '8-9[0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]' OR [Phone] like '[0-9][0-9]-[0-9][0-9]-[0-9][0-9]'))
GO
ALTER TABLE [dbo].[Developer] CHECK CONSTRAINT [CHK_PhoneFormat_Developer]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [CHK_Housing_Area] CHECK  (([Area]>(0)))
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [CHK_Housing_Area]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [CHK_Housing_Price] CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [CHK_Housing_Price]
GO
ALTER TABLE [dbo].[Housing]  WITH CHECK ADD  CONSTRAINT [CHK_Housing_RoomCount] CHECK  (([RoomCount]>(0)))
GO
ALTER TABLE [dbo].[Housing] CHECK CONSTRAINT [CHK_Housing_RoomCount]
GO
ALTER TABLE [dbo].[Worker]  WITH CHECK ADD  CONSTRAINT [CHK_Worker_PaymentPerShift] CHECK  (([PaymentPerShift]>=(0)))
GO
ALTER TABLE [dbo].[Worker] CHECK CONSTRAINT [CHK_Worker_PaymentPerShift]
GO
/****** Object:  StoredProcedure [dbo].[AddConstruction]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddConstruction]
    @HousingID INT,
    @StartDate DATE,
    @EndDate DATE,
    @DeveloperID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Construction (HousingID, StartDate, EndDate, DeveloperID)
        VALUES (@HousingID, @StartDate, @EndDate, @DeveloperID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[AddDeveloper]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDeveloper]
    @Name NVARCHAR(100),
    @Phone NVARCHAR(20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Developer (Name, Phone)
        VALUES (@Name, @Phone);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[AddHousing]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddHousing]
    @Area DECIMAL(10, 2),
    @RoomCount INT,
    @Address NVARCHAR(255),
    @Price DECIMAL(10, 2),
    @DeveloperID INT,
    @HousingTypeID INT,
    @StatusID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Housing (Area, RoomCount, Address, Price, DeveloperID, HousingTypeID, StatusID)
        VALUES (@Area, @RoomCount, @Address, @Price, @DeveloperID, @HousingTypeID, @StatusID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[AddShift]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddShift]
    @WorkerID INT,
    @ConstructionID INT,
    @ShiftDate DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Shift (WorkerID, ConstructionID, ShiftDate)
        VALUES (@WorkerID, @ConstructionID, @ShiftDate);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[AddWorker]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddWorker]
    @FullName NVARCHAR(100),
    @PositionID INT,
    @PaymentPerShift DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Worker (FullName, PositionID, PaymentPerShift)
        VALUES (@FullName, @PositionID, @PaymentPerShift);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteConstruction]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteConstruction]
    @ConstructionID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM Construction
        WHERE ID = @ConstructionID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteDeveloper]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDeveloper]
    @DeveloperID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM Developer
        WHERE ID = @DeveloperID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteHousing]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteHousing]
    @HousingID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM Housing
        WHERE ID = @HousingID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteShift]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteShift]
    @ShiftID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM Shift
        WHERE ID = @ShiftID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteWorker]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteWorker]
    @WorkerID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        DELETE FROM Worker
        WHERE ID = @WorkerID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateConstruction]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateConstruction]
    @ConstructionID INT,
    @HousingID INT,
    @StartDate DATE,
    @EndDate DATE,
    @DeveloperID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Construction
        SET HousingID = @HousingID,
            StartDate = @StartDate,
            EndDate = @EndDate,
            DeveloperID = @DeveloperID
        WHERE ID = @ConstructionID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateDeveloper]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateDeveloper]
    @DeveloperID INT,
    @Name NVARCHAR(100),
    @Phone NVARCHAR(20)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Developer
        SET Name = @Name,
            Phone = @Phone
        WHERE ID = @DeveloperID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateHousing]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateHousing]
    @HousingID INT,
    @Area DECIMAL(10, 2),
    @RoomCount INT,
    @Address NVARCHAR(100),
    @Price DECIMAL(10, 2),
    @DeveloperID INT,
    @HousingTypeID INT,
    @StatusID INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Housing
        SET Area = @Area,
            RoomCount = @RoomCount,
            Address = @Address,
            Price = @Price,
            DeveloperID = @DeveloperID,
            HousingTypeID = @HousingTypeID,
            StatusID = @StatusID
        WHERE ID = @HousingID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateShift]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateShift]
    @ShiftID INT,
    @WorkerID INT,
    @ConstructionID INT,
    @ShiftDate DATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Shift
        SET WorkerID = @WorkerID,
            ConstructionID = @ConstructionID,
            ShiftDate = @ShiftDate
        WHERE ID = @ShiftID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateWorker]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateWorker]
    @WorkerID INT,
    @FullName NVARCHAR(100),
    @PositionID INT,
    @PaymentPerShift DECIMAL(10, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        UPDATE Worker
        SET FullName = @FullName,
            PositionID = @PositionID,
            PaymentPerShift = @PaymentPerShift
        WHERE ID = @WorkerID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END;
GO
/****** Object:  Trigger [dbo].[CheckShiftCountPerDay]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание триггера
CREATE TRIGGER [dbo].[CheckShiftCountPerDay]
ON [dbo].[Shift]
FOR INSERT, UPDATE
AS
BEGIN
     Проверка для каждой добавляемой или обновляемой строки
    IF EXISTS (
        SELECT WorkerID, ShiftDate
        FROM Shift
        GROUP BY WorkerID, ShiftDate
        HAVING COUNT(*) > 1
    )
    BEGIN
        RAISERROR ('Работник вышел на смену более одного раза за день', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
ALTER TABLE [dbo].[Shift] ENABLE TRIGGER [CheckShiftCountPerDay]
GO
/****** Object:  Trigger [dbo].[CheckShiftDate]    Script Date: 13.05.2024 18:54:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 --Создание триггера
CREATE TRIGGER [dbo].[CheckShiftDate]
ON [dbo].[Shift]
FOR INSERT, UPDATE
AS
BEGIN
     --Переменные для хранения дат начала и конца стройки
    DECLARE @ErrorMessage NVARCHAR(MAX);

     --Проверка каждой добавляемой или обновляемой строки
    SELECT @ErrorMessage = (
        SELECT CONCAT(
            'Дата смены не попадает в интервал стройки. Дата начала стройки: ', CONVERT(NVARCHAR(10), c.StartDate), ', Дата окончания стройки: ', CONVERT(NVARCHAR(10), c.EndDate), CHAR(13)
        )
        FROM inserted AS i
        JOIN Construction AS c ON i.ConstructionID = c.ID
        WHERE i.ShiftDate < c.StartDate OR i.ShiftDate > c.EndDate
        FOR XML PATH('')
    );

     --Проверка наличия ошибок
    IF @ErrorMessage IS NOT NULL
    BEGIN
         --Формирование и вывод сообщения об ошибке
        RAISERROR (@ErrorMessage, 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO
ALTER TABLE [dbo].[Shift] ENABLE TRIGGER [CheckShiftDate]
GO
USE [master]
GO
ALTER DATABASE [HousingConstruction] SET  READ_WRITE 
GO
