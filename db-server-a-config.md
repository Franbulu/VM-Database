1. VM Overview

Purpose:  

    Primary SQL Server responsible for structured business data, transactional operations, and high‑integrity storage.

Operating System:  

    Windows Server 2022 Standard (Desktop Experience)

Network: 

    Host‑Only (VMnet1) — isolated internal network


2. Virtual Hardware Configuration

vCPU: 2 cores

Memory: 4 GB RAM

Storage: 40–60 GB NVMe virtual disk

Firmware: UEFI

Graphics: Disabled (SQL Server does not require GPU acceleration)

Virtualization Engine:

    Virtualize Intel VT‑x/EPT or AMD‑V/RVI

    Virtualize IOMMU (if available)

Rationale

SQL Server benefits from:

    Stable RAM allocation

    Fast disk I/O (NVMe recommended)

    Predictable CPU availability

This configuration balances performance with resource efficiency for a personal‑computer lab environment.


3. Network Configuration

Adapter Type

    Host‑Only (VMnet1)

    Ensures DB Server A is reachable only by the App Server

    No internet exposure

Static IP Assignment

    IP Address: 10.0.0.10

    Subnet Mask: 255.255.255.0

    Gateway: None

    DNS: 127.0.0.1 (local loopback)

Firewall Rules

    Allow inbound SQL traffic only from the App Server:

Source	    Destination	    Port	Purpose
10.0.0.20	10.0.0.10	    1433	SQL Server

Allow RDP only from the host machine (10.0.0.1).


4. Storage Configuration

Virtual Disk

    Type: Single‑file virtual disk

    Size: 40–60 GB

    Controller: NVMe (recommended)

    Provisioning: Thin provisioning acceptable for lab environments

Reasoning

    SQL Server requires:

        Additional disk space for MDF, LDF, and backup files

        Fast disk access for query performance

        Room for future schema expansion


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

DB Server A must have the following components installed:

    SQL Server Edition

        SQL Server Express or Developer Edition  (Both are free and fully compatible with Windows Server 2022.)

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

    Stores primary business data

    Handles transactional queries

    Maintains core schema integrity


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