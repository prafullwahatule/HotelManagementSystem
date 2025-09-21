-- ==============================================================
-- Project : Hotel Management System
-- File    : situational_queries.sql
-- Purpose : Situational SQL Queries (Questions Only)
-- ==============================================================

-- Question 1: The accounts team wants to check payments made via UPI to measure digital adoption.
SELECT * FROM payments
WHERE PaymentMethod = 'UPI';

-- Question 2: List all unique first names of customers for a duplicate check.
SELECT DISTINCT FirstName FROM customers;

-- Question 3: Delete all rooms with Capacity = 1.
SET SQL_SAFE_UPDATES = 0;

		-- 1️ Delete payments linked to bookings for rooms with Capacity = 1
DELETE FROM payments
WHERE BookingID IN (
    SELECT BookingID 
    FROM bookings
    WHERE RoomID IN (SELECT RoomID FROM rooms WHERE Capacity = 1)
);

		-- 2️ Delete bookings linked to rooms with Capacity = 1
DELETE FROM bookings
WHERE RoomID IN (SELECT RoomID FROM rooms WHERE Capacity = 1);

		-- 3️ Now delete the rooms
DELETE FROM rooms
WHERE Capacity = 1;

-- Question 4: Display each customer’s name and phone number together using CONCAT.
SELECT
CONCAT(FirstName," ", LastName, "-", Phone) AS Name_With_Mobile
FROM customers;

-- Question 5: The booking office wants to see bookings where RoomID = 10 to check utilization of a specific room.
SELECT * FROM bookings
WHERE RoomID = 10;

-- Question 6: Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery)
SELECT AVG(Capacity) FROM rooms;

SELECT * FROM rooms
WHERE Capacity > (SELECT AVG(Capacity) FROM rooms);

-- Question 7: Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and Phone.
CREATE VIEW StaffContact AS
SELECT FirstName, LastName, Role, Phone
FROM Staff;

SELECT * FROM StaffContact;

-- Question 8: The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
SELECT RoomID, PricePerNight, RoomType
FROM Rooms
WHERE PricePerNight < 7000
  AND RoomType = 'Suite';

-- Question 9: The admin wants to see email addresses sorted by LastName from the Customers table.
SELECT FirstName, LastName, Email 
FROM customers
ORDER BY LastName;

-- Question 10: Show staff full names combined into one column.
SELECT *, 
       CONCAT(FirstName, ' ', LastName) AS FullName
FROM Staff;

-- Question 11: Display all payment details in one line using CONCAT_WS.
SELECT CONCAT_WS('/',
       PaymentID,
       BookingID,
       PaymentDate,
       PaymentMethod,
       Amount) AS PaymentDetails
FROM Payments;

-- Question 12: The hotel wants to display the 2 most expensive rooms for VIP guests.
SELECT *
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 2;

-- Question 13: Show each BookingID with its CheckIn and CheckOut dates combined.
SELECT 
	BookingID, 
	CONCAT(CheckInDate," ",CheckOutDate) AS CombineDate 
FROM bookings;

-- Question 14: Finance wants to calculate the average Amount per PaymentMethod.
SELECT 
PaymentMethod, 
AVG(Amount) AS AVG_Amount 
FROM payments
GROUP BY PaymentMethod;

-- Question 15: The analytics team wants to find the city where average CustomerID is greater than 50.
SELECT City, AVG(CustomerID) AS AvgCustomerID
FROM Customers
GROUP BY City
HAVING AVG(CustomerID) > 50;

-- Question 16: Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)
SELECT *
FROM Bookings
WHERE TotalAmount > (
    SELECT AVG(TotalAmount)
    FROM Bookings
);

-- Question 17: Display the last 2 added rooms from the Rooms table.
SELECT * FROM rooms;
SELECT * FROM rooms
ORDER BY RoomID DESC
LIMIT 2;

SELECT *
FROM (
    SELECT *
    FROM Rooms
    ORDER BY RoomID DESC
    LIMIT 2
) AS RecentRooms
ORDER BY RoomID ASC;

-- Question 18: The cashier wants a report of payments where Amount < ₹1500 for small transactions.
SELECT *
FROM Payments
WHERE Amount < 1500;

-- Question 19: Management wants to list all customers who have made more than 5 bookings.
SELECT * 
FROM Customers
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Bookings
    GROUP BY CustomerID
    HAVING COUNT(CustomerID) > 5
);

SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(b.CustomerID) AS TotalBooking
FROM customers c
JOIN bookings b
ON c.CustomerID = b.CustomerID
GROUP BY b.CustomerID,c.FirstName, c.LastName
HAVING TotalBooking > 5;

-- Question 20: Identify customers who live in the same city. (Customers self join)
SELECT c1.FirstName, c1.LastName, c1.City,
       c2.FirstName AS OtherFirstName, c2.LastName AS OtherLastName
FROM Customers c1
JOIN Customers c2 
    ON c1.City = c2.City 
    AND c1.CustomerID <> c2.CustomerID
ORDER BY c1.City;

-- Question 21: Show the total revenue handled by each StaffID.
SELECT StaffID, 
       SUM(TotalAmount) AS Revenue
FROM Bookings
GROUP BY StaffID;

-- Question 22: The manager wants to see all customers from Mumbai to check city-wise marketing campaigns.
SELECT * 
FROM Customers
WHERE City = 'Mumbai';

-- Question 23: Display the 3 lowest booking amounts.
SELECT * 
FROM Bookings
ORDER BY TotalAmount ASC
LIMIT 3;

-- Question 24: Insert 5 new room records with type, price, and capacity into the Rooms table.
SELECT * FROM rooms;
INSERT INTO rooms (RoomType,PricePerNight,Capacity) VALUES
("Double",5500,4),
("Suite",7400,1),
("Deluxe",6500,3),
("Deluxe",6100,3),
("Family",2400,2);

-- Question 25: Show all unique CustomerIDs from bookings.
SELECT 
DISTINCT CustomerID 
FROM Bookings;

-- Question 26: Create a trigger to automatically delete a payment when its corresponding booking is deleted.
DELIMITER $$

CREATE TRIGGER AutoPaymentDelete
AFTER DELETE ON bookings
FOR EACH ROW
BEGIN
    DELETE FROM payments
    WHERE BookingID = OLD.BookingID;
END$$

DELIMITER ;

-- Question 27: The marketing team wants to update the FirstName of CustomerID = 30 to 'Rahul'.
UPDATE customers
SET FirstName = 'Rahul'
WHERE customerID = 30;

-- Question 28: List all bookings ordered by CheckInDate.
SELECT *
FROM Bookings
ORDER BY CheckInDate;

-- Question 29: Show all rooms where capacity is greater than 2.
SELECT * 
FROM rooms
WHERE Capacity > 2;

-- Question 30: List staff emails ordered by their roles.
SELECT Email, Role
FROM staff
ORDER BY Role;

-- Question 31: Display each customer’s full name and city using CONCAT_WS.
SELECT 
    CONCAT_WS(' ', FirstName, LastName, City) AS FullNameAndCity
FROM customers;

-- Question 32: Show the first 4 customers’ full names only.
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName
FROM customers
LIMIT 4;

-- Question 33: Show each staff’s role with their full name.
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    Role
FROM staff;

-- Question 34: Management wants to find the average StaffID per role.
SELECT 
    Role, 
    AVG(StaffID) AS AvgStaffID
FROM Staff
GROUP BY Role;

-- Question 35: List all bookings handled by StaffID = 2.
SELECT *
FROM Bookings
WHERE StaffID = 2;

-- Question 36: Display the first 3 staff alphabetically by their first names.
SELECT * FROM staff
ORDER BY FirstName ASC
LIMIT 3;

-- Question 37: The front desk manager wants to see customers where FirstName = 'Amit' AND City = 'Nagpur' for personal attention.
SELECT *
FROM Customers
WHERE FirstName = 'Amit' AND City = 'Nagpur';

-- Question 38: Show all unique payment methods in descending order.
SELECT DISTINCT PaymentMethod
FROM Payments
ORDER BY PaymentMethod DESC;

-- Question 39: Insert 5 staff members into the Staff table with their role, phone, and email.
INSERT INTO Staff (FirstName, LastName, Role, Phone, Email)
VALUES
('Prafull', 'Wahatule', 'Manager', '7875789496', 'prafull@gmail.com'),
('Amit', 'Sharma', 'Receptionist', '9876543210', 'amit.sharma@gmail.com'),
('Riya', 'Patil', 'Housekeeping', '9123456780', 'riya.patil@gmail.com'),
('Sanjay', 'Kumar', 'Chef', '9988776655', 'sanjay.kumar@gmail.com'),
('Neha', 'Joshi', 'Front Desk', '9012345678', 'neha.joshi@gmail.com');

-- Question 40: The hotel manager wants to review bookings where CheckInDate is after '2024-01-01' to analyze recent occupancy.
SELECT * FROM Bookings
WHERE CheckInDate > '2024-01-01';

-- Question 41: List all customers whose FirstName is 'Rahul' for a loyalty program.
SELECT * FROM customers
WHERE FirstName = 'Rahul';

-- Question 42: Show all unique room types offered by the hotel.
SELECT DISTINCT RoomType FROM rooms;

-- Question 43: Identify customers who spent more than 50,000 in total.
SELECT 
    CustomerID,
    SUM(TotalAmount) AS TotalSpent
FROM Bookings
GROUP BY CustomerID
HAVING SUM(TotalAmount) > 50000;

-- Question 44: Delete all customers from the city 'TestCity'.
DELETE FROM customers
WHERE City = 'TestCity';

-- Question 45: Find rooms that have the same PricePerNight. (Rooms self join)
SELECT r1.RoomID, r1.RoomType, r1.PricePerNight, r2.RoomID, r2.RoomType
FROM rooms r1
JOIN rooms r2 
    ON r1.PricePerNight = r2.PricePerNight 
   AND r1.RoomID <> r2.RoomID;

-- Question 46: The manager wants to see staff whose Email ends with '@tcs.in' for corporate tie-ups.
SELECT * FROM staff
WHERE Email LIKE '%@tcs.in';

-- Question 47: The analytics team wants to list all cities where maximum CustomerID is more than 100.
SELECT City, MAX(CustomerID) AS MaxID FROM Customers
GROUP BY City
HAVING MaxID > 100;

-- Question 48: Show all unique capacities in descending order.
SELECT DISTINCT Capacity FROM rooms
ORDER BY Capacity DESC;

-- Question 49: List staff working as Managers.
SELECT * FROM Staff
WHERE Role = 'Manager';

-- Question 50: Display each payment’s ID, Method, Amount in one line.
SELECT CONCAT_WS(' - ', PaymentID, PaymentMethod, Amount) AS PaymentInfo
FROM payments;

-- Question 51: Show the first 4 payments only.
SELECT * FROM payments
LIMIT 4;

-- Question 52: The hotel manager wants to review rooms where PricePerNight is between ₹2000 and ₹4000 to offer discounts.
SELECT * FROM rooms
WHERE PricePerNight BETWEEN 2000 AND 4000;

-- Question 53: List all bookings ordered by CheckInDate.
SELECT * FROM bookings
ORDER BY CheckInDate;

-- Question 54: Display all unique CustomerIDs from bookings.
SELECT DISTINCT CustomerID FROM bookings;

-- Question 55: The hotel manager wants to add new customer details. Insert 5 records with full details into the Customers table.
INSERT INTO Customers (FirstName, LastName, Email, Phone, City) VALUES
('Amit',   'Sharma',   'amit.sharma@example.com',   '9876543210', 'Mumbai'),
('Priya',  'Verma',    'priya.verma@example.com',  '9988776655', 'Delhi'),
('Rahul',  'Patil',    'rahul.patil@example.com',  '9123456789', 'Pune'),
('Sneha',  'Iyer',     'sneha.iyer@example.com',   '9765432109', 'Chennai'),
('Karan',  'Singh',    'karan.singh@example.com',  '9090909090', 'Bangalore');

-- Question 56: Show the last 2 staff hired.
SELECT * FROM staff
ORDER BY StaffID DESC
LIMIT 2;

-- Question 57: Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)
SELECT * FROM rooms
WHERE PricePerNight > (
    SELECT MAX(PricePerNight) FROM rooms
    WHERE Capacity = 2
);

-- Question 58: The HR team wants to see staff whose Role is not 'Chef' for role reallocation.
SELECT * FROM staff
WHERE Role != 'Chef';

-- Question 59: Show all unique cities in descending order from the Customers table.
SELECT DISTINCT City 
FROM customers
ORDER BY City DESC;

-- Question 60: Display the phone number of the Waiter only.
SELECT Phone FROM staff
WHERE Role = 'Waiter';

-- Question 61: Display the last 2 bookings in the table.
SELECT * FROM bookings
ORDER BY BookingID DESC
LIMIT 2;

-- Question 62: The marketing team wants to see customers living in Delhi or Chennai for targeted promotions.
SELECT * FROM customers
WHERE City IN ('Delhi','Chennai');

-- Question 63: Show all rooms where RoomType != 'Family' to plan renovations.
SELECT * FROM rooms
WHERE RoomType != 'Family';

-- Question 64: List staff emails ordered by their roles.
SELECT Email FROM staff
ORDER BY Role;

-- Question 65: Display all unique payment methods.
SELECT DISTINCT PaymentMethod FROM Payments;

-- Question 66: The receptionist wants a list of customers whose Phone starts with '98' for mobile offers.
SELECT * FROM customers
WHERE Phone LIKE '98%';

-- Question 67: Show the 3 cheapest rooms available for budget travelers.
SELECT * FROM rooms
ORDER BY PricePerNight ASC
LIMIT 3;

-- Question 68: Display the last 2 payments.
SELECT * FROM payments
ORDER BY PaymentID DESC
LIMIT 2;

-- Question 69: Management wants to know which unique cities customers come from.
SELECT DISTINCT City FROM customers;

-- Question 70: List all bookings where TotalAmount > 5000.
SELECT * FROM bookings
WHERE TotalAmount > 5000;

-- Question 71: Display each staff’s Role with their Email in one column.
SELECT CONCAT_WS(" - ", Role,Email) AS RoleAndEmail 
FROM staff;

-- Question 72: Show the first 4 staff full names.
SELECT CustomerID, CONCAT(FirstName,' ', LastName) AS FullName FROM customers
LIMIT 4;

-- Question 73: Find bookings where TotalAmount is greater than all bookings made by CustomerID = 10. (Bookings subquery)
SELECT SUM(TotalAmount) FROM bookings
WHERE CustomerID = 10;
SELECT * FROM bookings
WHERE TotalAmount > (SELECT SUM(TotalAmount) FROM bookings
WHERE CustomerID = 10);

-- Question 74: List rooms with capacity >= 3 for family bookings.
SELECT * FROM rooms
WHERE Capacity >=3 AND RoomType = 'Family';

-- Question 75: Display the RoomType and Price of only Suite rooms.
SELECT RoomType, PricePerNight FROM rooms
WHERE RoomType = 'Suite';

-- Question 76: The cashier wants to see payments with Amount between ₹2000 and ₹7000 for mid-range billing checks.
SELECT * FROM payments
WHERE Amount BETWEEN 2000 AND 7000;

-- Question 77: Insert 5 booking records into the Bookings table with all details.
INSERT INTO bookings (CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount) VALUES
(1, 1, 1, '2025-09-21', '2025-09-23', 4000),
(2, 2, 2, '2025-09-25', '2025-09-28', 10500),
(3, 3, 3, '2025-10-01', '2025-10-05', 20000),
(4, 4, 4, '2025-10-02', '2025-10-03', 7000),
(5, 1, 5, '2025-10-10', '2025-10-12', 12000);

-- Question 78: Display the 3 lowest payments made by customers.
SELECT * FROM payments
ORDER BY Amount ASC
LIMIT 3;

-- Question 79: Show each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(BookingID,' - ',TotalAmount) AS BookingIDWithTotalAmount FROM bookings;

-- Question 80: Show all unique RoomIDs in descending order.
SELECT DISTINCT RoomID FROM rooms
ORDER BY RoomID DESC;

-- Question 81: Display each room’s RoomType and Price using CONCAT_WS.
SELECT CONCAT_WS('-', RoomType, PricePerNight) As RoomAndPrice 
From rooms;

-- Question 82: The admin wants to delete all bookings handled by StaffID = 3.
SET SQL_SAFE_UPDATES = 0;

-- Step 1: Delete payments linked to bookings of StaffID = 3
DELETE FROM payments
WHERE BookingID IN (SELECT BookingID FROM bookings WHERE StaffID = 3);

-- Step 2: Delete bookings handled by StaffID = 3
DELETE FROM bookings
WHERE StaffID = 3;

-- Question 83: Show customers whose FirstName length > 5 characters for a name-pattern study.
SELECT * FROM customers
WHERE LENGTH(FirstName) > 5;

-- Question 84: Show all unique roles available in the hotel.
SELECT DISTINCT Role FROM staff;

-- Question 85: List all rooms where capacity is greater than 2.
SELECT * FROM rooms
WHERE Capacity > 2;

-- Question 86: Display each payment’s ID with Amount using CONCAT.
SELECT CONCAT(PaymentID,' - ', Amount) FROM payments;

-- Question 87: List all Card payments from the Payments table.
SELECT * FROM payments
WHERE PaymentMethod = 'Card';

-- Question 88: Delete all customers whose Email ends with '@test.com' as invalid.
DELETE FROM customers
WHERE Email LIKE '%@test.com';

-- Question 89: The hotel manager wants to review bookings where CheckOutDate before '2023-12-31' to measure old occupancy.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM bookings
WHERE CheckOutDate < '2023-12-31';

-- Question 90: The front office manager needs to list rooms with capacity = 2 for couples.
SELECT * FROM rooms
WHERE Capacity = 2 AND RoomType = 'Couple';

-- Question 91: Show all unique capacities in descending order.
SELECT * FROM Rooms
ORDER BY Capacity DESC;

-- Question 92: The operations team wants to find the minimum TotalAmount in bookings.
SELECT MIN(TotalAmount) AS MinAmount FROM bookings;

-- Question 93: Display all rooms by capacity in ascending order.
SELECT * FROM rooms
ORDER BY Capacity ASC;

-- Question 94: Show each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(BookingID, ' - ', TotalAmount) FROM Bookings;

-- Question 95: The operations head wants to see rooms with Capacity = 4 AND PricePerNight > ₹6000 for premium family packages.
SELECT * FROM rooms
WHERE Capacity = 4 AND PricePerNight > 6000;

-- Question 96: Show staff full names combined into one column.
SELECT CONCAT(FirstName, ' ' , LastName) AS FirstName FROM staff;

-- Question 97: The accounts team wants to see bookings where the TotalAmount is greater than ₹10,000 to track high-value customers.
SELECT * FROM Bookings
WHERE TotalAmount > 10000;

-- Question 98: Show all unique payment methods in descending order.
SELECT PaymentMethod FROM payments
ORDER BY PaymentMethod DESC;

-- Question 99: List staff members who share the same Role. (Staff self join)
SELECT s1.StaffID, s1.FirstName, s1.LastName, s1.Role, s2.StaffID, s2.Role FROM staff s1
JOIN staff s2
ON s1.StaffID = s2.StaffID
   AND s1.Role = s2.Role;

-- Question 100: Show customer first name, last name, and TotalAmount of their bookings using JOIN between Customers and Bookings.
SELECT c.FirstName, c.LastName, b.TotalAmount FROM customers c
JOIN bookings b 
ON c.CustomerID = b.CustomerID;

-- Question 101: Display the first 4 bookings only.
SELECT * FROM bookings
LIMIT 4;

-- Question 102: Show all unique staff first names.
SELECT DISTINCT FirstName FROM Staff;

-- Question 103: Insert 5 new room records with type, price, and capacity into the Rooms table.
INSERT INTO Rooms (RoomType, PricePerNight, Capacity)
VALUES
('Deluxe', 5500, 2),
('Suite', 7500, 3),
('Family', 4200, 4),
('Standard', 3000, 2),
('Luxury', 9000, 5);

-- Question 104: Display each customer’s full name and city using CONCAT_WS.
SELECT CONCAT_WS(' - ', FirstName,LastName, City) FROM customers; 

-- Question 105: Show all unique cities in descending order from the Customers table.
SELECT DISTINCT city FROM customers
ORDER BY City DESC;

-- Question 106: The analytics team wants to list all cities where maximum CustomerID is more than 100.
SELECT City,  MAX(CustomerID) AS MaxCusID FROM customers
GROUP BY City
HAVING MAX(CustomerID) > 100;

-- Question 107: The HR team wants to see staff whose FirstName is 'Priya' for employee recognition.
SELECT * FROM staff
WHERE FirstName = 'Priya';

-- Question 108: Display the last 2 staff members from the Staff table.
SELECT * FROM staff
ORDER BY StaffID DESC
LIMIT 2;

-- Question 109: Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID, and TotalAmount.
CREATE VIEW BookingSummary AS
	SELECT
		BookingID, 
		CustomerID, 
		RoomID,
		TotalAmount
	FROM  Bookings;

-- Question 110: Show all unique RoomIDs in descending order.
SELECT RoomID FROM rooms
ORDER BY RoomId DESC;

-- Question 111: Display each staff’s role with their full name.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Role FROM staff;

-- Question 112: The receptionist wants to offer Suite rooms under ₹7000 to business travelers.
SELECT * FROM rooms
WHERE RoomType = 'Suite' AND PricePerNight = 7000;

-- Question 113: Display the first 3 staff alphabetically by their first names.
SELECT * FROM staff
ORDER BY FirstName
LIMIT 3;

-- Question 114: List all bookings ordered by CheckInDate.
SELECT * FROM bookings
ORDER BY CheckInDate;

-- Question 115: Show all unique StaffIDs from the bookings.
SELECT DISTINCT StaffID FROM staff;

-- Question 116: Display the first 4 customers’ full names only.
SELECT CONCAT(FirstName,' ' , LastName) AS FullName FROM customers
LIMIT 4;

-- Question 117: Show all unique room types offered by the hotel.
SELECT DISTINCT RoomType FROM rooms;

-- Question 118: Display the phone number of the Waiter only.
SELECT Role, phone FROM staff
WHERE Role = 'Waiter';

-- Question 119: Show all bookings where TotalAmount > 5000.
SELECT * FROM bookings
WHERE TotalAmount > 5000;

-- Question 120: The HR team wants to update Role = 'Senior Manager' where StaffID = 12.
UPDATE staff
SET Role = 'Senior Manager'
WHERE StaffID = 12;

-- Question 121: List all staff working as Managers.
SELECT * FROM staff
WHERE Role = 'Manager';

-- Question 122: Show the last 2 registered customers for follow-up.
SELECT * FROM customers
ORDER BY CustomerID DESC
LIMIT 2;

-- Question 123: Display each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT_WS(' - ', BookingID, TotalAmount) AS BookingWithAmount FROM bookings;

-- Question 124: Insert 5 staff members into the Staff table with their role, phone, and email.
INSERT INTO Staff (FirstName, LastName, Role, Phone, Email)
VALUES
('Amit', 'Sharma', 'Manager', '9876543210', 'amit.sharma@hotel.com'),
('Priya', 'Verma', 'Receptionist', '9123456780', 'priya.verma@hotel.com'),
('Rohan', 'Patil', 'Chef', '9988776655', 'rohan.patil@hotel.com'),
('Sneha', 'Kadam', 'Housekeeping', '9765432109', 'sneha.kadam@hotel.com'),
('Vikas', 'Mehta', 'Waiter', '9098765432', 'vikas.mehta@hotel.com');

-- Question 125: Display the RoomType and Price of only Suite rooms.
SELECT RoomType, PricePerNight FROM rooms
WHERE RoomType = 'Suite';

-- Question 126: The admin wants to delete all payments linked to BookingID = 15.
DELETE FROM payments
WHERE BookingID = 15;

-- Question 127: Display all unique capacities in descending order.
SELECT DISTINCT capacity FROM rooms
ORDER BY capacity DESC;

-- Question 128: Show the first 4 rooms sorted alphabetically by RoomType.
SELECT * FROM rooms
ORDER BY RoomType 
LIMIT 4;

-- Question 129: The cashier wants a report of payments where Amount < ₹1500 for small transactions.
SELECT * FROM payments
WHERE Amount < 1500;

-- Question 130: Show each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(BookingID,' - ', TotalAmount) FROM bookings;

-- Question 131: Display the last 2 added rooms from the Rooms table.
SELECT * FROM rooms
ORDER BY RoomID DESC
LIMIT 2;

-- Question 132: List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal attention.
SELECT * FROM customers
WHERE FirstName = 'Amit' AND City = 'Nagpur';

-- Question 133: Insert 5 new customer details into the Customers table.
INSERT INTO Customers (FirstName, LastName, Email, Phone, City)
VALUES
('Rahul', 'Singh', 'rahul.singh@example.com', '9876543210', 'Mumbai'),
('Sneha', 'Patil', 'sneha.patil@example.com', '9123456789', 'Pune'),
('Amit', 'Verma', 'amit.verma@example.com', '9988776655', 'Delhi'),
('Priya', 'Sharma', 'priya.sharma@example.com', '9765432101', 'Nagpur'),
('Karan', 'Mehta', 'karan.mehta@example.com', '9098765432', 'Bangalore');

-- Question 134: Show staff full names combined into one column.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName FROM staff;

-- Question 135: Show all room details separated by commas using CONCAT_WS.
SELECT CONCAT_WS(',',RoomID,RoomType,PricePerNight,Capacity) AS RoomDetails FROM rooms;

-- Question 136: Display each customer’s name and phone number together using CONCAT.
SELECT CONCAT(FirstName, ' ' , LastName, ' - ', Phone) AS CustDetails FROM customers;

-- Question 137: Display all payment details in one line using CONCAT_WS.
SELECT CONCAT_WS(' - ',PaymentId,PaymentDate,PaymentMethod,Amount,BookingID) AS PaymentDetails FROM payments;

-- Question 138: Show the last 2 bookings in the table.
SELECT * FROM bookings
ORDER BY BookingID DESC
LIMIT 2;

-- Question 139: List all payments ordered by PaymentDate.
SELECT * FROM payments
ORDER BY PaymentDate;

-- Question 140: Show the 2 highest payments received.
SELECT PaymentID, BookingID, Amount, PaymentMethod, PaymentDate
FROM payments
ORDER BY Amount DESC
LIMIT 2;

-- Question 141: The marketing team wants to check customers whose FirstName is 'Rahul' for a loyalty program.
SELECT * FROM customers
WHERE FirstName = 'Rahul';

-- Question 142: Display each PaymentID with its method using CONCAT.
SELECT CONCAT(PaymentID,  ' ', PaymentMethod) AS PaymentWithMethod FROM payments;

-- Question 143: The operations team wants to list all PaymentMethods used more than 5 times.
SELECT PaymentMethod, COUNT(*) AS MethodCount
FROM payments
GROUP BY PaymentMethod
HAVING COUNT(*) > 5;

-- Question 144: Show the 2 most expensive rooms for VIP guests.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 2;

-- Question 145: Show each room’s RoomType and Price using CONCAT_WS.
SELECT CONCAT_WS(' - ', RoomType, PricePerNight) AS RoomInfo
FROM Rooms;

-- Question 146: Display the first 3 staff alphabetically by their first names.
SELECT FirstName, LastName, Role, Phone, Email
FROM Staff
ORDER BY FirstName ASC
LIMIT 3;

-- Question 147: List all bookings handled by StaffID = 2.
SELECT BookingID, CustomerID, RoomID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE StaffID = 2;

-- Question 148: The analytics team wants to find the city where average CustomerID is greater than 50.
SELECT City, AVG(CustomerID) AS AvgCustomerID
FROM Customers
GROUP BY City
HAVING AVG(CustomerID) > 50;

-- Question 149: The hotel wants to display the 2 most expensive rooms for VIP guests.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
ORDER BY PricePerNight DESC
LIMIT 2;

-- Question 150: Show all unique first names of customers for a duplicate check.
SELECT DISTINCT FirstName
FROM Customers;

-- Question 151: Show all unique roles in descending order.SELECT DISTINCT Role
SELECT DISTINCT Role
FROM Staff
ORDER BY Role DESC;

-- Question 152: Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery)
SELECT * FROM Rooms
WHERE Capacity > (SELECT AVG(Capacity) FROM Rooms);

-- Question 153: Display all rooms by capacity in ascending order.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
ORDER BY Capacity ASC;

-- Question 154: Display the first 4 payments only.
SELECT PaymentID, BookingID, Amount, PaymentMethod, PaymentDate
FROM Payments
LIMIT 4;

-- Question 155: Show each payment’s ID, Method, Amount in one line.
SELECT CONCAT(PaymentID, ' - ', PaymentMethod, ' - ', Amount) AS PaymentInfo
FROM Payments;

-- Question 156: List all bookings where TotalAmount > 5000.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > 5000;

-- Question 157: Find all customers whose CustomerID is greater than the average CustomerID. (Customers subquery)
SELECT CustomerID, FirstName, LastName, Email, Phone, City
FROM Customers
WHERE CustomerID > (SELECT AVG(CustomerID) FROM Customers);

-- Question 158: The HR manager wants to see staff whose Role is not 'Chef' for role reallocation.
SELECT StaffID, FirstName, LastName, Role, Phone, Email
FROM Staff
WHERE Role <> 'Chef';

-- Question 159: The accounts team wants to check bookings where TotalAmount is greater than ₹10,000.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > 10000;

-- Question 160: Display each staff’s role with their full name.
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Role
FROM Staff;

-- Question 161: List staff members who share the same Role. (Staff self join)
SELECT s1.StaffID, s1.FirstName, s1.LastName, s1.Role, s1.Phone, s1.Email, s2.StaffID, s2.Role 
FROM staff s1
JOIN staff s2
ON s1.StaffID = s2.StaffID
   AND s1.Role = s2.Role;

-- Question 162: Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments.
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS FullName, 
    p.Amount AS PaymentAmount
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
JOIN Payments p ON p.BookingID = b.BookingID;

-- Question 163: Display all bookings where TotalAmount > 5000.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > 5000;

-- Question 164: The front desk wants to see customers whose Phone starts with '98'.
SELECT CustomerID, FirstName, LastName, Phone, Email, City
FROM Customers
WHERE Phone LIKE '98%';

-- Question 165: Identify customers who live in the same city. (Customers self join)
SELECT c1.CustomerID AS Customer1, c1.FirstName AS FirstName1, 
       c2.CustomerID AS Customer2, c2.FirstName AS FirstName2, 
       c1.City
FROM Customers c1
JOIN Customers c2 ON c1.City = c2.City AND c1.CustomerID < c2.CustomerID;

-- Question 166: The operations manager wants to check bookings with CheckOutDate before '2023-12-31'.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE CheckOutDate < '2023-12-31';

-- Question 167: Display all unique StaffIDs from the bookings.
SELECT DISTINCT StaffID
FROM Bookings;

-- Question 168: Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'.
CREATE VIEW OnlinePayments AS
SELECT * FROM payments
WHERE PaymentMethod = 'Online';

-- Question 169: Display all unique payment methods in descending order.
SELECT DISTINCT PaymentMethod
FROM Payments
ORDER BY PaymentMethod DESC;

-- Question 170: Display each payment’s ID with Amount using CONCAT.
SELECT CONCAT(PaymentID, ' - ', Amount) AS PaymentInfo
FROM Payments;

-- Question 171: Show all unique RoomIDs in descending order.
SELECT DISTINCT RoomID
FROM Rooms
ORDER BY RoomID DESC;

-- Question 172: The analytics team wants to list all cities where maximum CustomerID is more than 100.
SELECT City
FROM Customers
GROUP BY City
HAVING MAX(CustomerID) > 100;

-- Question 173: List staff emails ordered by their roles.
SELECT Email, Role
FROM Staff
ORDER BY Role ASC;

-- Question 174: Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > (SELECT AVG(TotalAmount) FROM Bookings);

-- Question 175: Show all rooms where PricePerNight > ₹5000 for premium customer recommendations.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
WHERE PricePerNight > 5000;

-- Question 176: Show all unique capacities in descending order.
SELECT DISTINCT Capacity
FROM Rooms
ORDER BY Capacity DESC;

-- Question 177: Display the first 4 rooms sorted alphabetically by RoomType.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
ORDER BY RoomType ASC
LIMIT 4;

-- Question 178: Show all unique staff first names.
SELECT DISTINCT FirstName
FROM Staff;

-- Question 179: Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
WHERE PricePerNight > (SELECT MAX(PricePerNight) FROM Rooms WHERE Capacity = 2);

-- Question 180: Show all unique cities in descending order from the Customers table.
SELECT DISTINCT City
FROM Customers
ORDER BY City DESC;

-- Q181: List all bookings where TotalAmount > 5000.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > 5000;

-- Q182: Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
SELECT p.PaymentID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, p.BookingID
FROM Payments p
JOIN Bookings b ON p.BookingID = b.BookingID
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE p.PaymentMethod = 'Credit Card';

-- Q183: Display each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(BookingID, ' - ', TotalAmount) AS BookingInfo
FROM Bookings;

-- Q184: Show all bookings handled by StaffID = 2.
SELECT BookingID, CustomerID, RoomID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE StaffID = 2;

-- Q185: Display the last 2 added rooms from the Rooms table.
SELECT *
FROM Rooms
ORDER BY RoomID DESC
LIMIT 2;

-- Q186: List all rooms where capacity is greater than 2.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
WHERE Capacity > 2;

-- Q187: Display the last 2 staff members from the Staff table.
SELECT *
FROM Staff
ORDER BY StaffID DESC
LIMIT 2;

-- Q188: Show all unique roles available in the hotel.
SELECT DISTINCT Role
FROM Staff;

-- Q189: Display the last 2 payments.
SELECT *
FROM Payments
ORDER BY PaymentID DESC
LIMIT 2;

-- Q190: The manager wants to see bookings where CustomerID IN (2,4,6,8) to track repeat guests.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE CustomerID IN (2,4,6,8);

-- Q191: Show all unique first names of customers for a duplicate check.
SELECT DISTINCT FirstName
FROM Customers;

-- Q192: Display all bookings where TotalAmount > 5000.
SELECT BookingID, CustomerID, RoomID, StaffID, CheckInDate, CheckOutDate, TotalAmount
FROM Bookings
WHERE TotalAmount > 5000;

-- Q193: The admin wants to delete all payments where Amount < 1000.
DELETE FROM Payments
WHERE Amount < 1000;

-- Q194: Display all unique RoomIDs in descending order.
SELECT DISTINCT RoomID
FROM Rooms
ORDER BY RoomID DESC;

-- Q195: List customers who made more than 5 bookings.
SELECT CustomerID, COUNT(*) AS TotalBookings
FROM Bookings
GROUP BY CustomerID
HAVING COUNT(*) > 5;

-- Q196: Display all rooms by capacity in ascending order.
SELECT RoomID, RoomType, PricePerNight, Capacity
FROM Rooms
ORDER BY Capacity ASC;

-- Q197: Show each booking’s BookingID with TotalAmount using CONCAT.
SELECT CONCAT(BookingID, ' - ', TotalAmount) AS BookingInfo
FROM Bookings;

-- Q198: List all staff working as Managers.
SELECT StaffID, FirstName, LastName, Role, Phone, Email
FROM Staff
WHERE Role = 'Manager';

-- Q199: Show customers whose FirstName length > 5 characters for a name-pattern study.
SELECT * FROM customers
WHERE LENGTH(FirstName) > 5;

-- Q200: Display all unique capacities in descending order.

-- Q201: List staff members who share the same Role. (Staff self join)
SELECT s1.StaffID AS Staff1_ID, s1.FirstName AS Staff1_Name,
       s2.StaffID AS Staff2_ID, s2.FirstName AS Staff2_Name,
       s1.Role
FROM Staff s1
JOIN Staff s2 ON s1.Role = s2.Role AND s1.StaffID < s2.StaffID;

-- Q202: Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.
SELECT p.PaymentID, CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, p.BookingID
FROM Payments p
JOIN Bookings b ON p.BookingID = b.BookingID
JOIN Customers c ON b.CustomerID = c.CustomerID
WHERE p.PaymentMethod = 'Credit Card';

-- Q203: Display the first 4 payments only.
SELECT PaymentID, BookingID, Amount, PaymentMethod, PaymentDate
FROM Payments
LIMIT 4;

-- Q204: Show each payment’s ID, Method, Amount in one line.
SELECT CONCAT(PaymentID, ' - ', PaymentMethod, ' - ', Amount) AS PaymentInfo
FROM Payments;

-- Q205: Create a VIEW HighValueBookings showing all bookings with TotalAmount > 20,000.
CREATE VIEW HighValueBookings AS 
SELECT * FROM bookings
WHERE TotalAmount > 20000;

-- Q206: Create a trigger to automatically delete a payment when its corresponding booking is deleted.
DELIMITER //

CREATE TRIGGER trg_DeletePaymentAfterBooking
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    DELETE FROM Payments
    WHERE BookingID = OLD.BookingID;
END;
//

DELIMITER ;

-- Q207: Create a trigger to prevent insertion of a booking where CheckOutDate < CheckInDate.

DELIMITER //

CREATE TRIGGER trg_PreventInvalidBooking
BEFORE INSERT ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.CheckOutDate < NEW.CheckInDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CheckOutDate cannot be before CheckInDate';
    END IF;
END;
//

DELIMITER ;

-- Q208: Create a trigger to automatically update TotalAmount in Bookings when a payment is inserted in Payments.
DELIMITER //

CREATE TRIGGER trg_UpdateTotalAmountAfterPayment
AFTER INSERT ON Payments
FOR EACH ROW
BEGIN
    UPDATE Bookings
    SET TotalAmount = TotalAmount + NEW.Amount
    WHERE BookingID = NEW.BookingID;
END;
//

DELIMITER ;

