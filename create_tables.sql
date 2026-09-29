USE stayease;

ALTER TABLE room_types
ADD CONSTRAINT chk_room_capacity
CHECK (capacity > 0);

ALTER TABLE room_types
ADD CONSTRAINT chk_room_base_price
CHECK (base_price >= 0);

ALTER TABLE services
ADD CONSTRAINT chk_service_price
CHECK (price >= 0);

ALTER TABLE service_usage
ADD CONSTRAINT chk_service_quantity
CHECK (quantity > 0);

ALTER TABLE payments
ADD CONSTRAINT chk_payment_amount
CHECK (amount >= 0);

ALTER TABLE reviews
ADD CONSTRAINT chk_review_rating
CHECK (rating BETWEEN 1 AND 5);

ALTER TABLE reservations
ADD CONSTRAINT chk_reservation_dates
CHECK (check_out > check_in);