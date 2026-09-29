# Functional Dependencies

1. Guests

Relation: Guests(guest_id, name, phone, email, id_proof_type)
Primary Key: guest_id
FD: guest_id → name, phone, email, id_proof_type


2. Room Types

Relation: Room_Types(room_type_id, name, capacity, base_price)
Primary Key: room_type_id
FD: room_type_id → name, capacity, base_price


3. Rooms

Relation: Rooms(room_id, room_no, floor, status, room_type_id)
Primary Key: room_id
FD: room_id → room_no, floor, status, room_type_id


4. Reservations

Relation: Reservations(reservation_id, guest_id, room_id, check_in, check_out, status, cancellation_date)
Primary Key: reservation_id
FD: reservation_id → guest_id, room_id, check_in, check_out, status, cancellation_date


5. Services

Relation: Services(service_id, name, price)
Primary Key: service_id
FD: service_id → name, price


6. Service Usage

Relation: Service_Usage(usage_id, reservation_id, service_id, quantity, used_on)
Primary Key: usage_id
FD: usage_id → reservation_id, service_id, quantity, used_on


7. Payments

Relation: Payments(payment_id, reservation_id, amount, method, paid_on)
Primary Key: payment_id
FD: payment_id → reservation_id, amount, method, paid_on


8. Reviews

Relation: Reviews(review_id, reservation_id, rating, comment)
Primary Key: review_id
FD: review_id → reservation_id, rating, comment


9. Employees

Relation: Employees(employee_id, name, role, phone)
Primary Key: employee_id
FD: employee_id → name, role, phone


10. Housekeeping

Relation: Housekeeping(task_id, room_id, employee_id, task_date, status)
Primary Key: task_id
FD: task_id → room_id, employee_id, task_date, status





