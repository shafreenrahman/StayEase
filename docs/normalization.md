Normalization is used to organize the database and reduce unnecessary data duplication.

1. First Normal Form (1NF)

A table is in 1NF when each column contains a single atomic value and there are no repeating groups.
In StayEase, each table has separate columns for its attributes and each cell contains one value. For example, the Guests table stores one guest name, phone number, email and ID proof type in separate columns.
Therefore, the StayEase relations satisfy 1NF.

2. Second Normal Form (2NF)

A table is in 2NF when it is already in 1NF and all non-key attributes depend on the whole primary key.
In StayEase, all the tables use a single-column primary key such as guest_id, room_id and reservation_id. Since there is only one attribute in each primary key, there cannot be a partial dependency.
Therefore, the StayEase relations satisfy 2NF.

3. Third Normal Form (3NF)

A table is in 3NF when it is in 2NF and no non-key attribute depends on another non-key attribute.
In the initial design, room details could create a transitive dependency:

room_id → room_type_id
room_type_id → name, capacity, base_price

To avoid this, room type details are stored separately in Room_Types.
Rooms:
room_id → room_no, floor, status, room_type_id
Room_Types:
room_type_id → name, capacity, base_price

Similarly:
reservation_id → guest_id
guest_id → name, phone, email, id_proof_type

Guest details are therefore stored in Guests instead of being repeated in Reservations.

This removes transitive dependencies from the final relations, so the database satisfies 3NF.
