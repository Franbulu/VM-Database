/*DB Server B — Logging & Analytics Database Schema
   Purpose: Store logs, analytics events, audit trails, and background processing data for the App Server.*/

/* 1. Database Creation */
CREATE DATABASE LoggingDB;
GO

USE LoggingDB;
GO

/*2. Application Logs*/
CREATE TABLE AppLogs (
    LogID           INT IDENTITY(1,1) PRIMARY KEY,
    LogLevel        VARCHAR(20) NOT NULL,          
    Message         NVARCHAR(4000) NOT NULL,
    Source          VARCHAR(100) NULL,             
    CreatedAt       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    RequestID       VARCHAR(100) NULL              
);
GO

/*3. Audit Trail*/
CREATE TABLE AuditTrail (
    AuditID         INT IDENTITY(1,1) PRIMARY KEY,
    UserName        VARCHAR(100) NULL,
    Action          VARCHAR(200) NOT NULL,         
    EntityName      VARCHAR(100) NULL,             
    EntityID        VARCHAR(100) NULL,
    Details         NVARCHAR(2000) NULL,
    CreatedAt       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

/*4. Analytics Events*/
CREATE TABLE AnalyticsEvents (
    EventID         INT IDENTITY(1,1) PRIMARY KEY,
    EventType       VARCHAR(100) NOT NULL,      
    EventValue      VARCHAR(200) NULL,
    UserAgent       VARCHAR(500) NULL,
    IPAddress       VARCHAR(50) NULL,
    CreatedAt       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

/*5. Background Job History*/
CREATE TABLE JobHistory (
    JobID           INT IDENTITY(1,1) PRIMARY KEY,
    JobName         VARCHAR(200) NOT NULL,
    Status          VARCHAR(50) NOT NULL,         
    DurationMs      INT NULL,
    ErrorMessage    NVARCHAR(2000) NULL,
    StartedAt       DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
    FinishedAt      DATETIME2 NULL
);
GO

/*6. System Metrics (Optional)*/
CREATE TABLE SystemMetrics (
    MetricID        INT IDENTITY(1,1) PRIMARY KEY,
    MetricName      VARCHAR(100) NOT NULL,         
    MetricValue     VARCHAR(100) NOT NULL,
    RecordedAt      DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME()
);
GO

/*7. Indexes for Performance*/
CREATE INDEX IX_AppLogs_CreatedAt ON AppLogs (CreatedAt);
CREATE INDEX IX_AuditTrail_CreatedAt ON AuditTrail (CreatedAt);
CREATE INDEX IX_AnalyticsEvents_CreatedAt ON AnalyticsEvents (CreatedAt);
CREATE INDEX IX_JobHistory_StartedAt ON JobHistory (StartedAt);
GO

/*8. Version Tag*/
PRINT 'LoggingDB schema successfully created.';
GO
