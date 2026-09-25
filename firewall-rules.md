1. Security Principles

The firewall configuration follows these principles:

    Least privilege: Only required ports are opened.

    Isolation: No inbound internet traffic.

    Controlled access: Only the App Server may access SQL ports.

    Host‑only management: RDP allowed only from the host machine.

    No VM‑to‑VM RDP: Prevents lateral movement.


2. Required Firewall Rules by Server

    2.1 App Server (10.0.0.20)

        Inbound Rules

            Port	Protocol	Source	    Purpose
            -------------------------------------------------------
            80	    TCP	        Host        (optional)	HTTP (IIS)
            443	    TCP	        Host        (optional)	HTTPS (IIS)
            3389	TCP	        10.0.0.1	Remote Desktop from host
            5985	TCP	        10.0.0.1	WinRM (optional)
            5986	TCP	        10.0.0.1	WinRM HTTPS (optional) 

        Outbound Rules

            Destination	    Port	Purpose
            ---------------------------------------------
            10.0.0.10	    1433	SQL Server (Primary DB)
            10.0.0.30	    1433	SQL Server (Logging DB)

Notes:

IIS requires ports 80 and 443 only if you plan to test web access from the host.

No inbound SQL traffic should ever be allowed to the App Server.

2.2 DB Server A — Primary SQL Server (10.0.0.10)
        
        Inbound Rules

            Port	Protocol	        Source	Purpose
            ---------------------------------------------------------------
            1433	TCP	10.0.0.20	    SQL Server traffic from App Server
            3389	TCP	10.0.0.1	    RDP from host

        Outbound Rules

            Destination	    Port	    Purpose
            -------------------------------------------------------
            10.0.0.20	    Dynamic	    SQL responses to App Server

Notes:

Only the App Server should be allowed to reach SQL Server.

No inbound traffic from DB Server B.

No internet access.

2.3 DB Server B — Logging / Analytics SQL Server (10.0.0.30)

        Inbound Rules

            Port	Protocol	    Source	    Purpose
            ------------------------------------------------------------------
            1433	TCP	10.0.0.20	SQL         Server traffic from App Server
            3389	TCP	10.0.0.1	RDP         from host

        Outbound Rules

            Destination	Port	    Purpose
            ---------------------------------------------------
            10.0.0.20	Dynamic	    SQL responses to App Server

Notes:

DB Server B should only accept SQL traffic from the App Server.

No inbound traffic from DB Server A.

No internet access.


3. Optional Rules (All Servers)

Windows Admin Center
    
    If using WAC from the host:

        Port	Protocol	Source
        -----------------------------
        6516	TCP	        10.0.0.1

File Sharing (SMB)

    Only if needed for transfaring files:

        Port	Protocol	Source
        ----------------------------
        445	    TCP	        10.0.0.1

Ping (ICMP)

    Useful for testing connectivity:

        Type	Direction
        -----------------------
        Echo    Request	Inbound
        Echo    Reply	Outbound


4. PowerShell Commands

Allow SQL Server from App Server (DB A & DB B)
    New-NetFirewallRule -DisplayName "SQL From App Server" -Direction Inbound -Protocol TCP -LocalPort 1433 -RemoteAddress 10.0.0.20 -Action Allow

Allow RDP from Host
    New-NetFirewallRule -DisplayName "RDP From Host" -Direction Inbound -Protocol TCP -LocalPort 3389 -RemoteAddress 10.0.0.1 -Action Allow

Allow IIS (App Server only)
    New-NetFirewallRule -DisplayName "IIS HTTP" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
    New-NetFirewallRule -DisplayName "IIS HTTPS" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow


5. Verification Checklist

    Server	        SQL Allowed	    RDP Allowed	    IIS Allowed	    Internet Blocked
    ---------------------------------------------------------------------------------
    App Server	    ✔ outbound	    ✔ inbound	    ✔	            ✔
    DB Server A	    ✔ inbound	    ✔ inbound	    —	            ✔
    DB Server B	    ✔ inbound	    ✔ inbound	    —	            ✔


