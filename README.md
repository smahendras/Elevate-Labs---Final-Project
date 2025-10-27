# Elevate-Labs---Final-Project
created a Airline Reservation System


## 📄 README.md — Airline Flight and Booking Management System

```markdown
# ✈️ Airline Flight and Booking Management System

A relational database project built in MySQL to manage airline operations including flights, passengers, bookings, and ticketing. This system is designed for educational and practical use, demonstrating SQL schema design, data integrity, automation with triggers, and reporting.

---

## 📦 Features

- Manage airports, flights, passengers, bookings, and tickets
- Generate seat maps and track seat availability
- Automate booking status updates and ticket cleanup using triggers
- Search flights by route and date
- Generate booking summary reports with passenger and flight details

---

## 🛠️ Tools Used

- **MySQL 8.0+**
- **SQL Workbench / phpMyAdmin**
- **DDL & DML Statements**
- **Triggers & Views**

---

## 🧱 Schema Overview

- `airports`: Stores airport details
- `flights`: Flight schedules and aircraft info
- `passengers`: Passenger profiles
- `bookings`: Booking records linked to passengers
- `tickets`: Seat assignments and pricing
- `seats`: Static seat map (`1A` to `30F`)

---

## 🚀 Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/airline-booking-system.git
   ```

2. Import the SQL schema:
   - Open MySQL Workbench or phpMyAdmin
   - Run `schema.sql` to create tables

3. Insert sample data:
   - Run `sample_data.sql` to populate tables

4. Optional: Run `triggers.sql` to enable booking automation

---

## 🔍 Sample Queries

- **Available Seats for a Flight**
  ```sql
  SELECT seat_number
  FROM seats
  WHERE seat_number NOT IN (
    SELECT seat_number FROM tickets WHERE flight_id = 1
  );
  ```

- **Flight Search**
  ```sql
  SELECT flight_number, departure_time, arrival_time
  FROM flights
  WHERE departure_airport_id = 1 AND arrival_airport_id = 2
    AND DATE(departure_time) = '2025-10-28';
  ```

- **Booking Summary Report**
  ```sql
  SELECT b.booking_id, CONCAT(p.first_name, ' ', p.last_name) AS passenger_name,
         f.flight_number, t.seat_number, t.class, t.price, b.status
  FROM bookings b
  JOIN passengers p ON b.passenger_id = p.passenger_id
  JOIN tickets t ON b.booking_id = t.booking_id
  JOIN flights f ON t.flight_id = f.flight_id;
  ```

---

## 📌 Future Enhancements

- Aircraft-specific seat layouts
- Dynamic pricing and fare classes
- Loyalty program integration
- REST API for frontend integration

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).

---

## 🙌 Author

**Mahendra**  
Patient, practical, and passionate about building secure, well-documented SQL systems.



