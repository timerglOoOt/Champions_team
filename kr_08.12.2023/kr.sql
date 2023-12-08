
-- 1
select airports_data.airport_name ->> 'ru' as name from airports_data
EXCEPT
SELECT airports_data.city ->> 'ru' from airports_data
order by name;

-- 2
select airports_data.airport_name ->> 'ru' as name from airports_data
INTERSECT
SELECT airports_data.city ->> 'ru' from airports_data
order by name;

-- 3
select flights.aircraft_code, count(*) from flights
join aircrafts_data on flights.aircraft_code = aircrafts_data.aircraft_code
where departure_airport = 'KZN' and (select extract(YEAR from scheduled_departure)) = 2017 and (select extract(Month from scheduled_departure)) = 8
group by flights.aircraft_code
having count(*) > 50
order by count(*) desc, flights.aircraft_code;

-- 4
select * from bookings
join tickets on bookings.book_ref = tickets.book_ref
join ticket_flights on tickets.ticket_no = ticket_flights.ticket_no
join boarding_passes on ticket_flights.ticket_no = boarding_passes.ticket_no and ticket_flights.flight_id = boarding_passes.flight_id
join flights on ticket_flights.flight_id = flights.flight_id
join airports_data on flights.departure_airport = airports_data.airport_code
join aircrafts_data on flights.aircraft_code = aircrafts_data.aircraft_code
join seats on aircrafts_data.aircraft_code = seats.aircraft_code

-- 5
select flights.flight_id
from ticket_flights
         RIGHT JOIN flights on flights.flight_id = ticket_flights.flight_id
where ticket_flights.flight_id is null;

-- 6
select flight_no, sum(ticket_flights.amount) as sum from ticket_flights
join flights on ticket_flights.flight_id = flights.flight_id
group by flight_no, scheduled_departure
having (select extract(YEAR from scheduled_departure)) = 2017 and (select extract(Month from scheduled_departure)) = 8
order by sum desc;

-- 7
select flight_no,
       (select sum(amount) from ticket_flights where ((select extract(YEAR from scheduled_departure)) = 2017 and (select extract(Month from scheduled_departure)) = 8 and flights.flight_id = ticket_flights.flight_id)) as august,
       (select sum(amount) from ticket_flights where ((select extract(YEAR from scheduled_departure)) = 2017 and (select extract(Month from scheduled_departure)) = 9  and flights.flight_id = ticket_flights.flight_id)) as september  from ticket_flights
join flights on ticket_flights.flight_id = flights.flight_id
group by flight_no, scheduled_departure
order by flight_no, september desc , august desc;

-- 8
select tickets.passenger_name from tickets
where passenger_name ilike '%iRiNa%'
group by tickets.passenger_name

-- dop task
