create database airlineReservationSystem;
use airlineReservationSystem;
CREATE TABLE airports (
    airport_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100),
    country VARCHAR(100),
    iata_code CHAR(3) UNIQUE NOT NULL
);

CREATE TABLE flights (
    flight_id SERIAL PRIMARY KEY,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    departure_airport_id INT REFERENCES airports(airport_id),
    arrival_airport_id INT REFERENCES airports(airport_id),
    departure_time TIMESTAMP NOT NULL,
    arrival_time TIMESTAMP NOT NULL,
    aircraft_type VARCHAR(50),
    status VARCHAR(20) DEFAULT 'Scheduled'
);

CREATE TABLE passengers (
    passenger_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    passenger_id INT REFERENCES passengers(passenger_id),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Confirmed'
);

CREATE TABLE tickets (
    ticket_id SERIAL PRIMARY KEY,
    booking_id INT REFERENCES bookings(booking_id),
    flight_id INT REFERENCES flights(flight_id),
    seat_number VARCHAR(5),
    class VARCHAR(20) CHECK (class IN ('Economy', 'Business', 'First')),
    price DECIMAL(10,2) NOT NULL
);

show tables;

INSERT INTO airports (name, city, country, iata_code) VALUES
('Indira Gandhi International Airport', 'Delhi', 'India', 'DEL'),
('Chhatrapati Shivaji Maharaj International Airport', 'Mumbai', 'India', 'BOM'),
('Kempegowda International Airport', 'Bangalore', 'India', 'BLR'),
('Netaji Subhas Chandra Bose International Airport', 'Kolkata', 'India', 'CCU'),
('Rajiv Gandhi International Airport', 'Hyderabad', 'India', 'HYD'),
('Chennai International Airport', 'Chennai', 'India', 'MAA'),
('Sardar Vallabhbhai Patel International Airport', 'Ahmedabad', 'India', 'AMD'),
('Cochin International Airport', 'Kochi', 'India', 'COK'),
('Goa International Airport', 'Goa', 'India', 'GOI'),
('Pune Airport', 'Pune', 'India', 'PNQ');

INSERT INTO flights (flight_number, departure_airport_id, arrival_airport_id, departure_time, arrival_time, aircraft_type, status) VALUES
('AI101', 1, 2, '2025-10-28 08:00', '2025-10-28 10:00', 'Airbus A320', 'Scheduled'),
('AI102', 2, 1, '2025-10-28 14:00', '2025-10-28 16:00', 'Airbus A320', 'Scheduled'),
('6E303', 3, 4, '2025-10-28 09:30', '2025-10-28 11:45', 'Boeing 737', 'Scheduled'),
('UK404', 5, 6, '2025-10-28 07:15', '2025-10-28 09:00', 'ATR 72', 'Scheduled'),
('AI105', 7, 8, '2025-10-28 12:00', '2025-10-28 14:30', 'Airbus A321', 'Scheduled'),
('6E306', 9, 10, '2025-10-28 15:00', '2025-10-28 16:15', 'Boeing 737', 'Scheduled'),
('UK407', 1, 3, '2025-10-28 06:00', '2025-10-28 08:00', 'Airbus A320', 'Scheduled'),
('AI108', 4, 2, '2025-10-28 17:00', '2025-10-28 19:00', 'Boeing 777', 'Scheduled'),
('6E309', 6, 5, '2025-10-28 10:30', '2025-10-28 12:15', 'ATR 72', 'Scheduled'),
('UK410', 8, 7, '2025-10-28 13:00', '2025-10-28 15:00', 'Airbus A321', 'Scheduled');

INSERT INTO passengers (first_name, last_name, email, phone) VALUES
('Rahul', 'Verma', 'rahul.verma@example.com', '9876543210'),
('Priya', 'Sharma', 'priya.sharma@example.com', '9876543211'),
('Amit', 'Patel', 'amit.patel@example.com', '9876543212'),
('Sneha', 'Rao', 'sneha.rao@example.com', '9876543213'),
('Vikram', 'Singh', 'vikram.singh@example.com', '9876543214'),
('Neha', 'Jain', 'neha.jain@example.com', '9876543215'),
('Ravi', 'Kumar', 'ravi.kumar@example.com', '9876543216'),
('Anjali', 'Mehta', 'anjali.mehta@example.com', '9876543217'),
('Karan', 'Joshi', 'karan.joshi@example.com', '9876543218'),
('Divya', 'Nair', 'divya.nair@example.com', '9876543219');

select * from passengers;

INSERT INTO bookings (passenger_id, booking_date, status) VALUES
(1, '2025-10-25 10:00', 'Confirmed'),
(2, '2025-10-25 11:00', 'Confirmed'),
(3, '2025-10-25 12:00', 'Confirmed'),
(4, '2025-10-25 13:00', 'Confirmed'),
(5, '2025-10-25 14:00', 'Confirmed'),
(6, '2025-10-25 15:00', 'Confirmed'),
(7, '2025-10-25 16:00', 'Confirmed'),
(8, '2025-10-25 17:00', 'Confirmed'),
(9, '2025-10-25 18:00', 'Confirmed'),
(10, '2025-10-25 19:00', 'Confirmed');

INSERT INTO tickets (booking_id, flight_id, seat_number, class, price) VALUES
(1, 1, '12A', 'Economy', 4500.00),
(2, 2, '14C', 'Economy', 4500.00),
(3, 3, '10B', 'Business', 8500.00),
(4, 4, '1A', 'First', 12000.00),
(5, 5, '15D', 'Economy', 5000.00),
(6, 6, '16F', 'Economy', 4800.00),
(7, 7, '3C', 'Business', 9000.00),
(8, 8, '2A', 'First', 13000.00),
(9, 9, '18E', 'Economy', 4700.00),
(10, 10, '4B', 'Business', 8800.00);


-- Trigger: Update Booking Status on Ticket Insert (MySQL) -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER trg_update_booking_status
AFTER INSERT ON tickets
FOR EACH ROW
BEGIN
  UPDATE bookings
  SET status = 'Ticketed'
  WHERE booking_id = NEW.booking_id;
END$$

DELIMITER ;


/* Trigger: Delete Tickets When Booking Is Cancelled (MySQL)*/


DELIMITER $$

CREATE TRIGGER trg_cancel_booking
AFTER DELETE ON bookings
FOR EACH ROW
BEGIN
  DELETE FROM tickets
  WHERE booking_id = OLD.booking_id;
END$$

DELIMITER ;


-- Available seats for a given flight ----------------------------------------------------------------

CREATE TABLE seats (
  seat_number VARCHAR(5) PRIMARY KEY
);

-- Generate rows 1 to 30 and columns A to F
INSERT INTO seats (seat_number)
SELECT CONCAT(numbers.n, letters.l) AS seat_number
FROM (
  SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
  UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
  UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15
  UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20
  UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25
  UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30
) AS numbers
JOIN (
  SELECT 'A' AS l UNION SELECT 'B' UNION SELECT 'C'
  UNION SELECT 'D' UNION SELECT 'E' UNION SELECT 'F'
) AS letters;


SELECT s.seat_number
FROM seats s
WHERE s.seat_number NOT IN (
  SELECT seat_number FROM tickets WHERE flight_id = 1
)
ORDER BY s.seat_number;


-- available flights -----------------------------------------------------------------------

SELECT f.flight_number, a1.city AS departure_city, a2.city AS arrival_city,
       f.departure_time, f.arrival_time, f.status
FROM flights f
JOIN airports a1 ON f.departure_airport_id = a1.airport_id
JOIN airports a2 ON f.arrival_airport_id = a2.airport_id
WHERE a1.city = 'Delhi' AND a2.city = 'Mumbai'
  AND DATE(f.departure_time) = '2025-10-28';


-- summary report -------------------------------------------------------------------
SELECT 
  b.booking_id,
  CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
  f.flight_number,
  f.departure_time,
  f.arrival_time,
  t.seat_number,
  t.class,
  t.price,
  b.status
FROM bookings b
JOIN passengers p ON b.passenger_id = p.passenger_id
JOIN tickets t ON b.booking_id = t.booking_id
JOIN flights f ON t.flight_id = f.flight_id
ORDER BY b.booking_id;

