1. SQL Server Connection Strings (Core Format)

    Primary Database (DB Server A)
    
        Server=10.0.0.10,1433;
        Database=PrimaryDB;
        User ID=appuser;
        Password=StrongPassword123;
        TrustServerCertificate=True;

    Logging Database (DB Server B)

        Server=10.0.0.30,1433;
        Database=LoggingDB;
        User ID=loguser;
        Password=StrongPassword123;
        TrustServerCertificate=True;


2. .NET (appsettings.json)

{
  "ConnectionStrings": {
    "PrimaryDB": "Server=10.0.0.10,1433;Database=PrimaryDB;User ID=appuser;Password=StrongPassword123;TrustServerCertificate=True;",
    "LoggingDB": "Server=10.0.0.30,1433;Database=LoggingDB;User ID=loguser;Password=StrongPassword123;TrustServerCertificate=True;"
  }
}

3. C# (>NET) - Dependecy Injection Example

    builder.Services.AddDbContext<PrimaryDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("PrimaryDB")));

    builder.Services.AddDbContext<LoggingDbContext>(options =>
        options.UseSqlServer(builder.Configuration.GetConnectionString("LoggingDB")));

4. Python (SDLAlchemy)

    PRIMARY_DB = "mssql+pyodbc://appuser:StrongPassword123@10.0.0.10/PrimaryDB?driver=ODBC+Driver+17+for+SQL+Server"
    LOGGING_DB = "mssql+pyodbc://loguser:StrongPassword123@10.0.0.30/LoggingDB?driver=ODBC+Driver+17+for+SQL+Server"

5. Node.js (mssql library)

const primaryDb = {
  user: "appuser",
  password: "StrongPassword123",
  server: "10.0.0.10",
  database: "PrimaryDB",
  options: { trustServerCertificate: true }
};

const loggingDb = {
  user: "loguser",
  password: "StrongPassword123",
  server: "10.0.0.30",
  database: "LoggingDB",
  options: { trustServerCertificate: true }
};

6. Powershell (invoke-sqlcmd)

    Primary DB
        Invoke-Sqlcmd -ServerInstance "10.0.0.10" -Database "PrimaryDB" -Username "appuser" -Password "StrongPassword123"

    Logging DB
        Invoke-Sqlcmd -ServerInstance "10.0.0.30" -Database "LoggingDB" -Username "loguser" -Password "StrongPassword123"

7. Security Recommendations

    Use different SQL users for each database.

    Never reuse passwords across DB A and DB B.

    Restrict inbound SQL traffic to App Server only.

    Enable TCP/IP in SQL Server Configuration Manager.

    Keep TrustServerCertificate=True only in isolated lab environments.