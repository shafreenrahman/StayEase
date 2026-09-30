USE stayease;

INSERT INTO guests VALUES
(1, 'Aarav', '9876543210', 'aarav@gmail.com', 'Aadhaar'),
(2, 'Diya', '9876543211', 'diya@gmail.com', 'Passport'),
(3, 'Rohan', '9876543212', 'rohan@gmail.com', 'PAN'),
(4, 'Meera', '9876543213', 'meera@gmail.com', 'Aadhaar'),
(5, 'Kabir', '9876543214', 'kabir@gmail.com', 'Driving License'),
(6, 'Anika', '9876543215', 'anika@gmail.com', 'Passport'),
(7, 'Vikram', '9876543216', 'vikram@gmail.com', 'PAN'),
(8, 'Ishita', '9876543217', 'ishita@gmail.com', 'Aadhaar');


INSERT INTO room_types VALUES
(1, 'Standard', 2, 2200.00),
(2, 'Deluxe', 3, 3500.00),
(3, 'Suite', 4, 6000.00);


INSERT INTO rooms VALUES
(101, '101', 1, 'Occupied', 1),
(102, '102', 1, 'Available', 1),
(103, '103', 1, 'Occupied', 1),
(104, '104', 1, 'Available', 1),
(201, '201', 2, 'Occupied', 2),
(202, '202', 2, 'Available', 2),
(203, '203', 2, 'Occupied', 2),
(301, '301', 3, 'Maintenance', 3);


INSERT INTO services VALUES
(1, 'Laundry', 300.00),
(2, 'Restaurant', 800.00),
(3, 'Spa', 1200.00),
(4, 'Room Service', 500.00),
(5, 'Airport Pickup', 1500.00),
(6, 'Breakfast', 400.00);


INSERT INTO employees VALUES
(1, 'Ravi', 'Housekeeping', '9876500001'),
(2, 'Neha', 'Receptionist', '9876500002'),
(3, 'Suresh', 'Manager', '9876500003'),
(4, 'Divya', 'Housekeeping', '9876500004'),
(5, 'Arjun', 'Housekeeping', '9876500005'),
(6, 'Pooja', 'Receptionist', '9876500006');


INSERT INTO reservations VALUES
(1, 1, 101, '2026-10-01', '2026-10-04', 'Completed', NULL),
(2, 2, 201, '2026-10-03', '2026-10-05', 'Completed', NULL),
(3, 3, 202, '2026-10-06', '2026-10-09', 'Completed', NULL),
(4, 4, 301, '2026-10-08', '2026-10-10', 'Completed', NULL),
(5, 1, 102, '2026-10-12', '2026-10-14', 'Completed', NULL),
(6, 5, 203, '2026-10-15', '2026-10-18', 'Cancelled', '2026-10-13'),
(7, 6, 203, '2026-10-18', '2026-10-21', 'Completed', NULL),
(8, 2, 103, '2026-10-22', '2026-10-26', 'Checked In', NULL),
(9, 7, 301, '2026-10-25', '2026-10-27', 'Booked', NULL),
(10, 8, 104, '2026-10-28', '2026-10-31', 'Booked', NULL);


INSERT INTO service_usage VALUES
(1, 1, 1, 2, '2026-10-02'),
(2, 1, 2, 1, '2026-10-02'),
(3, 2, 6, 2, '2026-10-04'),
(4, 3, 3, 1, '2026-10-07'),
(5, 3, 4, 2, '2026-10-08'),
(6, 4, 5, 1, '2026-10-08'),
(7, 5, 1, 3, '2026-10-13'),
(8, 7, 2, 2, '2026-10-19'),
(9, 8, 6, 2, '2026-10-23'),
(10, 9, 3, 1, '2026-10-26');


INSERT INTO payments VALUES
(1, 1, 6600.00, 'UPI', '2026-10-01'),
(2, 2, 7000.00, 'Card', '2026-10-03'),
(3, 3, 10500.00, 'UPI', '2026-10-06'),
(4, 4, 12000.00, 'Card', '2026-10-08'),
(5, 5, 4400.00, 'Cash', '2026-10-12'),
(6, 7, 10500.00, 'UPI', '2026-10-18'),
(7, 8, 8800.00, 'Card', '2026-10-22'),
(8, 9, 12000.00, 'UPI', '2026-10-25'),
(9, 10, 6600.00, 'Cash', '2026-10-28');


INSERT INTO reviews VALUES
(1, 1, 5, 'Excellent stay and clean room'),
(2, 2, 4, 'Good service and comfortable room'),
(3, 3, 5, 'Very comfortable stay'),
(4, 4, 4, 'Spacious suite and good service'),
(5, 5, 5, 'Friendly staff and clean room'),
(6, 7, 4, 'Good experience overall'),
(7, 8, 3, 'Room was good but service was slow'),
(8, 9, 5, 'Excellent suite and service');


INSERT INTO housekeeping VALUES
(1, 101, 1, '2026-10-01', 'Completed'),
(2, 102, 4, '2026-10-02', 'Completed'),
(3, 201, 1, '2026-10-03', 'Completed'),
(4, 202, 5, '2026-10-06', 'In Progress'),
(5, 203, 4, '2026-10-15', 'Pending'),
(6, 301, 5, '2026-10-20', 'Completed'),
(7, 103, 1, '2026-10-22', 'In Progress'),
(8, 104, 4, '2026-10-28', 'Pending');
