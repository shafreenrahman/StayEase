# StayEase — Hotel Reservation and Operations Database

This repository contains our DBMS course project (Team 7). We designed and implemented a relational database for a hotel, StayEase, covering guest profiles, room types and rooms, reservations, payments, services, housekeeping, and reviews, consolidated into a single connected system that supports both front-desk and back-office operations.

## Team 7

| Name | USN |
|---|---|
| Pavan Kumar | AU25UG-069 |
| Praneeth Reddy | AU25UG-044 |
| S Mohammed Abrar ul Haq | AU25UG-048 |
| Sanghavi S | AU25UG-071 |
| Sanika B Raj | AU25UG-052 |
| Shafreen | AU25UG-079 |

## Overview

A hotel's daily operations depend on accurate data about room availability, reservations, guest stays, billing, in-house services, and housekeeping. Overbooked rooms, missed service charges, and uncleaned rooms all come from poor data management. StayEase is a relational database that supports both the front desk (reservations and billing) and back-office operations (staff and housekeeping), modeling the hotel as 10 connected tables rather than scattered spreadsheets.

## Problem Statement

A mid-sized hotel currently tracks guests, bookings, billing, and housekeeping across disconnected spreadsheets. This leads to:

- Rooms being booked twice for overlapping dates
- Guest service charges (restaurant, spa, laundry) going unrecorded and unbilled
- No single view of a room's cleaning status, leading to rooms being assigned before they're ready
- No easy way to answer basic operational questions — occupancy rate, most popular room type, repeat guests — without manually cross-referencing multiple files

StayEase solves this by putting all of this data into one normalised relational database, so that every reservation, payment, service charge, and housekeeping task is consistently linked back to the room, guest, and staff member involved.

## Scope of the System

The database supports the following core functions:

- Maintain guest profiles and stay history
- Define room types with pricing and track individual rooms against them
- Manage reservations from booking through check-in, check-out, and cancellation
- Record payments and charges for services used (restaurant, spa, laundry)
- Maintain employees and assign housekeeping tasks
- Capture guest reviews and ratings

## Built With

- **RDBMS:** MySQL 8.0+ (also compatible with PostgreSQL / SQL Server with minor syntax changes)
- **Note:** `CHECK` constraints are only enforced from MySQL 8.0.16 onward — use that version or later locally
- **Diagramming:** draw.io / dbdiagram.io for the ER and relational schema diagrams

## Folder Structure

```
schema/
  create_tables.sql             -> DDL: creates the database, all 10 tables, and constraints
data/
  insert_data.sql                -> DML: sample data for every table
queries/
  queries.sql                     -> SQL for all business questions (Q1-Q15), each with a comment
diagrams/
  er_diagram.png                   -> Entity-Relationship diagram
  relational_schema.png            -> Relational schema / table diagram
docs/
  requirements_and_design_rationale.md  -> Functional requirements, assumptions, and design decisions
  normalisation.md                       -> Functional dependencies and 1NF-3NF walkthrough
  project_report.pdf                     -> Full project report
README.md
```

## Entity–Relationship Diagram

The ER diagram (`diagrams/er_diagram.png`) shows all 10 entities, their attributes, and the cardinality and participation constraints of every relationship. The relational schema diagram (`diagrams/relational_schema.png`) shows the same design after mapping to tables, with primary and foreign keys marked.

## Database Schema

## Database Schema

| Table | Primary Key | Foreign Keys | Key Attributes |
|---|---|---|---|
| **guests** | guest_id | — | name, phone, email, id_proof_type |
| **room_types** | room_type_id | — | name, capacity, base_price |
| **rooms** | room_id | room_type_id → room_types | room_no, floor, status |
| **reservations** | reservation_id | guest_id → guests, room_id → rooms | check_in, check_out, status, cancellation_date |
| **payments** | payment_id | reservation_id → reservations | amount, method, paid_on |
| **services** | service_id | — | name, price |
| **service_usage** | usage_id | reservation_id → reservations, service_id → services | quantity, used_on |
| **employees** | employee_id | — | name, role, phone |
| **housekeeping** | task_id | room_id → rooms, employee_id → employees | task_date, status |
| **reviews** | review_id | reservation_id → reservations | rating, comment |

Full column-level definitions, data types, and constraints (`NOT NULL`, `UNIQUE`, `CHECK`, `ON DELETE` / `ON UPDATE`) are in `schema/create_tables.sql`.

## Relationships

- **room_types → rooms** (1\:N) — a room type has many rooms
- **guests → reservations** (1\:N) — a guest can make many reservations
- **rooms → reservations** (1\:N) — a room can have many reservations over time, and each reservation refers to one room
- **reservations → payments** (1\:N) — a reservation can have multiple payments (e.g. partial payments)
- **reservations ↔ services** (M\:N) — resolved by the **service_usage** bridge table
- **employees → housekeeping** (1\:N) — an employee can be assigned many housekeeping tasks
- **rooms → housekeeping** (1\:N) — a room can have many housekeeping tasks over time
- **reservations → reviews** (1:1) — a reservation can have at most one review

## Key Design Decisions

- **One room per reservation.** Each reservation is linked to exactly one room. A multi-room booking is represented using multiple reservation records, keeping the schema simple and the relationships clear.
- **Reservations are linked to guests and rooms using foreign keys.** This maintains referential integrity and ensures that each reservation references an existing guest and room.
- **Services and reservations have a many-to-many relationship**, resolved through the `service_usage` bridge table. This allows a reservation to use multiple services and a service to be used across multiple reservations.
- **Reviews have a 1:1 relationship with reservations.** Each reservation can have at most one review, enforced through a `UNIQUE` constraint on `reviews.reservation_id`.
- **No stored `total_amount` or `nights` columns.** These values can be calculated from the reservation dates and service usage when required, avoiding unnecessary duplication and reducing the risk of inconsistent stored values.

## Normalisation

The schema is normalised up to Third Normal Form (3NF):

- **1NF:** every column holds a single atomic value, and there are no repeating groups. For example, services used during a stay are stored as separate rows in `service_usage` rather than as a list inside `reservations`.
- **2NF:** every non-key attribute depends on the whole primary key. In the implemented schema, tables use single-column primary keys such as `guest_id`, `reservation_id`, and `usage_id`. Therefore, partial dependencies cannot occur.
- **3NF:** no non-key attribute depends on another non-key attribute. Related information is separated into appropriate tables, such as storing room type details in `room_types` and guest details in `guests` rather than repeating them in `rooms` or `reservations`. Derived values such as stay duration and service revenue are calculated through queries rather than stored separately, reducing redundancy and the risk of inconsistent values.

The full functional-dependency analysis and 1NF→2NF→3NF walkthrough for every table is documented in `docs/normalisation.md`.

## Setup

Run the following scripts in order. Each script depends on the one before it:

```
mysql -u your_username -p < schema/create_tables.sql
mysql -u your_username -p < data/insert_data.sql
mysql -u your_username -p < queries/queries.sql
```

`schema/create_tables.sql` creates the database and all tables from scratch. If a `stayease` database already exists locally, back it up before running this script.

## Business Questions

Required by the project brief:

| No. | Business Question | SQL Concepts |
|---|---|---|
| Q1 | Which room type is booked most often? | JOIN, COUNT, GROUP BY |
| Q2 | What is the hotel occupancy rate? | Occupied room-nights ÷ available room-nights |
| Q3 | What is the average length of stay? | Date difference, AVG |
| Q4 | What is the revenue by room type? | Multi-table JOIN, SUM |
| Q5 | Which guests have stayed more than once? | GROUP BY, HAVING COUNT > 1 |
| Q6 | Which room types have the highest ratings? | AVG rating via reservations, ranking |
| Q7 | What is the cancellation rate? | Conditional aggregation using CASE |

Added by the team:

| No. | Business Question | SQL Concepts |
|---|---|---|
| Q8 | Which services generate the most revenue? | JOIN, SUM, GROUP BY |
| Q9 | Which employees have completed the most housekeeping tasks? | COUNT, GROUP BY, CASE |
| Q10 | What is the average turnaround time between check-out and the room being marked clean? | Date difference, AVG, subquery |

The SQL for all ten queries is in `queries/queries.sql`, each preceded by a short comment naming the question it answers.

## Sample Data

`data/insert_data.sql` populates every table with realistic sample data — enough guests, rooms, and reservations (including some overlapping dates, cancellations, and repeat guests) to produce meaningful, non-trivial results for all ten business questions.

## Assumptions

- Each reservation is for exactly one room; a booking spanning multiple rooms is entered as separate reservation rows.
- A reservation can have more than one payment row (e.g. a deposit and a final settlement), but the sum of payments is expected to match the billed amount.
- A review can only be left against a reservation that has reached `checked_out` status.
- Room `status` (e.g. available, occupied, under maintenance) is maintained independently of reservation dates and is updated as part of check-in/check-out, not derived automatically.

## Design Notes

The database is normalised up to 3NF. The many-to-many relationship between reservations and services is resolved through a dedicated bridge table (`service_usage`) rather than a repeating-group or comma-separated column. Room price and service price at the time of use are captured on the reservation and usage records themselves, rather than only referenced from `room_types` and `services`, so that later price changes don't alter the billing history of past stays. The full reasoning behind these and other decisions is documented in `docs/requirements_and_design_rationale.md`.

## Team Contributions

- **GitHub repository, README, Requirements & Design Rationale** — Shafreen
- **SQL queries and normalisation** — Sanghavi
- **Schema and constraints** — Sanika
- **Implementation and sample data** — Pavan
- **Report and documentation** — Abrar
- **ER diagrams** — Praneeth
