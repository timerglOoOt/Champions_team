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

-- или вот так еще можно (это вроде то, что по условию нужно)

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
with seats_count as (
    select aircrafts_data.aircraft_code, count(seats) as seats_count
    from aircrafts_data
    join seats on aircrafts_data.aircraft_code = seats.aircraft_code
    group by aircrafts_data.aircraft_code
),
tickets_count as (
    select flights.flight_id, count(ticket_flights) as tickets_count
    from flights
    join ticket_flights on flights.flight_id = ticket_flights.flight_id
    group by flights.flight_id
)
select departure_airport, avg(seats_count.seats_count) as средняя_вместимость, avg(tickets_count.tickets_count) as среднее_кол_во_билетов
from flights
join seats_count on flights.aircraft_code = seats_count.aircraft_code
join tickets_count on flights.flight_id = tickets_count.flight_id
where extract(month from scheduled_departure) = 8 and extract(year from scheduled_departure) = 2017
group by departure_airport
order by средняя_вместимость desc, среднее_кол_во_билетов desc;



--10
select flight_no, min(ticket_flights.amount) as минимальная_цена, max(ticket_flights.amount) as максимальная_цена
from flights
join ticket_flights on flights.flight_id = ticket_flights.flight_id
group by flight_no;