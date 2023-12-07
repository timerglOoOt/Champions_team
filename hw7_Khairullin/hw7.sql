--1
select airport_code, city
from airports_data
where city ->> 'ru' = 'Москва' or city ->> 'ru' = 'Казань'
group by airport_code
order by airport_code desc;

--2
select
'Код аэропорта: ' || airport_code ||
' Название аэропорта: ' || airport_name ||
' Город: ' || city ||
' Координаты: ' || coordinates ||
' Таймзона: ' || timezone
as полная_информация
from airports_data
order by полная_информация;


--3
select departure_airport, count(*) as кол_во_полетов
from flights
where departure_airport in ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
group by departure_airport
order by кол_во_полетов desc;

--4
select departure_airport, count(*) as кол_во_полетов
from flights
where departure_airport not in ('KZN', 'DME', 'OVB', 'IKT', 'LED', 'SVO')
group by departure_airport
order by кол_во_полетов;

--5
select flights.flight_no, count(ticket_flights) as кол_во_пассажиров, flights.scheduled_departure
from flights
join ticket_flights
on ticket_flights.flight_id = flights.flight_id
group by flights.flight_no, flights.scheduled_departure
having count(ticket_flights) between 27 and 90
order by flights.flight_no, flights.scheduled_departure, кол_во_пассажиров desc;

--6
select tickets.passenger_name, flights.departure_airport
from tickets
join ticket_flights on tickets.ticket_no = ticket_flights.ticket_no
join flights on ticket_flights.flight_id = flights.flight_id
order by tickets.passenger_name desc, flights.departure_airport desc;

-- или вот так еще можно

select passenger_name
from tickets
union all
select airport_name
from airports
order by passenger_name desc;

--7
select passenger_name, 'пассажир' as type
from tickets
union all
select airport_name, 'аэропорт' as type
from airports
order by type desc, passenger_name;

--8
select count(flights)
from flights
left join ticket_flights on flights.flight_id = ticket_flights.flight_id
where ticket_flights.flight_id is null;

--9
select airport_name, count(ticket_flights)
from airports_data
join flights on airports_data.airport_code = flights.departure_airport
join ticket_flights on flights.flight_id = ticket_flights.flight_id
group by airport_name


select avg (tt)
FROM (SELECT fligh
    from flights
          COUNT(seats) AS tt FROM seats )
-- from airports_data
join flights on airports_data.airport_code = flights.departure_airport
join aircrafts_data on flights.aircraft_code = aircrafts_data.aircraft_code
join seats on aircrafts_data. aircraft_code = seats.aircraft_code
join ticket_flights on flights.flight_id = ticket_flights.flight_id
-- where (select extract (MONTH FROM scheduled_departure)) = 9
group by airport_name ->> 'ru'