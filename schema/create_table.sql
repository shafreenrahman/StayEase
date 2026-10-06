CREATE DATABASE stayease;
USE stayease;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    id_proof_type VARCHAR(50)
);

CREATE TABLE room_types (
    room_type_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    capacity INT NOT NULL,
    base_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY,
    room_no VARCHAR(10) NOT NULL UNIQUE,
    floor INT NOT NULL,
    status VARCHAR(30) NOT NULL,
    room_type_id INT NOT NULL,
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
);

CREATE TABLE services (
    service_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    phone VARCHAR(15)
);

CREATE TABLE reservations (
    reservation_id INT PRIMARY KEY,
    guest_id INT NOT NULL,
    room_id INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    cancellation_date DATE,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE service_usage (
    usage_id INT PRIMARY KEY,
    reservation_id INT NOT NULL,
    service_id INT NOT NULL,
    quantity INT NOT NULL,
    used_on DATE NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    reservation_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    method VARCHAR(30) NOT NULL,
    paid_on DATE NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    reservation_id INT NOT NULL UNIQUE,
    rating INT NOT NULL,
    comment VARCHAR(500),
    CONSTRAINT fk_reviews_reservation
        FOREIGN KEY (reservation_id)
        REFERENCES reservations(reservation_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE housekeeping (
    task_id INT PRIMARY KEY,
    room_id INT NOT NULL,
    employee_id INT NOT NULL,
    task_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (room_id) REFERENCES rooms(room_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
