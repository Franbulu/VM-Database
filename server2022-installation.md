1. Prerequisites

Required Files

    Windows Server 2022 ISO (Evaluation or licensed)

    VMware Workstation Player installed on the host machine

Recommended Host Specs

    16 GB RAM minimum

    Quad‑core CPU

    150–200 GB free disk space

    Windows 11 Home or Pro


2. Create a New Virtual Machine

    Step 1 — Launch VMware Workstation Player

        Open VMware Workstation Player → Create a New Virtual Machine

    Step 2 — Select Installer Disk Image

        Choose: Installer disc image file (ISO)

        Browse to: Windows Server 2022 ISO

    Step 3 — Select Guest Operating System

        OS: Microsoft Windows

        Version: Windows Server 2022

    Step 4 — Name the VM

        Use one of the following names depending on the server:

            App-Server-WS2022

            DB-Server-A-WS2022

            DB-Server-B-WS2022

    Step 5 — Specify Disk Capacity

            App Server: 40 GB

            DB Server A: 40–60 GB

            DB Server B: 30–40 GB

        Choose:
            "Store virtual disk as a single file"

    Step 6 — Customize Hardware

        Adjust the following:

            Processors
                2 cores
                Enable:

                    Virtualize Intel VT‑x/EPT or AMD‑V/RVI
                    Virtualize IOMMU

            Memory
                App Server: 4–6 GB
                DB Servers: 4 GB

            Network Adapter
                Set to: Host-only (VMnet1)

            Hard Disk
                Change controller to: NVMe (recommended)

        Click Close → Finish.


3. Begin Windows Server Installation

    Step 1 — Boot from ISO

        VM boots into Windows Setup.

    Step 2 — Select Language and Region

        Default options are acceptable.

    Step 3 — Install Now

    Step 4 — Choose Edition
        Select: "Windows Server 2022 Standard (Desktop Experience)"

    Step 5 — Accept License Terms

    Step 6 — Choose Installation Type
        Select: "Custom: Install Windows only"

    Step 7 — Select Disk

        Choose the NVMe disk → Next

        Windows will begin installation.


4. Initial Configuration

    Step 1 — Set Administrator Password: Use a strong password.

    Step 2 — Log In
        
        Press Ctrl+Alt+Insert in VMware to send Ctrl+Alt+Delete.

    Step 3 — Install VMware Tools

        VMware Player → Player → Manage → Install VMware Tools

        This installs:

            Drivers

            Clipboard integration

            Better mouse control

            Improved network stability


5. Configure Network Settings

    Step 1 — Open Network Adapter Settings
        Control Panel → Network and Internet → Network Connections

    Step 2 — Assign Static IP
        Use the IP plan:

            DB Server A
                10.0.0.10
                255.255.255.0
                (no gateway)
                DNS: 127.0.0.1

            App Server
                10.0.0.20
                255.255.255.0
                (no gateway)
                DNS: 127.0.0.1

            DB Server B
                10.0.0.30
                255.255.255.0
                (no gateway)
                DNS: 127.0.0.1

    Step 3 — Disable IPv6
        Recommended for isolated lab networks.


6. Apply Windows Updates

Open:
    Settings → Windows Update → Check for updates (Install all updates)

7. Rename the Server

Open PowerShell:
    Rename-Computer -NewName "APP-SERVER"     (for App Server)
    Rename-Computer -NewName "DB-A-SERVER"    (for DB Server A)
    Rename-Computer -NewName "DB-B-SERVER"    (for DB Server B)
Restart the VM


8. Enable Remote Desktop

Open:
    System Properties → Remote → Allow remote connections

Allow RDP only from:
    10.0.0.1 (host machine)


9. Configure Windows Firewall

App Server

    Allow inbound:

        HTTP (80)

        HTTPS (443)

        SQL outbound

        RDP from host

DB Servers

    Allow inbound:

    SQL Server port 1433 from App Server only


10. Post‑Installation Checklist

    Task	                       Status
    ----------------------------------------
    Windows Server installed	    ✔
    VMware Tools installed	        ✔
    Static IP configured	        ✔
    Host‑only network verified	    ✔
    Firewall rules applied	        ✔
    Server renamed	                ✔
    Windows updates applied	        ✔

