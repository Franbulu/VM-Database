1. VM Overview

Purpose:  

    Secondary SQL Server dedicated to logging, analytics, audit trails, and background processing.
    Offloads non‑critical workloads from DB Server A to improve performance and maintain separation of concerns.

Operating System: 

    Windows Server 2022 Standard (Desktop Experience)

Network: 

    Host‑Only (VMnet1) — isolated internal network


2. Virtual Hardware Configuration

vCPU: 2 cores

Memory: 4 GB RAM

Storage: 30–40 GB NVMe virtual disk

Firmware: UEFI

Graphics: Disabled

Virtualization Engine:

    Virtualize Intel VT‑x/EPT or AMD‑V/RVI

    Virtualize IOMMU (if available)

Rationale

    DB Server B handles lightweight workloads such as logs and analytics.
    It does not require the same disk capacity or performance profile as DB Server A.


3. Network Configuration

Adapter Type

    Host‑Only (VMnet1)

    Ensures DB Server B is reachable only by the App Server

    No internet exposure

Static IP Assignment

    IP Address: 10.0.0.30

    Subnet Mask: 255.255.255.0

    Gateway: None

    DNS: 127.0.0.1 (local loopback)

Firewall Rules

    Allow inbound SQL traffic only from the App Server:

        Source	    Destination	    Port	Purpose
        10.0.0.20	10.0.0.30	    1433	SQL Server

Allow RDP only from the host machine (10.0.0.1).


4. Storage Configuration

Virtual Disk

    Type: Single‑file virtual disk

    Size: 30–40 GB

    Controller: NVMe (recommended)

    Provisioning: Thin provisioning acceptable for lab environments

Reasoning

    Logging and analytics workloads require:

    Moderate disk space

    Fast sequential writes

    Room for log growth

40 GB provides sufficient capacity without over‑allocating host storage.


5. VMware Settings

Memory Settings

    Disable “Allow VMs to use more memory than allocated”

    Disable “Fit all memory into reserved host RAM”

Processors

    Enable:

        Virtualize Intel VT‑x/EPT or AMD‑V/RVI

        Virtualize IOMMU

Isolation

    Disable shared folders

    Disable drag‑and‑drop

    Disable copy/paste (optional for security)


6. SQL Server Configuration

DB Server B must have the following components installed:

    SQL Server Edition
        SQL Server Express or Developer Edition

Required Features

    Database Engine Services

    SQL Server Management Studio (SSMS)

    Full‑Text Search (optional)

    SQL Client Connectivity SDK

Service Configuration

    SQL Server Browser: Disabled

    SQL Server Agent: Disabled (Express) or Manual (Developer)

    Authentication Mode: Mixed Mode (recommended for labs)

Database Responsibilities

    Stores logs

    Stores analytics data

    Stores audit trails

    Supports reporting or monitoring tools


7. Security Configuration

SQL Server

    Strong SA password

    Disable remote connections except from App Server

    Restrict login permissions

    Enable TCP/IP protocol

    Bind SQL Server to port 1433

Windows Firewall

    Inbound rules:

        Allow SQL Server port 1433 from App Server only

        Allow RDP from host (10.0.0.1)

    Outbound rules:

        Allow SQL traffic to App Server (optional for testing)

        Block internet access