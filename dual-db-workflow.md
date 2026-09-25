Markdown:

# Dual Database Workflow — App Server → DB Server A & DB Server B

## Overview
The App Server (10.0.0.20) communicates with two SQL Servers:

- **DB Server A (10.0.0.10)** — Primary business data  
- **DB Server B (10.0.0.30)** — Logging, analytics, audit trails  

This workflow ensures separation of concerns, performance stability, and clean scaling.

---

## Workflow Summary

### 1. User performs an action
Example: Create an order.

### 2. App Server writes business data → DB Server A
- Users  
- Orders  
- OrderItems  
- Payments  
- Inventory  

### 3. App Server writes logs/analytics → DB Server B
- AppLogs  
- AuditTrail  
- AnalyticsEvents  
- JobHistory  

### 4. App Server returns response to client

---

## Why This Architecture Works

### ✔ Isolation  
Business data is protected from noisy log writes.

### ✔ Performance  
DB A handles transactional queries.  
DB B handles append‑only writes.

### ✔ Scalability  
You can add:
- More logging servers  
- More analytics servers  
- A reporting server  
- A domain controller  

Without touching DB A.

---

## Data Flow Diagram

User → App Server → DB Server A (PrimaryDB)
→ DB Server B (LoggingDB)


---

## Recommended Practices

- Use **different SQL users** for each DB.  
- Keep **TrustServerCertificate=True** only in lab environments.  
- Restrict inbound SQL traffic to **App Server only**.  
- Use **async logging** to DB B for best performance.

