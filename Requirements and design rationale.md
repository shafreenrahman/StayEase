# StayEase – Requirements & Design Rationale

## 1. Functional Requirements

Functional requirements describe the functions that the StayEase hotel management database should support.

### 1.1 Guest Management

The system should:

- Store guest details such as guest ID, name, phone number, email and ID proof type.
- Maintain guest information for future stays.
- Allow a guest to make multiple reservations.
- Maintain the guest's stay history.

### 1.2 Room Type Management

The system should:

- Store different room types available in the hotel.
- Store the capacity of each room type.
- Store the base price of each room type.
- Associate multiple individual rooms with a room type.

### 1.3 Room Management

The system should:

- Maintain individual hotel rooms.
- Store room number, floor and room status.
- Associate each room with a room type.
- Track rooms used in reservations.
- Support room availability and occupancy analysis.

### 1.4 Reservation Management

The system should:

- Create reservations for guests.
- Record check-in and check-out dates.
- Associate a reservation with a guest and a room.
- Track the status of a reservation.
- Record the cancellation date when a reservation is cancelled.
- Maintain reservation history.

### 1.5 Payment Management

The system should:

- Record payments made against reservations.
- Store the payment amount.
- Store the payment method.
- Store the payment date.
- Link each payment to the corresponding reservation.
- Support revenue analysis.

### 1.6 Hotel Service Management

The system should:

- Maintain a list of chargeable hotel services.
- Store the name and price of each service.
- Record services used by guests during their stay.
- Store the quantity and date of service usage.
- Link service usage to the corresponding reservation.

Examples of services include restaurant, spa and laundry services.

### 1.7 Employee Management

The system should:

- Maintain employee information.
- Store employee ID, name, role and phone number.
- Associate employees with housekeeping tasks.

### 1.8 Housekeeping Management

The system should:

- Record housekeeping tasks.
- Identify the room associated with each task.
- Assign housekeeping tasks to employees.
- Store the task date.
- Track the status of housekeeping tasks.

### 1.9 Review and Rating Management

The system should:

- Store guest reviews.
- Record ratings given by guests.
- Store comments provided by guests.
- Link reviews to reservations.
- Support analysis of ratings for different room types.

### 1.10 Business Analysis

The database should support queries that answer important hotel management questions, such as:

1. Which room type is booked most often?
2. What is the hotel occupancy rate?
3. What is the average length of stay?
4. What is the revenue by room type?
5. Which guests have stayed more than once?
6. Which room types have the highest ratings?
7. What is the cancellation rate?

The database should also support additional business questions relevant to hotel operations.

## 2. Assumptions

The following assumptions are made for the StayEase database:

1. Each guest has a unique guest_id.
2. Each room has a unique room_id.
3. Each room belongs to one room type.
4. A guest can make multiple reservations over time.
5. A room can have multiple reservations over time.
6. Each reservation is associated with one guest and one room.
7. A reservation can have payment records associated with it.
8. A reservation can use multiple services.
9. A service can be used by multiple reservations.
10. Housekeeping tasks are associated with rooms and assigned to employees.
11. Reviews are associated with reservations.
12. The base price stored for a room type represents its standard room price.

## 3. Design Rationale

Design rationale explains the important design decisions made while designing the StayEase database and why they were chosen.

### 3.1 Separation of Room Types and Rooms

The room_types and rooms tables are kept separate because a room type represents a category of rooms, while a room represents an individual physical room.

For example, several rooms can belong to the same room type. This avoids repeating information such as room capacity and base price for every individual room.

### 3.2 Separation of Guests and Reservations

Guest information and reservation information are stored in separate tables because a guest can make multiple reservations over time.

Keeping them separate avoids unnecessary repetition of guest details and allows the database to maintain the complete reservation history of each guest.

### 3.3 Use of Service Usage

Reservations and services can have a many-to-many relationship. One reservation can use multiple services, and the same service can be used by multiple reservations.

Therefore, the service_usage table is used as an intermediate table to represent this relationship and store details such as quantity and date of usage.

### 3.4 Separate Payment Table

Payments are stored separately from reservations because payment information is different from booking information.

The payments table stores the payment amount, payment method and payment date and links each payment to the corresponding reservation. This also makes revenue analysis easier.

### 3.5 Separate Employee and Housekeeping Tables

Employee information and housekeeping task information are stored separately.

The employees table stores employee details, while the housekeeping table stores information about individual housekeeping tasks. This prevents employee details from being unnecessarily repeated for every task.

### 3.6 Separate Review Table

Reviews are stored separately because ratings and comments are different from reservation details.

The reviews table allows the system to store guest feedback and perform analysis such as calculating average ratings for different room types.

### 3.7 Addition of Cancellation Date

The cancellation_date attribute is included in the reservations table to record the date on which a reservation was cancelled.

The reservation status indicates the current state of the reservation, while cancellation_date provides additional information about when the cancellation occurred.

This is useful for calculating the cancellation rate and performing cancellation-related analysis.

### 3.8 Use of Primary and Foreign Keys

Primary keys are used to uniquely identify records in each table, such as guest_id, room_id, reservation_id, payment_id, service_id, employee_id and review_id.

Foreign keys are used to establish relationships between related tables. For example, a reservation contains references to the guest and room associated with it.

This helps maintain referential integrity and ensures that related records remain consistent.

### 3.9 Normalized Database Structure

The database is divided into separate related tables instead of storing all hotel information in one large table.

This reduces data redundancy and helps prevent insertion, update and deletion anomalies.

The design is intended to be normalized up to Third Normal Form (3NF), as required by the project..
