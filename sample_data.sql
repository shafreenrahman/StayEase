USE stayease;

INSERT INTO guests VALUES
(1,'Arya','9876543210','arya@gmail.com','Aadhaar'),
(2,'Rahul','9123456789','rahul@gmail.com','PAN'),
(3,'Priya','9988776655','priya@gmail.com','Passport'),
(4,'Ananya','9012345678','ananya@gmail.com','Aadhaar'),
(5,'Kiran','9345678901','kiran@gmail.com','Driving License');

INSERT INTO room_types VALUES
(1,'Standard',2,2000.00),
(2,'Deluxe',3,3500.00),
(3,'Suite',4,6000.00);

INSERT INTO rooms VALUES
(101,'101',1,'Available',1),
(102,'102',1,'Occupied',1),
(201,'201',2,'Occupied',2),
(202,'202',2,'Available',2),
(301,'301',3,'Maintenance',3);

INSERT INTO services VALUES
(1,'Laundry',300.00),
(2,'Restaurant',800.00),
(3,'Spa',1200.00),
(4,'Room Service',500.00);

INSERT INTO employees VALUES
(1,'Ravi','Housekeeping','9876500001'),
(2,'Neha','Receptionist','9876500002'),
(3,'Suresh','Manager','9876500003'),
(4,'Divya','Housekeeping','9876500004');

INSERT INTO reservations VALUES
(1,1,102,'2026-10-01','2026-10-03','Completed',NULL),
(2,2,201,'2026-10-05','2026-10-08','Checked In',NULL),
(3,3,101,'2026-10-10','2026-10-12','Booked',NULL),
(4,4,202,'2026-10-15','2026-10-18','Cancelled','2026-10-13'),
(5,5,301,'2026-10-20','2026-10-23','Booked',NULL);

INSERT INTO service_usage VALUES
(1,1,1,2,'2026-10-02'),
(2,1,2,1,'2026-10-02'),
(3,2,3,1,'2026-10-06'),
(4,3,4,2,'2026-10-11');

INSERT INTO payments VALUES
(1,1,4000.00,'UPI','2026-10-01'),
(2,2,10500.00,'Card','2026-10-05'),
(3,3,2000.00,'Cash','2026-10-10');

INSERT INTO reviews VALUES
(1,1,5,'Excellent stay'),
(2,2,4,'Good service'),
(3,3,5,'Clean rooms');

INSERT INTO housekeeping VALUES
(1,101,1,'2026-10-01','Completed'),
(2,102,4,'2026-10-02','In Progress'),
(3,201,1,'2026-10-03','Completed'),
(4,301,4,'2026-10-04','Pending');
