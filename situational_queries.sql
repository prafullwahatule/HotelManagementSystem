-- ==============================================================
-- Project : Hotel Management System
-- File    : situational_queries.sql
-- Purpose : Situational SQL Queries (Questions Only)
-- ==============================================================

-- Question 1: The accounts team wants to check payments made via UPI to measure digital adoption.

-- Question 2: List all unique first names of customers for a duplicate check.

-- Question 3: Delete all rooms with Capacity = 1.

-- Question 4: Display each customer’s name and phone number together using CONCAT.

-- Question 5: The booking office wants to see bookings where RoomID = 10 to check utilization of a specific room.

-- Question 6: Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery)

-- Question 7: Create a VIEW StaffContact showing Staff FirstName, LastName, Role, and Phone.

-- Question 8: The receptionist wants to offer Suite rooms under ₹7000 to business travelers.

-- Question 9: The admin wants to see email addresses sorted by LastName from the Customers table.

-- Question 10: Show staff full names combined into one column.

-- Question 11: Display all payment details in one line using CONCAT_WS.

-- Question 12: The hotel wants to display the 2 most expensive rooms for VIP guests.

-- Question 13: Show each BookingID with its CheckIn and CheckOut dates combined.

-- Question 14: Finance wants to calculate the average Amount per PaymentMethod.

-- Question 15: The analytics team wants to find the city where average CustomerID is greater than 50.

-- Question 16: Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)

-- Question 17: Display the last 2 added rooms from the Rooms table.

-- Question 18: The cashier wants a report of payments where Amount < ₹1500 for small transactions.

-- Question 19: Management wants to list all customers who have made more than 5 bookings.

-- Question 20: Identify customers who live in the same city. (Customers self join)

-- Question 21: Show the total revenue handled by each StaffID.

-- Question 22: The manager wants to see all customers from Mumbai to check city-wise marketing campaigns.

-- Question 23: Display the 3 lowest booking amounts.

-- Question 24: Insert 5 new room records with type, price, and capacity into the Rooms table.

-- Question 25: Show all unique CustomerIDs from bookings.

-- Question 26: Create a trigger to automatically delete a payment when its corresponding booking is deleted.

-- Question 27: The marketing team wants to update the FirstName of CustomerID = 30 to 'Rahul'.

-- Question 28: List all bookings ordered by CheckInDate.

-- Question 29: Show all rooms where capacity is greater than 2.

-- Question 30: List staff emails ordered by their roles.

-- Question 31: Display each customer’s full name and city using CONCAT_WS.

-- Question 32: Show the first 4 customers’ full names only.

-- Question 33: Show each staff’s role with their full name.

-- Question 34: Management wants to find the average StaffID per role.

-- Question 35: List all bookings handled by StaffID = 2.

-- Question 36: Display the first 3 staff alphabetically by their first names.

-- Question 37: The front desk manager wants to see customers where FirstName = 'Amit' AND City = 'Nagpur' for personal attention.

-- Question 38: Show all unique payment methods in descending order.

-- Question 39: Insert 5 staff members into the Staff table with their role, phone, and email.

-- Question 40: The hotel manager wants to review bookings where CheckInDate is after '2024-01-01' to analyze recent occupancy.

-- Question 41: List all customers whose FirstName is 'Rahul' for a loyalty program.

-- Question 42: Show all unique room types offered by the hotel.

-- Question 43: Identify customers who spent more than 50,000 in total.

-- Question 44: Delete all customers from the city 'TestCity'.

-- Question 45: Find rooms that have the same PricePerNight. (Rooms self join)

-- Question 46: The manager wants to see staff whose Email ends with '@tcs.in' for corporate tie-ups.

-- Question 47: The analytics team wants to list all cities where maximum CustomerID is more than 100.

-- Question 48: Show all unique capacities in descending order.

-- Question 49: List staff working as Managers.

-- Question 50: Display each payment’s ID, Method, Amount in one line.

-- Question 51: Show the first 4 payments only.

-- Question 52: The hotel manager wants to review rooms where PricePerNight is between ₹2000 and ₹4000 to offer discounts.

-- Question 53: List all bookings ordered by CheckInDate.

-- Question 54: Display all unique CustomerIDs from bookings.

-- Question 55: The hotel manager wants to add new customer details. Insert 5 records with full details into the Customers table.

-- Question 56: Show the last 2 staff hired.

-- Question 57: Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)

-- Question 58: The HR team wants to see staff whose Role is not 'Chef' for role reallocation.

-- Question 59: Show all unique cities in descending order from the Customers table.

-- Question 60: Display the phone number of the Waiter only.

-- Question 61: Display the last 2 bookings in the table.

-- Question 62: The marketing team wants to see customers living in Delhi or Chennai for targeted promotions.

-- Question 63: Show all rooms where RoomType != 'Family' to plan renovations.

-- Question 64: List staff emails ordered by their roles.

-- Question 65: Display all unique payment methods.

-- Question 66: The receptionist wants a list of customers whose Phone starts with '98' for mobile offers.

-- Question 67: Show the 3 cheapest rooms available for budget travelers.

-- Question 68: Display the last 2 payments.

-- Question 69: Management wants to know which unique cities customers come from.

-- Question 70: List all bookings where TotalAmount > 5000.

-- Question 71: Display each staff’s Role with their Email in one column.

-- Question 72: Show the first 4 staff full names.

-- Question 73: Find bookings where TotalAmount is greater than all bookings made by CustomerID = 10. (Bookings subquery)

-- Question 74: List rooms with capacity >= 3 for family bookings.

-- Question 75: Display the RoomType and Price of only Suite rooms.

-- Question 76: The cashier wants to see payments with Amount between ₹2000 and ₹7000 for mid-range billing checks.

-- Question 77: Insert 5 booking records into the Bookings table with all details.

-- Question 78: Display the 3 lowest payments made by customers.

-- Question 79: Show each booking’s BookingID with TotalAmount using CONCAT.

-- Question 80: Show all unique RoomIDs in descending order.

-- Question 81: Display each room’s RoomType and Price using CONCAT_WS.

-- Question 82: The admin wants to delete all bookings handled by StaffID = 3.

-- Question 83: Show customers whose FirstName length > 5 characters for a name-pattern study.

-- Question 84: Show all unique roles available in the hotel.

-- Question 85: List all rooms where capacity is greater than 2.

-- Question 86: Display each payment’s ID with Amount using CONCAT.

-- Question 87: List all Card payments from the Payments table.

-- Question 88: Delete all customers whose Email ends with '@test.com' as invalid.

-- Question 89: The hotel manager wants to review bookings where CheckOutDate before '2023-12-31' to measure old occupancy.

-- Question 90: The front office manager needs to list rooms with capacity = 2 for couples.

-- Question 91: Show all unique capacities in descending order.

-- Question 92: The operations team wants to find the minimum TotalAmount in bookings.

-- Question 93: Display all rooms by capacity in ascending order.

-- Question 94: Show each booking’s BookingID with TotalAmount using CONCAT.

-- Question 95: The operations head wants to see rooms with Capacity = 4 AND PricePerNight > ₹6000 for premium family packages.

-- Question 96: Show staff full names combined into one column.

-- Question 97: The accounts team wants to see bookings where the TotalAmount is greater than ₹10,000 to track high-value customers.

-- Question 98: Show all unique payment methods in descending order.

-- Question 99: List staff members who share the same Role. (Staff self join)

-- Question 100: Show customer first name, last name, and TotalAmount of their bookings using JOIN between Customers and Bookings.

-- Question 101: Display the first 4 bookings only.

-- Question 102: Show all unique staff first names.

-- Question 103: Insert 5 new room records with type, price, and capacity into the Rooms table.

-- Question 104: Display each customer’s full name and city using CONCAT_WS.

-- Question 105: Show all unique cities in descending order from the Customers table.

-- Question 106: The analytics team wants to list all cities where maximum CustomerID is more than 100.

-- Question 107: The HR team wants to see staff whose FirstName is 'Priya' for employee recognition.

-- Question 108: Display the last 2 staff members from the Staff table.

-- Question 109: Create a VIEW BookingSummary showing BookingID, CustomerID, RoomID, and TotalAmount.

-- Question 110: Show all unique RoomIDs in descending order.

-- Question 111: Display each staff’s role with their full name.

-- Question 112: The receptionist wants to offer Suite rooms under ₹7000 to business travelers.

-- Question 113: Display the first 3 staff alphabetically by their first names.

-- Question 114: List all bookings ordered by CheckInDate.

-- Question 115: Show all unique StaffIDs from the bookings.

-- Question 116: Display the first 4 customers’ full names only.

-- Question 117: Show all unique room types offered by the hotel.

-- Question 118: Display the phone number of the Waiter only.

-- Question 119: Show all bookings where TotalAmount > 5000.

-- Question 120: The HR team wants to update Role = 'Senior Manager' where StaffID = 12.

-- Question 121: List all staff working as Managers.

-- Question 122: Show the last 2 registered customers for follow-up.

-- Question 123: Display each booking’s BookingID with TotalAmount using CONCAT.

-- Question 124: Insert 5 staff members into the Staff table with their role, phone, and email.

-- Question 125: Display the RoomType and Price of only Suite rooms.

-- Question 126: The admin wants to delete all payments linked to BookingID = 15.

-- Question 127: Display all unique capacities in descending order.

-- Question 128: Show the first 4 rooms sorted alphabetically by RoomType.

-- Question 129: The cashier wants a report of payments where Amount < ₹1500 for small transactions.

-- Question 130: Show each booking’s BookingID with TotalAmount using CONCAT.

-- Question 131: Display the last 2 added rooms from the Rooms table.

-- Question 132: List all customers whose FirstName = 'Amit' AND City = 'Nagpur' for personal attention.

-- Question 133: Insert 5 new customer details into the Customers table.

-- Question 134: Show staff full names combined into one column.

-- Question 135: Show all room details separated by commas using CONCAT_WS.

-- Question 136: Display each customer’s name and phone number together using CONCAT.

-- Question 137: Display all payment details in one line using CONCAT_WS.

-- Question 138: Show the last 2 bookings in the table.

-- Question 139: List all payments ordered by PaymentDate.

-- Question 140: Show the 2 highest payments received.

-- Question 141: The marketing team wants to check customers whose FirstName is 'Rahul' for a loyalty program.

-- Question 142: Display each PaymentID with its method using CONCAT.

-- Question 143: The operations team wants to list all PaymentMethods used more than 5 times.

-- Question 144: Show the 2 most expensive rooms for VIP guests.

-- Question 145: Show each room’s RoomType and Price using CONCAT_WS.

-- Question 146: Display the first 3 staff alphabetically by their first names.

-- Question 147: List all bookings handled by StaffID = 2.

-- Question 148: The analytics team wants to find the city where average CustomerID is greater than 50.

-- Question 149: The hotel wants to display the 2 most expensive rooms for VIP guests.

-- Question 150: Show all unique first names of customers for a duplicate check.

-- Question 151: Show all unique roles in descending order.

-- Question 152: Identify rooms whose Capacity is greater than the average Capacity of all rooms. (Rooms subquery)

-- Question 153: Display all rooms by capacity in ascending order.

-- Question 154: Display the first 4 payments only.

-- Question 155: Show each payment’s ID, Method, Amount in one line.

-- Question 156: List all bookings where TotalAmount > 5000.

-- Question 157: Find all customers whose CustomerID is greater than the average CustomerID. (Customers subquery)

-- Question 158: The HR manager wants to see staff whose Role is not 'Chef' for role reallocation.

-- Question 159: The accounts team wants to check bookings where TotalAmount is greater than ₹10,000.

-- Question 160: Display each staff’s role with their full name.

-- Question 161: List staff members who share the same Role. (Staff self join)

-- Question 162: Show Customer Name and Payment Amount by joining Customers, Bookings, and Payments.

-- Question 163: Display all bookings where TotalAmount > 5000.

-- Question 164: The front desk wants to see customers whose Phone starts with '98'.

-- Question 165: Identify customers who live in the same city. (Customers self join)

-- Question 166: The operations manager wants to check bookings with CheckOutDate before '2023-12-31'.

-- Question 167: Display all unique StaffIDs from the bookings.

-- Question 168: Create a VIEW OnlinePayments showing all payments made by PaymentMethod = 'Online'.

-- Question 169: Display all unique payment methods in descending order.

-- Question 170: Display each payment’s ID with Amount using CONCAT.

-- Question 171: Show all unique RoomIDs in descending order.

-- Question 172: The analytics team wants to list all cities where maximum CustomerID is more than 100.

-- Question 173: List staff emails ordered by their roles.

-- Question 174: Find bookings where TotalAmount exceeds the average TotalAmount. (Bookings subquery)

-- Question 175: Show all rooms where PricePerNight > ₹5000 for premium customer recommendations.

-- Question 176: Show all unique capacities in descending order.

-- Question 177: Display the first 4 rooms sorted alphabetically by RoomType.

-- Question 178: Show all unique staff first names.

-- Question 179: Identify rooms with PricePerNight higher than the maximum PricePerNight of rooms with Capacity = 2. (Rooms subquery)

-- Question 180: Show all unique cities in descending order from the Customers table.

-- Q181: List all bookings where TotalAmount > 5000.

-- Q182: Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.

-- Q183: Display each booking’s BookingID with TotalAmount using CONCAT.

-- Q184: Show all bookings handled by StaffID = 2.

-- Q185: Display the last 2 added rooms from the Rooms table.

-- Q186: List all rooms where capacity is greater than 2.

-- Q187: Display the last 2 staff members from the Staff table.

-- Q188: Show all unique roles available in the hotel.

-- Q189: Display the last 2 payments.

-- Q190: The manager wants to see bookings where CustomerID IN (2,4,6,8) to track repeat guests.

-- Q191: Show all unique first names of customers for a duplicate check.

-- Q192: Display all bookings where TotalAmount > 5000.

-- Q193: The admin wants to delete all payments where Amount < 1000.

-- Q194: Display all unique RoomIDs in descending order.

-- Q195: List customers who made more than 5 bookings.

-- Q196: Display all rooms by capacity in ascending order.

-- Q197: Show each booking’s BookingID with TotalAmount using CONCAT.

-- Q198: List all staff working as Managers.

-- Q199: Show customers whose FirstName length > 5 characters for a name-pattern study.

-- Q200: Display all unique capacities in descending order.

-- Q201: List staff members who share the same Role. (Staff self join)

-- Q202: Show PaymentID, Customer Name, and BookingID for payments made using 'Credit Card'.

-- Q203: Display the first 4 payments only.

-- Q204: Show each payment’s ID, Method, Amount in one line.

-- Q205: Create a VIEW HighValueBookings showing all bookings with TotalAmount > 20,000.

-- Q206: Create a trigger to automatically delete a payment when its corresponding booking is deleted.

-- Q207: Create a trigger to prevent insertion of a booking where CheckOutDate < CheckInDate.

-- Q208: Create a trigger to automatically update TotalAmount in Bookings when a payment is inserted in Payments.

