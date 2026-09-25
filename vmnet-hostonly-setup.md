1. Network Purpose

VMnet1 provides:

    A private, isolated network for all three Windows Server VMs

    No internet access, preventing external exposure

    Static IP addressing for predictable routing

    Host access for RDP and management tools

    Reproducibility across different computers (including remote setups)

This network is the backbone of the architecture.


2. VMnet1 Configuration Summary

Setting	            Value
----------------------------------
Network Type	    Host‑Only
Virtual Switch	    VMnet1
Subnet	            10.0.0.0/24
Host IP	            10.0.0.1
DHCP	            Disabled
Gateway	            None
DNS	Local           server or loopback


3. How to Configure VMnet1 in VMware Workstation Player

Step I — Open Virtual Network Editor

    a. Open VMware Workstation Player

    b. Navigate to:
        Edit → Virtual Network Editor

Step II — Select VMnet1

    Choose VMnet1 (Host‑Only) from the list

    Ensure the network type is set to Host‑Only

Step III — Configure Subnet

Set the subnet to:

    10.0.0.0
    255.255.255.0

Step IV — Disable DHCP

    Uncheck:

        “Use local DHCP service to distribute IP addresses”

This ensures all servers use static IPs.

Step V — Apply Changes

    Click Apply and OK.

    VMnet1 is now ready for use.


4. Static IP Assignments for All Servers

Each VM must be configured manually with the following IPs:

    DB Server A — Primary SQL Server
        IP Address: 10.0.0.10
        Subnet Mask: 255.255.255.0
        Gateway: (none)
        DNS: 127.0.0.1

    App Server — IIS + .NET
        IP Address: 10.0.0.20
        Subnet Mask: 255.255.255.0
        Gateway: (none)
        DNS: 127.0.0.1

    DB Server B — Logging / Analytics SQL Server
        IP Address: 10.0.0.30
        Subnet Mask: 255.255.255.0
        Gateway: (none)
        DNS: 127.0.0.1


5. Host Machine IP

VMware automatically assigns the host machine an IP on VMnet1: Host IP: 10.0.0.1

    This allows:

        RDP access to each VM

        Windows Admin Center management

        File transfers (if enabled)


6. Firewall Rules Required for VMnet1

    App Server
        Inbound:

            Optional: HTTP/HTTPS

            RDP from host (10.0.0.1)

        Outbound:

            SQL traffic to DB A (10.0.0.10:1433)

            SQL traffic to DB B (10.0.0.30:1433)

    DB Server A
        Inbound:

            SQL port 1433 from App Server only

    DB Server B
        Inbound:

            SQL port 1433 from App Server only


7. Testing Connectivity

Run the following commands from each server:

    Ping App Server
        ping 10.0.0.20

    Ping DB server A
        ping 10.0.0.10

    Ping DB Server B
        ping 10.0.0.30

    Ping Host
        ping 10.0.0.1

All pings should succceed


