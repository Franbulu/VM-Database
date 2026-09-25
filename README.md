VMware Multi‑Server Virtual Environment Project
Overview
This project demonstrates a fully configured three‑server virtual environment built using VMware Workstation Player and Windows Server 2022. It showcases my ability to design, deploy, and manage a complete Microsoft‑based infrastructure — including SQL Server, IIS, networking, firewall rules, and dual‑database workflows.

The environment is structured exactly like a small enterprise lab, allowing me to practice real‑world Systems Administration, virtualization, and application deployment skills.

Purpose
The goal of this project was to build a reproducible, isolated, and secure virtual environment that mirrors professional IT infrastructure. This project strengthens my understanding of:

Virtualization and multi‑server architecture

Windows Server administration

SQL Server deployment and configuration

IIS hosting and .NET application deployment

Internal networking and firewall management

Documentation and version control

This lab directly supports my Systems Administration studies and prepares me for enterprise‑level environments.

Architecture Overview
The virtual environment consists of three Windows Server 2022 VMs connected through a Host‑Only network (VMnet1):

Server	IP Address	Role
DB Server A	10.0.0.10	Primary SQL Server (business data)
App Server	10.0.0.20	IIS + .NET application server
DB Server B	10.0.0.30	Logging & analytics SQL Server


All servers run on an isolated subnet with no internet exposure, ensuring a secure and predictable environment.

Technologies Used
VMware Workstation Player

Windows Server 2022

SQL Server 2022 (Developer/Express)

IIS Web Server

ASP.NET Core Hosting Bundle

PowerShell 7

GitHub for documentation and version control

Key Features
Fully isolated Host‑Only network (VMnet1)

Static IP addressing across all servers

Dual‑database architecture (PrimaryDB + LoggingDB)

IIS‑hosted .NET API with dual‑DB workflow

SQL Server configured with secure firewall rules

Modular documentation for reproducibility

Enterprise‑style configuration files and deployment guides

Documentation Included
This repository contains complete documentation for the entire environment:

VM Config Files

Windows Server Installation Guide

SQL Server Installation Guide

Roles & Features

Firewall Rules

Dual‑DB Workflow

Connection Strings

Troubleshooting Guide

Full Deployment Guide

FAQ

Each file is written to be clear, professional, and reproducible on any machine.

What I Learned
Designing multi‑server architectures

Configuring Windows Server roles and features

Installing and securing SQL Server

Hosting .NET applications in IIS

Managing firewall rules and network isolation

Using PowerShell for administration

Documenting technical environments professionally

Using GitHub for version control and project organization

Author
Francine Bulu  
Systems Administration & Management Graduate
Nashville State Community College
