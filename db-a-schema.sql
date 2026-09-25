/* DATABASE: PrimaryDB
   SERVER:   DB Server A (10.0.0.10)
   PURPOSE:  Core business data for the application*/

-- Create database
CREATE DATABASE PrimaryDB;
GO

USE PrimaryDB;
GO

/* TABLE: Users
   Description: Stores application users and authentication data*/
CREATE TABLE Users (
    UserID          INT IDENTITY(1,1) PRIMARY KEY,
    FirstName       NVARCHAR(100) NOT NULL,
    LastName        NVARCHAR(100) NOT NULL,
    Email           NVARCHAR(255) UNIQUE NOT NULL,
    PasswordHash    NVARCHAR(255) NOT NULL,
    CreatedAt       DATETIME2 DEFAULT SYSUTCDATETIME(),
    UpdatedAt       DATETIME2 NULL
);
GO

CREATE INDEX IX_Users_Email ON Users (Email);
GO

/* TABLE: Roles
   Description: Defines user roles for authorization*/
CREATE TABLE Roles (
    RoleID      INT IDENTITY(1,1) PRIMARY KEY,
    RoleName    NVARCHAR(100) UNIQUE NOT NULL
);
GO

/* TABLE: UserRoles
   Description: Many-to-many relationship between Users and Roles*/
CREATE TABLE UserRoles (
    UserID      INT NOT NULL,
    RoleID      INT NOT NULL,
    AssignedAt  DATETIME2 DEFAULT SYSUTCDATETIME(),
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
GO

/* TABLE: Products
   Description: Core business inventory/products*/
CREATE TABLE Products (
    ProductID       INT IDENTITY(1,1) PRIMARY KEY,
    ProductName     NVARCHAR(200) NOT NULL,
    Description     NVARCHAR(MAX) NULL,
    Price           DECIMAL(10,2) NOT NULL,
    QuantityInStock INT NOT NULL DEFAULT 0,
    CreatedAt       DATETIME2 DEFAULT SYSUTCDATETIME(),
    UpdatedAt       DATETIME2 NULL
);
GO

CREATE INDEX IX_Products_Name ON Products (ProductName);
GO

/* TABLE: Orders
   Description: Customer orders*/
CREATE TABLE Orders (
    OrderID         INT IDENTITY(1,1) PRIMARY KEY,
    UserID          INT NOT NULL,
    OrderDate       DATETIME2 DEFAULT SYSUTCDATETIME(),
    TotalAmount     DECIMAL(10,2) NOT NULL,
    Status          NVARCHAR(50) NOT NULL DEFAULT 'Pending',
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE INDEX IX_Orders_UserID ON Orders (UserID);
GO

/* TABLE: OrderItems
   Description: Items within each order*/
CREATE TABLE OrderItems (
    OrderItemID     INT IDENTITY(1,1) PRIMARY KEY,
    OrderID         INT NOT NULL,
    ProductID       INT NOT NULL,
    Quantity        INT NOT NULL,
    UnitPrice       DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

CREATE INDEX IX_OrderItems_OrderID ON OrderItems (OrderID);
GO

/* TABLE: AuditBusinessEvents
   Description: Business-level audit events (NOT logs)
   These are mirrored to DB-B for analytics.*/
CREATE TABLE AuditBusinessEvents (
    EventID         BIGINT IDENTITY(1,1) PRIMARY KEY,
    EventType       NVARCHAR(100) NOT NULL,
    UserID          INT NULL,
    Description     NVARCHAR(MAX) NULL,
    CreatedAt       DATETIME2 DEFAULT SYSUTCDATETIME(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
GO

CREATE INDEX IX_AuditBusinessEvents_Type ON AuditBusinessEvents (EventType);
GO

/*END OF SCHEMA*/
