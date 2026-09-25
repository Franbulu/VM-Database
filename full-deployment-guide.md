1. Prepare VMware Environment

    1.1 Configure VMnet1 (Host‑Only)

        Subnet: 10.0.0.0/24

        Host IP: 10.0.0.1

        DHCP: Disabled

        Gateway: None

    1.2 Create VMs

        Create three Windows Server 2022 VMs:

            Server	        IP	            Role
            -------------------------------------------
            DB Server A	    10.0.0.10	    Primary SQL
            App Server	    10.0.0.20	    IIS + .NET
            DB Server B	    10.0.0.30	    Logging SQL


2. Install Windows Server 2022

    Follow server2022-installation.md:

        Install Windows Server 2022

        Install VMware Tools

        Assign static IP

        Rename server

        Apply updates

        Enable RDP

        Disable IPv6


3. Install SQL Server 2022

    Follow install-sql-server.md:

        Install SQL Server Developer or Express

        Enable TCP/IP

        Set port 1433

        Create databases:

            PrimaryDB

            LoggingDB

        Create SQL users:

            appuser (DB A)

            loguser (DB B)


4. Apply Firewall Rules

    Follow firewall-rules.md:

        DB A: allow SQL from App Server only

        DB B: allow SQL from App Server only

        App Server: allow outbound SQL + inbound IIS

        Host: allow RDP to all servers


5. Deploy IIS + .NET Application
    
    5.1 Install IIS
        
        Follow roles-and-features.md:

            Web Server (IIS)

            ASP.NET Core Hosting Bundle

            WAS

            Management Tools

    5.2 Publish .NET App

        On your development machine:

            dotnet publish -c Release -o ./publish

        Copy the publish folder to:

            C:\inetpub\wwwroot\SampleApi

    5.3 Configure IIS Site
    
        Create new site: SampleApi

        Physical path: C:\inetpub\wwwroot\SampleApi

        Binding:

            HTTP → port 80

        App Pool:

            No Managed Code

            In‑Process hosting

    5.4 Add appsettings.json
        
        Include dual DB connection strings.


6. Verify Dual‑DB Workflow

    Test Primary DB

        Test-NetConnection 10.0.0.10 -Port 1433

    Test Logging DB

        Test-NetConnection 10.0.0.30 -Port 1433

    Test API

        POST http://10.0.0.20/orders

            Should create:

                Order in DB A

                Log entry in DB B


7. Deployment Complete

    Your full environment is now live.