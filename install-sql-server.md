1. Prerequisites

Supported Versions:

    SQL Server 2022 is fully supported on Windows Server 2022. 

Minimum Requirements

    4 GB RAM (16 GB recommended)

    1.4 GHz 64‑bit processor

    SSD/NVMe recommended for data/log files

    .NET Framework 4.8 installed (Windows Server 2022 includes this) 

Important Notes
    
    SQL Server installation fails if Windows has pending restarts. Restart before installing. 

    Do not launch setup via RDP using local ISO redirection; use a local ISO or network share. 


2. Download SQL Server 2022

SQL Server Express (free)

Download from Microsoft:

    SQL Server Express 2022 installer (SQL2022‑SSEI‑Expr) 

SQL Server Developer (free, full features)
    
    Download from Microsoft SQL Server downloads page. 


3. Launch SQL Server Installation Center

Mount the ISO → run setup.exe.
    This opens the SQL Server Installation Center. 

Select: Installation → New SQL Server stand‑alone installation


4. Installation Steps

    Step 1 — Edition Selection
        Choose one of the following:

            Evaluation

            Developer

            Express

            Product key (if licensed)

    Step 2 — Accept License Terms
        Check the box to accept license terms and privacy statement. 

    Step 3 — Product Updates
        Installer checks for updates.
        Click Next. 

    Step 4 — Install Setup Files
        Installer loads required setup components.
        Click Next. 

    Step 5 — Install Rules
        SQL Server checks system prerequisites.
        Resolve any failures.
        Click Next. 

    Step 6 — Azure Extension (Optional)
        Uncheck Azure Extension for SQL Server for standalone installations. 

    Step 7 — Feature Selection
        Select Database Engine Services.
        This is the only required feature for DB Server A and DB Server B. 

    Step 8 — Instance Configuration
        Choose:

            Default instance: MSSQLSERVER

            Named instance (optional): e.g., SQL2022LOGS for DB Server B

    Step 9 — Server Configuration
        Assign service accounts (optional for labs).
        For production, Microsoft recommends dedicated service accounts. 

    Step 10 — Database Engine Configuration
        Choose:

            Authentication Mode
                Mixed Mode (recommended for labs)

                Set strong SA password

            Add SQL Administrators
                Add:

                    Local Administrator

                    Any additional admin accounts

            Data Directories
                For best practice:

                    MDF/LDF files on separate drives (NVMe recommended)

                    Click Next → Install.


5. Post‑Installation Tasks

    Install SQL Server Management Studio (SSMS)

        Download from Microsoft Learn.
        SSMS is not included in SQL Server setup. 

    Enable TCP/IP
        
        Open SQL Server Configuration Manager →

            SQL Server Network Configuration → Protocols for MSSQLSERVER → Enable TCP/IP

    Set SQL Port

        Default port: 1433

    Restart SQL Service

        Restart:

            SQL Server (MSSQLSERVER)
            SQL Server Agent (if Developer edition)


6. Firewall Configuration

    DB Server A
        Allow inbound SQL only from App Server:

            10.0.0.20 → 10.0.0.10:1433

    DB Server B
        Allow Inbound SQL only from App Server (See firewall-rules.md for configuration.):

            10.0.0.20 → 10.0.0.30:1433


7. Verification

    Test SQL Connectivity
        
        From App Server PowerShell:

            Test-NetConnection -ComputerName 10.0.0.10 -Port 1433
            Test-NetConnection -ComputerName 10.0.0.30 -Port 1433

        Connect via SSMS

            Server: 10.0.0.10 (DB A)

            Server: 10.0.0.30 (DB B)

            Authentication: SQL or Windows (depending on configuration)
