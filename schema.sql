-- ==============================================================
-- Project: Hotel Management System
-- File   : schema.sql
-- Purpose: Create database and define all required tables
-- ==============================================================

-- Step 1: Drop database if it already exists (for a fresh start)
DROP DATABASE IF EXISTS HotelSalesDB;

-- Step 2: Create new database
CREATE DATABASE HotelSalesDB;

-- Step 3: Use the created database
USE HotelSalesDB;

-- ==============================================================
-- Table: Customers
-- Purpose: Store details of customers who book rooms in the hotel
-- ==============================================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT, -- Unique ID for each customer
    FirstName VARCHAR(50),                     -- Customer's first name
    LastName VARCHAR(50),                      -- Customer's last name
    Email VARCHAR(100) UNIQUE,                 -- Customer email (must be unique)
    Phone VARCHAR(15),                         -- Customer phone number
    City VARCHAR(50)                           -- City where customer lives
);

-- ==============================================================
-- Table: Rooms
-- Purpose: Store details of rooms available in the hotel
-- ==============================================================
CREATE TABLE Rooms (
    RoomID INT PRIMARY KEY AUTO_INCREMENT,     -- Unique ID for each room
    RoomType VARCHAR(50),                      -- Type of room (Single, Double, Suite)
    PricePerNight DECIMAL(10,2),               -- Cost per night for staying in the room
    Capacity INT                               -- Maximum number of people allowed in the room
);

-- ==============================================================
-- Table: Staff
-- Purpose: Store information about hotel staff members
-- ==============================================================
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,    -- Unique ID for each staff member
    FirstName VARCHAR(50),                     -- Staff first name
    LastName VARCHAR(50),                      -- Staff last name
    Role VARCHAR(50),                          -- Staff role (Manager, Receptionist, etc.)
    Phone VARCHAR(15),                         -- Staff contact number
    Email VARCHAR(100)                         -- Staff email address
);

-- ==============================================================
-- Table: Bookings
-- Purpose: Store information about room bookings by customers
-- ==============================================================
CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each booking
    CustomerID INT,                            -- Customer who made the booking
    RoomID INT,                                -- Room that was booked
    StaffID INT,                               -- Staff member who handled the booking
    CheckInDate DATE,                          -- Check-in date
    CheckOutDate DATE,                         -- Check-out date
    TotalAmount DECIMAL(10,2),                 -- Total cost of the booking
    
    -- Foreign keys to maintain relationships
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

-- ==============================================================
-- Table: Payments
-- Purpose: Store details of payments made for bookings
-- ==============================================================
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,  -- Unique ID for each payment
    BookingID INT,                             -- Related booking ID
    PaymentDate DATE,                          -- Date when payment was made
    PaymentMethod VARCHAR(50),                 -- Method of payment (Cash, Card, UPI, etc.)
    Amount DECIMAL(10,2),                      -- Amount paid
    
    -- Foreign key linking payment to a booking
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);
