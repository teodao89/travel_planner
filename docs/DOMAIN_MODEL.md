# Travel Planner - Domain Model

## Obiettivo

Definire le entità principali dell'app prima di introdurre il database.

---

## Entità principali

- Trip
- Stop
- Expense
- Hotel
- Flight
- Document

---

## Trip

Rappresenta un viaggio.

Campi:

- id
- title
- destination
- emoji
- color
- status
- startDate
- endDate
- budget
- coverImage
- notes
- createdAt
- updatedAt

---

## Stop

Rappresenta una tappa del viaggio.

Campi:

- id
- tripId
- title
- description
- address
- latitude
- longitude
- arrivalTime
- departureTime
- category
- order

---

## Expense

Rappresenta una spesa.

Campi:

- id
- tripId
- title
- amount
- currency
- category
- date
- notes

---

## Hotel

Rappresenta una prenotazione hotel.

Campi:

- id
- tripId
- name
- address
- checkIn
- checkOut
- bookingReference
- phone
- email
- price
- notes

---

## Flight

Rappresenta un volo.

Campi:

- id
- tripId
- airline
- flightNumber
- departureAirport
- arrivalAirport
- departureTime
- arrivalTime
- terminal
- gate
- seat
- bookingReference
- notes

---

## Document

Rappresenta un documento allegato.

Campi:

- id
- tripId
- title
- filePath
- type
- createdAt

---

## Relazioni

Un Trip può avere:

- molte Stop
- molte Expense
- molti Hotel
- molti Flight
- molti Document

Ogni entità secondaria contiene `tripId`.