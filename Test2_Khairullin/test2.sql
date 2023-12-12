--1
select airport_name ->> 'ru' as название
from airports_data
except
select city ->> 'ru'
from airports_data
order by название;

--2
select airport_name ->> 'ru' as название
from airports_data
intersect
select city ->> 'ru'
from airports_data
order by название;

--3
select aircrafts_data.aircraft_code, count(flights) as кол_во
from flights
join aircrafts_data on flights.aircraft_code = aircrafts_data.aircraft_code
where flights.departure_airport = 'KZN' and extract(YEAR from flights.scheduled_departure) = 2017
and extract(Month from flights.scheduled_departure) = 8
group by aircrafts_data.aircraft_code
having count(flights) > 50
order by кол_во desc, aircrafts_data.aircraft_code;

--4
select *
from airports_data
inner join flights on airports_data.airport_code = flights.departure_airport
inner join aircrafts_data on flights.aircraft_code = aircrafts_data.aircraft_code
inner join seats on aircrafts_data.aircraft_code = seats.aircraft_code
inner join ticket_flights on flights.flight_id = ticket_flights.flight_id
inner join boarding_passes on ticket_flights.ticket_no = boarding_passes.ticket_no
inner join tickets on ticket_flights.ticket_no = tickets.ticket_no
inner join bookings on tickets.book_ref = bookings.book_ref;

--5
select flights.flight_no
from ticket_flights
right join flights on flights.flight_id = ticket_flights.flight_id
where ticket_flights.flight_id is null;

--6
select flight_no, sum(ticket_flights.amount) as выручка
from ticket_flights
join flights on ticket_flights.flight_id = flights.flight_id
where extract(YEAR from flights.scheduled_departure) = 2017
and extract(Month from flights.scheduled_departure) = 8
group by flight_no, scheduled_departure
order by выручка desc;

--7
<<<<<<< HEAD
select flight_no,
    sum(case when extract(month from scheduled_departure) = 8 then amount else 0 end) as august,
    sum(case when extract(month from scheduled_departure) = 9 then amount else 0 end) as september
from flights
join ticket_flights on ticket_flights.flight_id = flights.flight_id
where extract(year from scheduled_departure) = 2017
and (extract(month from scheduled_departure) = 8
or extract(month from scheduled_departure) = 9)
group by flight_no
order by september desc , august desc, flight_no;
=======

>>>>>>> parent of 1901a07 (feat: add 7 task solution)

--8
--Первая реализация
select distinct passenger_name
from tickets
where passenger_name ilike '%iRiNa%';

--Вторая реализация
select passenger_name
from tickets
where passenger_name ilike '%iRiNa%'
group by passenger_name;