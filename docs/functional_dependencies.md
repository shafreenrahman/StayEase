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





