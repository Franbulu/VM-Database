1. VM Overview

Purpose:  
    Runs the web application, API endpoints, background services, and dual‑database workflow.

Operating System:  
    Windows Server 2022 Standard (Desktop Experience)

Network:  
    Host‑Only (VMnet1) — isolated internal network


2. Virtual Hardware Configuration

vCPU Allocation — 2 cores

Memory Allocation — 4–6 GB RAM

Storage — 40 GB NVMe virtual disk

Firmware — UEFI

Graphics — 3D acceleration disabled

Virtualization Engine

    Virtualize Intel VT‑x/EPT or AMD‑V/RVI

    Virtualize IOMMU (if available)


3. Network Configuration

Adapter Type
    Host‑Only (VMnet1)

    Ensures the App Server communicates only with DB Server A and DB Server B

    No internet exposure

Static IP Assignment
    IP Address: 10.0.0.20

    Subnet Mask: 255.255.255.0

    Gateway: None

    DNS: 127.0.0.1 (local loopback)

Firewall Rules
    Allow outbound SQL traffic to:

        DB Server A → 10.0.0.10:1433

        DB Server B → 10.0.0.30:1433

    Allow inbound:

        HTTP/HTTPS (optional)

        RDP from host (10.0.0.1)


4. Storage Configuration

Virtual Disk

    Type: Single‑file virtual disk

    Size: 40 GB

    Controller: NVMe (recommended)

    Provisioning: Thin provisioning acceptable for lab environments

Reasoning:
The App Server hosts IIS, .NET runtime, logs, and application files.
40 GB provides sufficient space without wasting host storage.


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


6. Operating System Roles

The App Server must have the following Windows Server roles installed:

    IIS Web Server

    ASP.NET Core Hosting Bundle

    Web Management Tools

PowerShell 7

    Windows Admin Center (optional)


7. Application Layer Configuration

    Dual‑Database Connectivity

    The App Server must include:

    Primary DB connection → DB Server A

    Logging DB connection → DB Server B

See: dual-db-workflow.md

IIS Configuration

    Application Pool: No Managed Code

    Hosting Model: In‑Process

    Anonymous Authentication enabled

    Windows Firewall rules applied

