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
  queries.sql                     -> SQL for all business questions (Q1-Q10), each with a comment
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

| Table | Primary Key | Foreign Keys | Key Attributes |
|---|---|---|---|
| **guests** | guest_id | — | name, phone, email, id_proof_type, id_proof_no |
| **room_types** | room_type_id | — | name, capacity, base_price |
| **rooms** | room_id | room_type_id → room_types | room_no, floor, status |
| **reservations** | reservation_id | guest_id → guests, room_id → rooms | check_in, check_out, status, guest_count, rate_applied |
| **payments** | payment_id | reservation_id → reservations | amount, method, paid_on |
| **services** | service_id | — | name, price |
| **service_usage** | usage_id | reservation_id → reservations, service_id → services | quantity, used_on, unit_price |
| **employees** | employee_id | — | name, role, phone |
| **housekeeping** | task_id | room_id → rooms, employee_id → employees | task_date, status |
| **reviews** | review_id | reservation_id → reservations | rating, comment |

Full column-level definitions, data types, and constraints (`NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`, `ON DELETE` / `ON UPDATE`) are in `schema/create_tables.sql`.

## Relationships

- **room_types → rooms** (1:N) — a room type has many rooms
- **guests → reservations** (1:N) — a guest can make many reservations
- **rooms → reservations** (1:N) — a room has many reservations over time, but only one active reservation at a time
- **reservations → payments** (1:N) — a reservation can have multiple payments (e.g. partial payments)
- **reservations ↔ services** (M:N) — resolved by the **service_usage** bridge table
- **employees → housekeeping** (1:N) — an employee can be assigned many housekeeping tasks
- **rooms → housekeeping** (1:N) — a room can have many housekeeping tasks over time
- **reservations → reviews** (1:1) — at most one review per completed stay

## Key Design Decisions

- **`reservations.rate_applied`** stores the room's price *at the time of booking*. If `room_types.base_price` changes later, past reservations keep their original rate — this keeps revenue queries (Q4) accurate and matches how real hotel billing works.
- **`service_usage.unit_price`** does the same for services — a spa price change won't silently rewrite the cost of a past stay.
- **`guests.id_proof_no`** was added alongside `id_proof_type`, since an ID type without a number isn't useful for identity verification.
- **No stored `total_amount` or `nights` columns.** Both are derivable from `check_in` / `check_out` and line items, so storing them would violate 3NF (a derived/transitive dependency) and risk going stale. They are computed in queries instead.
- **One room per reservation.** A multi-room booking is modeled as multiple reservation rows rather than a multi-room reservation, keeping the schema simple and the cardinalities clean (see [Assumptions](#assumptions)).

## Normalisation

The schema is normalised up to Third Normal Form (3NF):

- **1NF:** every column holds a single atomic value; no repeating groups (e.g. services used during a stay live in their own `service_usage` rows, not as a list in `reservations`).
- **2NF:** every non-key attribute depends on the *whole* primary key — relevant mainly to the bridge table `service_usage`, where `quantity` and `unit_price` depend on the combination of `reservation_id` and `service_id`, not on either alone.
- **3NF:** no non-key attribute depends on another non-key attribute. This is why computed values like total stay cost aren't stored as columns.

The full functional-dependency analysis and 1NF→2NF→3NF walkthrough for every table is documented in `docs/normalisation.md`.

## Setup

Run the following in order; each script depends on the one before it:

```bash
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
