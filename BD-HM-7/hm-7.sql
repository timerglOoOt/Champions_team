--  A
Select airport_code, coordinates
from airports_data
where city ->> 'ru' = 'Казань'
   or city ->> 'ru' = 'Москва'
ORDER BY airport_code DESC;

-- B
Select airports_data.airport_code || airports_data.city || airports_data.coordinates || airports_data.timezone ||
       airports_data.airport_code as "полная информация"
from airports_data
ORDER BY "полная информация";


-- C
select airports_data.airport_name ->> 'ru', count(*)
from flights
         join airports_data on airport_code = departure_airport
where flights.departure_airport in ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
group by airports_data.airport_name
ORDER BY count(*) Desc;

-- D
select airports_data.airport_name ->> 'ru', count(*)
from flights
         join airports_data on airport_code = departure_airport
where flights.departure_airport not in ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
group by airports_data.airport_name
ORDER BY count(*);

-- E
select flights.flight_no, flights.scheduled_departure, count(ticket_flights)
from flights
         JOIN ticket_flights on flights.flight_id = ticket_flights.flight_id
group by flights.flight_no, scheduled_departure
HAVING count(ticket_flights) between 27 and 90
ORDER BY flight_no DESC, scheduled_departure DESC, count(ticket_flights) DESC;

-- F
select tickets.passenger_name as element
from tickets
UNION ALL
select airports_data.airport_name ->> 'ru'
from airports_data
ORDER BY element DESC;

-- G
select tickets.passenger_name as element, 'Пассажир' type
from tickets
UNION ALL
select airports_data.airport_name ->> 'ru', 'Аэропорт'
from airports_data
ORDER BY type DESC, element DESC;

-- H
select count(*)
from flights
         LEFT JOIN ticket_flights on flights.flight_id = ticket_flights.flight_id
where ticket_flights.flight_id is null;

-- I
select airport_name ->> 'ru' as airport_name,
            (
                Select AVG(param)
                FROM (
                    select count(seats) as param from seats
                    join aircrafts_data on seats.aircraft_code = aircrafts_data.aircraft_code
                    join flights on aircrafts_data.aircraft_code = flights.aircraft_code
                    join airports_data as air on flights.departure_airport = air.airport_code
                    where air.airport_code = airports_data.airport_code and (select extract(MONTH FROM scheduled_departure)) = 9
                    group by flight_id
                ) as alias
            ) as average_seats,
            (
                Select AVG(param)
                FROM (
                    select count(ticket_flights) as param from ticket_flights
                    join flights on ticket_flights.flight_id = flights.flight_id
                    join airports_data as air on flights.departure_airport = air.airport_code
                    where air.airport_code = airports_data.airport_code and (select extract(MONTH FROM scheduled_departure)) = 9
                    group by flights.flight_id
                ) as alias
            ) as average_tickets
    from airports_data
    -- where (select extract(MONTH FROM scheduled_departure)) = 9
    group by airport_name ->> 'ru', airport_code
    order by average_seats desc, average_tickets desc;

-- J
Select flight_no, min(amount) as min_price, max(amount) as max_price from ticket_flights
join flights on ticket_flights.flight_id = flights.flight_id
group by flight_no
order by flight_no;

--  some trying
-- select avg(gg) from (
-- select seats.aircraft_code, count(seats) as gg from seats
-- group by aircraft_code );
--
--                 SELECT AVG(ticket_flights.amount) AS param
--                 FROM ticket_flights
--                 GROUP BY  ticket_flights.flight_id
--                 ORDER BY ticket_flights.flight_id DESC
--                 limit 3
--
--
--                 select * from flights
--                 join airports_data on flights.departure_airport = airports_data.airport_code
--                 where departure_airport='LPK'