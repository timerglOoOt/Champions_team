Select passenger_name,contact_data from tickets
UNION ALL
SELECT timezone, city from airports_data
ORDER BY passenger_name DESC

Select passenger_name, passenger_id from tickets where passenger_name = 'ZULFIYA ZOTOVA'
limit 1;

Select flight_id, fare_conditions, sum(amount)
from ticket_flights
where exists(select 1 FROM flights where departure_airport = 'KZN')
group by flight_id,fare_conditions;

Select departure_airport,arrival_airport FROM flights as fl1
WHERE EXISTS(select 1 FROM flights as fl2 where fl1.departure_airport = fl2.departure_airport and fl1.arrival_airport = fl2.arrival_airport and fl1.departure_airport < fl1.arrival_airport)
GROUP BY departure_airport, arrival_airport

