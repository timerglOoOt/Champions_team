SELECT number_of_rooms
FROM rooms
where price_per_night < 3000
ORDER BY price_per_night ASC;

SELECT phone
FROM guests
where gender = false
GROUP BY phone;

SELECT cost
FROM reservations
where cost < 8000
LIMIT 2;