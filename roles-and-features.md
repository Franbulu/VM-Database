1. Overview

All servers run:

    Windows Server 2022 Standard (Desktop Experience)

    Static IP addressing

    Host‑Only networking (VMnet1)

    VMware Tools

    PowerShell 7 (recommended)

Each server has a different role profile:

    Server	        Role	                Required Features
    -------------------------------------------------------------
    App Server	    IIS + .NET	            Web Server, .NET, Management Tools
    DB Server A	    Primary SQL Server	    Database Engine prerequisites
    DB Server B	    Logging SQL Server	    Database Engine prerequisites


2. App Server — Required Roles & Features

    2.1 Server Roles

        Web Server (IIS)

            Required for hosting the .NET application.

            Includes:

                Web Server

                Common HTTP Features

                Application Development

                Health & Diagnostics

                Security

                Performance

                Management Tools

        IIS Management Tools
            
            IIS Management Console

            IIS Management Scripts & Tools

        Web Management Service (optional)
            
            Allows remote IIS management.

    2.2 Features
        
        .NET Framework 4.8 Features
        
        Required for IIS and ASP.NET Core hosting bundle.

        Includes:

            .NET Framework 4.8

            .NET Framework 4.8 WCF Services

            HTTP Activation

            Non‑HTTP Activation

        ASP.NET Core Hosting Bundle (installed manually)

            Enables hosting of .NET 6/7/8 applications in IIS.

        Windows Process Activation Service (WAS)
        
        Required for IIS.

        Includes:

            Process Model

            .NET Environment

            Configuration APIs

        PowerShell 7 (recommended)
            
            Used for automation and deployment scripts.

        Windows Defender Features
        
        Optional but recommended for security.


3. DB Server A — Required Roles & Features

    3.1 Server Roles
        
        SQL Server does not require Windows Server roles, but the following features must be enabled:

            .NET Framework 4.8: Required for SQL Server setup and management tools.

            Windows Process Activation Service (WAS): Required by SQL Server components.

    3.2 Features

            .NET Framework 4.8 Features: Required for SQL Server installation.

            PowerShell 7 (recommended): Useful for SQL automation and scripting.

            Windows Defender Features: Optional but recommended.

            Failover Clustering (optional): Only needed if you plan to simulate SQL clustering.


4. DB Server B — Required Roles & Features

DB Server B mirrors DB Server A’s requirements.

    4.1 Server Roles
        None required.

    4.2 Features
        .NET Framework 4.8

        Windows Process Activation Service

        PowerShell 7

        Windows Defender Features


5. Optional Features for All Servers

    Windows Admin Center: Provides a modern web‑based management interface.

    Telnet Client: Useful for testing port connectivity.

    SNMP Service: Optional for monitoring tools.

    Hyper‑V Management Tools: Useful if you plan to manage other hypervisors.


6. Installation Commands (PowerShell)

Install IIS + .NET (App Server)

    Install-WindowsFeature Web-Server, Web-WebServer, Web-Common-Http, Web-App-Dev, Web-Mgmt-Tools, Web-Mgmt-Service
    Install-WindowsFeature NET-Framework-Features
    Install-WindowsFeature WAS

Install SQL Prerequisites (DB Servers)

    Install-WindowsFeature NET-Framework-Features
    Install-WindowsFeature WAS

Install PowerShell 7 (All Servers)

    winget install --id Microsoft.PowerShell --source winget


7. Verification Checklist

Server	        IIS	        .NET	    WAS	    SQL Prereqs	    PowerShell 7
-----------------------------------------------------------------------------
App Server	    ✔            ✔	        ✔	        —	            ✔
DB Server A	    —	         ✔	        ✔	        ✔	            ✔
DB Server B	    —	         ✔	        ✔	        ✔	            ✔
