# 🏨 Hotel Management System (SQL Project)
## 📌 Project Overview

This project is a SQL-based Hotel Management System that manages hotel operations like customers, rooms, staff, bookings, and payments.
It is designed for learning and demonstration purposes, with sample data and queries included.

The project helps in understanding:

Database design (ER diagram + schema)

Relationships between tables

Data insertion (dummy/sample data)

Writing queries for real-life hotel management scenarios

## 📂 Folder Structure
```
HotelManagementSystem/
│
├── README.md # Project overview, setup steps
│
├── schema.sql # Database + table creation scripts
├── seed.sql # Sample data inserts
├── queries.sql # General queries (SELECT, JOIN, filters)
├── situational_queries.sql # Special queries (reporting/business cases)
│
└── docs/
├── ER_Diagram.png # ER diagram of HotelSalesDB
└── Project_Report.docx # Documentation
```

## 🗄️ Database Schema

The database HotelSalesDB includes the following tables:

Customers → Stores customer details

Rooms → Stores room details (type, price, capacity)

Staff → Stores staff information (roles, contacts)

Bookings → Stores booking details (customer, room, staff, dates, amount)

Payments → Stores payment transactions for bookings

## ⚡ Features

✔ Customer management
✔ Room availability & pricing
✔ Staff roles & assignments
✔ Booking and billing system
✔ Payment tracking
✔ Sample data + situational queries

## 🚀 How to Run

### Clone this repository
```bash
git clone https://github.com/prafullwahatule/HotelManagementSystem.git
cd HotelManagementSystem
```

### Open MySQL and run the schema file
```bash
SOURCE schema.sql;
```

### Insert sample data
```bash
SOURCE seed.sql;
```

### Run general queries
```bash
SOURCE queries.sql;
```

### Run situational/business queries
```bash
SOURCE situational_queries.sql;
```

## 📊 ER Diagram

(See docs/ER_Diagram.png for database relationships)

## 📝 Documentation

Detailed project explanation is available in docs/Project_Report.docx.
